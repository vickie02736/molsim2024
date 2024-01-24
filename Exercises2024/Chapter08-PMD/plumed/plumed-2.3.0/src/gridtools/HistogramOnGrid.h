/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Copyright (c) 2012-2016 The plumed team
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
#ifndef __PLUMED_gridtools_HistogramOnGrid_h
#define __PLUMED_gridtools_HistogramOnGrid_h

#include "GridVessel.h"

namespace PLMD {

class KernelFunctions;

namespace gridtools {

class HistogramOnGrid : public GridVessel {
private:
  unsigned neigh_tot;
  bool addOneKernelAtATime;
  std::string kerneltype;
  std::vector<double> bandwidths;
  std::vector<unsigned> nneigh;
protected:
  bool discrete;
public:
  static void registerKeywords( Keywords& keys );
  explicit HistogramOnGrid( const vesselbase::VesselOptions& da );
  void setBounds( const std::vector<std::string>& smin, const std::vector<std::string>& smax,
                  const std::vector<unsigned>& nbins, const std::vector<double>& spacing );
  void calculate( const unsigned& current, MultiValue& myvals, std::vector<double>& buffer, std::vector<unsigned>& der_list ) const ;
  void finish( const std::vector<double>& buffer );
  virtual void accumulate( const unsigned& ipoint, const double& weight, const double& dens, const std::vector<double>& der, std::vector<double>& buffer ) const ;
  unsigned getNumberOfBufferPoints() const ;
  KernelFunctions* getKernelAndNeighbors( std::vector<double>& point, unsigned& num_neigh, std::vector<unsigned>& neighbors ) const;
  std::vector<Value*> getVectorOfValues() const ;
  void addOneKernelEachTimeOnly(){ addOneKernelAtATime=true; }
  bool noDiscreteKernels() const ;
};

inline
unsigned HistogramOnGrid::getNumberOfBufferPoints() const {
  if( addOneKernelAtATime ) return neigh_tot;
  return GridVessel::getNumberOfBufferPoints();
}

}
}
#endif
