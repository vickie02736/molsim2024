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
#include "RMSDBase.h"
#include "MetricRegister.h"
#include "tools/RMSD.h"

namespace PLMD{

class SimpleRMSD : public RMSDBase {
private:
  RMSD myrmsd;
public:
  explicit SimpleRMSD( const ReferenceConfigurationOptions& ro );
  void read( const PDB& );
  double calc( const std::vector<Vector>& pos, ReferenceValuePack& myder, const bool& squared ) const ;
  bool pcaIsEnabledForThisReference(){ return true; }
  void setupPCAStorage( ReferenceValuePack& mypack ){
     mypack.switchOnPCAOption(); mypack.getAtomsDisplacementVector().resize( getNumberOfAtoms() );
  }
  double projectAtomicDisplacementOnVector( const unsigned& iv, const Matrix<Vector>& vecs, const std::vector<Vector>& pos, ReferenceValuePack& mypack ) const ;  
};

PLUMED_REGISTER_METRIC(SimpleRMSD,"SIMPLE")

SimpleRMSD::SimpleRMSD( const ReferenceConfigurationOptions& ro ):
ReferenceConfiguration( ro ),
RMSDBase( ro )
{
}

void SimpleRMSD::read( const PDB& pdb ){
  readReference( pdb );
}

double SimpleRMSD::calc( const std::vector<Vector>& pos, ReferenceValuePack& myder, const bool& squared ) const {
  if( myder.getAtomsDisplacementVector().size()!=pos.size() ) myder.getAtomsDisplacementVector().resize( pos.size() );
  double d=myrmsd.simpleAlignment( getAlign(), getDisplace(), pos, getReferencePositions(), myder.getAtomVector(), myder.getAtomsDisplacementVector(), squared );
  myder.clear(); for(unsigned i=0;i<pos.size();++i) myder.setAtomDerivatives( i, myder.getAtomVector()[i] );
  if( !myder.updateComplete() ) myder.updateDynamicLists();
  return d;
}

double SimpleRMSD::projectAtomicDisplacementOnVector( const unsigned& iv, const Matrix<Vector>& vecs, const std::vector<Vector>& pos, ReferenceValuePack& mypack ) const { 
  plumed_dbg_assert( mypack.calcUsingPCAOption() ); Vector comder; comder.zero();
  for(unsigned j=0;j<pos.size();++j){
      for(unsigned k=0;k<3;++k) comder[k] += getAlign()[j]*vecs(iv,j)[k];
  }

  double proj=0; mypack.clear();
  for(unsigned j=0;j<pos.size();++j){
      for(unsigned k=0;k<3;++k){
          proj += vecs(iv,j)[k]*mypack.getAtomsDisplacementVector()[j][k];
      }
      mypack.setAtomDerivatives( j, vecs(iv,j) - comder );
  }
  if( !mypack.updateComplete() ) mypack.updateDynamicLists();
  return proj;
}

}
