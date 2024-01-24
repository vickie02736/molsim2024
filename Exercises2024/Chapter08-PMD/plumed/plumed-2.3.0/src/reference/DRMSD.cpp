/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Copyright (c) 2013-2016 The plumed team
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
#include "DRMSD.h"
#include "MetricRegister.h"
#include "tools/Pbc.h"

namespace PLMD {

PLUMED_REGISTER_METRIC(DRMSD,"DRMSD")

DRMSD::DRMSD( const ReferenceConfigurationOptions& ro ):
ReferenceConfiguration( ro ),
SingleDomainRMSD( ro ),
nopbc(true),
bounds_were_set(false),
lower(0),
upper(std::numeric_limits<double>::max( ))
{
}

void DRMSD::setBoundsOnDistances( bool dopbc, double lbound, double ubound ){
  bounds_were_set=true; nopbc=!dopbc; 
  lower=lbound; upper=ubound;
}

void DRMSD::readBounds(){
  parseFlag("NOPBC",nopbc);  
  parse("LOWER_CUTOFF",lower,true);
  parse("UPPER_CUTOFF",upper,true);
  setBoundsOnDistances( !nopbc, lower, upper );
}

void DRMSD::read( const PDB& pdb ){
  readAtomsFromPDB( pdb ); readBounds(); setup_targets();
}

void DRMSD::setReferenceAtoms( const std::vector<Vector>& conf, const std::vector<double>& align_in, const std::vector<double>& displace_in ){
  SingleDomainRMSD::setReferenceAtoms( conf, align_in, displace_in );
  setup_targets();
}

void DRMSD::setup_targets(){
  plumed_massert( bounds_were_set, "I am missing a call to DRMSD::setBoundsOnDistances");

  unsigned natoms = getNumberOfReferencePositions();
  for(unsigned i=0;i<natoms-1;++i){
      for(unsigned j=i+1;j<natoms;++j){
          double distance = delta( getReferencePosition(i), getReferencePosition(j) ).modulo();
          if(distance < upper && distance > lower ){
              targets[std::make_pair(i,j)] = distance;
          }
       }
  }
  if( targets.empty() ) error("drmsd will compare no distances - check upper and lower bounds are sensible");  
}

double DRMSD::calc( const std::vector<Vector>& pos, const Pbc& pbc, ReferenceValuePack& myder, const bool& squared ) const {
  plumed_dbg_assert(!targets.empty());

  Vector distance; 
  myder.clear(); 
  double drmsd=0.; 
  for(std::map< std::pair <unsigned,unsigned> , double>::const_iterator it=targets.begin();it!=targets.end();++it){
      
      const unsigned i=getAtomIndex( it->first.first );
      const unsigned j=getAtomIndex( it->first.second );

      if(nopbc) distance=delta( pos[i] , pos[j] ); 
      else      distance=pbc.distance( pos[i] , pos[j] );

      const double len = distance.modulo();
      const double diff = len - it->second;
      const double der = diff / len; 

      drmsd += diff * diff;
      myder.addAtomDerivatives( i, -der * distance );
      myder.addAtomDerivatives( j,  der * distance );
      myder.addBoxDerivatives( - der * Tensor(distance,distance) );
  }

  const double inpairs = 1./static_cast<double>(targets.size());
  double idrmsd;

  if(squared){
     drmsd = drmsd * inpairs;
     idrmsd = 2.0 * inpairs;
  } else {
     drmsd = sqrt( drmsd * inpairs );
     idrmsd = inpairs / drmsd ;
  }

  myder.scaleAllDerivatives( idrmsd );

  return drmsd;
}

}
