/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Copyright (c) 2015,2016 The plumed team
   (see the PEOPLE file at the root of the distribution for a list of names)

   See http://www.plumed.org for more information.

   This file is part of plumed, version 2.

   plumed is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   plumed is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with plumed.  If not, see <http://www.gnu.org/licenses/>.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
#include "HistogramOnGrid.h"
#include "tools/KernelFunctions.h"

namespace PLMD {
namespace gridtools {

void HistogramOnGrid::registerKeywords( Keywords& keys ){
  GridVessel::registerKeywords( keys );
  keys.add("compulsory","KERNEL","the type of kernel to use");
  keys.add("compulsory","BANDWIDTH","the bandwidths");
}

HistogramOnGrid::HistogramOnGrid( const vesselbase::VesselOptions& da ):
GridVessel(da),
neigh_tot(0),
addOneKernelAtATime(false),
bandwidths(dimension),
discrete(false)
{
  parse("KERNEL",kerneltype); 
  if( kerneltype=="discrete" || kerneltype=="DISCRETE" ){
      discrete=true; setNoDerivatives();
  } else {
      parseVector("BANDWIDTH",bandwidths);
  }
}

bool HistogramOnGrid::noDiscreteKernels() const {
  return !discrete;
}

void HistogramOnGrid::setBounds( const std::vector<std::string>& smin, const std::vector<std::string>& smax,
                                 const std::vector<unsigned>& nbins, const std::vector<double>& spacing ){
  GridVessel::setBounds( smin, smax, nbins, spacing );
  if( !discrete ){ 
      std::vector<double> point(dimension,0);
      KernelFunctions kernel( point, bandwidths, kerneltype, false, 1.0, true ); neigh_tot=1;
      nneigh=kernel.getSupport( dx ); std::vector<double> support( kernel.getContinuousSupport() );
      for(unsigned i=0;i<dimension;++i){
          if( pbc[i] && 2*support[i]>getGridExtent(i) ) error("bandwidth is too large for periodic grid");
          neigh_tot *= (2*nneigh[i]+1); 
      } 
  }
}

KernelFunctions* HistogramOnGrid::getKernelAndNeighbors( std::vector<double>& point, unsigned& num_neigh, std::vector<unsigned>& neighbors ) const {
  if( discrete ){ 
     num_neigh=1; for(unsigned i=0;i<dimension;++i) point[i] += 0.5*dx[i];
     neighbors[0] = getIndex( point ); return NULL;
  } else {
     KernelFunctions* kernel = new KernelFunctions( point, bandwidths, kerneltype, false, 1.0, true ); 
     getNeighbors( kernel->getCenter(), nneigh, num_neigh, neighbors ); 
     return kernel;
  }
}

std::vector<Value*> HistogramOnGrid::getVectorOfValues() const {
  std::vector<Value*> vv;
  for(unsigned i=0;i<dimension;++i){
      vv.push_back(new Value());
      if( pbc[i] ) vv[i]->setDomain( str_min[i], str_max[i] );
      else vv[i]->setNotPeriodic();
  }
  return vv;
}

void HistogramOnGrid::calculate( const unsigned& current, MultiValue& myvals, std::vector<double>& buffer, std::vector<unsigned>& der_list ) const {
  if( addOneKernelAtATime ){
     plumed_dbg_assert( myvals.getNumberOfValues()==2 );
     std::vector<double> der( dimension ); 
     for(unsigned i=0;i<dimension;++i) der[i]=myvals.getDerivative( 1, i );
     accumulate( getAction()->getPositionInCurrentTaskList(current), myvals.get(0), myvals.get(1), der, buffer );
  } else {
     plumed_dbg_assert( myvals.getNumberOfValues()==dimension+2 );
     std::vector<double> point( dimension ); double weight=myvals.get(0)*myvals.get( 1+dimension );
     for(unsigned i=0;i<dimension;++i) point[i]=myvals.get( 1+i );

     // Get the kernel
     unsigned num_neigh; std::vector<unsigned> neighbors; 
     std::vector<double> der( dimension ); 
     KernelFunctions* kernel=getKernelAndNeighbors( point, num_neigh, neighbors );

     if( !kernel ){
         plumed_dbg_assert( num_neigh==1 );
         accumulate( neighbors[0], weight, 1.0, der, buffer );
     } else {
         std::vector<Value*> vv( getVectorOfValues() );

         double newval; std::vector<double> xx( dimension );
         for(unsigned i=0;i<num_neigh;++i){
             unsigned ineigh=neighbors[i];
             if( inactive( ineigh ) ) continue ;
             getGridPointCoordinates( ineigh, xx );
             for(unsigned j=0;j<dimension;++j) vv[j]->set(xx[j]);
             newval = kernel->evaluate( vv, der, true );
             accumulate( ineigh, weight, newval, der, buffer );
         }
         delete kernel;
         for(unsigned i=0;i<dimension;++i) delete vv[i];
     }
  }
}

void HistogramOnGrid::accumulate( const unsigned& ipoint, const double& weight, const double& dens, const std::vector<double>& der, std::vector<double>& buffer ) const {
  buffer[bufstart+nper*ipoint] += weight*dens; 
  if( der.size()>0 ) for(unsigned j=0;j<dimension;++j) buffer[bufstart+nper*ipoint + 1 + j] += weight*der[j]; 
}

void HistogramOnGrid::finish( const std::vector<double>& buffer ){
  if( addOneKernelAtATime ){
     for(unsigned i=0;i<getAction()->getCurrentNumberOfActiveTasks();++i){ 
         for(unsigned j=0;j<nper;++j) addDataElement( nper*getAction()->getActiveTask(i)+j, buffer[bufstart+i*nper+j] ); 
     }
  } else {
     GridVessel::finish( buffer );
  }
}

}
}
