/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Copyright (c) 2014-2016 The plumed team
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
#include "core/ActionAtomistic.h"
#include "core/ActionPilot.h"
#include "core/ActionRegister.h"
#include "core/ActionWithValue.h"
#include "tools/Vector.h"
#include "tools/Matrix.h"
#include "tools/AtomNumber.h"
#include "tools/Tools.h"
#include "tools/RMSD.h"
#include "core/Atoms.h"
#include "core/PlumedMain.h"
#include "core/ActionSet.h"
#include "core/SetupMolInfo.h"
#include "tools/PDB.h"
#include "tools/Pbc.h"

#include <vector>
#include <string>

using namespace std;

namespace PLMD {
namespace generic{

//+PLUMEDOC GENERIC FIT_TO_TEMPLATE
/*
This action is used to align a molecule to a template.

This can be used to move the coordinates stored in plumed
so as to be aligned with a provided template in pdb format. Pdb should contain
also weights for alignment (see the format of pdb files used e.g. for \ref RMSD).
Weights for displacement are ignored, since no displacement is computed here.
Notice that all atoms (not only those in the template) are aligned.
To see what effect try
the \ref DUMPATOMS directive to output the atomic positions.

Also notice that PLUMED propagate forces correctly so that you can add a bias on a CV computed
after alignment. For many CVs this has no effect, but in some case the alignment can
change the result. Examples are:
- \ref POSITION CV since it is affected by a rigid shift of the system.
- \ref DISTANCE CV with COMPONENTS. Since the alignment could involve a rotation (with TYPE=OPTIMAL) the actual components could be different
  from the original ones.
- \ref CELL components for a similar reason.

\attention
The implementation of TYPE=OPTIMAL is available but should be considered in testing phase. Please report any
strange behavior. 

\attention
This directive modifies the stored position at the precise moment
it is executed. This means that only collective variables
which are below it in the input script will see the corrected positions.
As a general rule, put it at the top of the input file. Also, unless you
know exactly what you are doing, leave the default stride (1), so that
this action is performed at every MD step.

\par Examples

Align the atomic position to a template then print them
\verbatim
# to see the effect, one could dump the atoms before alignment
DUMPATOMS FILE=dump-before.xyz ATOMS=1-20
FIT_TO_TEMPLATE STRIDE=1 REFERENCE=ref.pdb TYPE=SIMPLE
DUMPATOMS FILE=dump-after.xyz ATOMS=1-20
\endverbatim
(see also \ref DUMPATOMS)




*/
//+ENDPLUMEDOC


class FitToTemplate:
  public ActionPilot,
  public ActionAtomistic,
  public ActionWithValue
{
  std::string type;
  std::vector<double> weights;
  std::vector<AtomNumber> aligned;
  Vector center;
  Vector shift;
  // optimal alignment related stuff
  PLMD::RMSD* rmsd; 
  Tensor rotation;
  Matrix< std::vector<Vector> > drotdpos;
  std::vector<Vector> positions;
  std::vector<Vector> DDistDRef;
  std::vector<Vector> ddistdpos;
  std::vector<Vector> centeredpositions;
  Vector center_positions;

        
public:
  explicit FitToTemplate(const ActionOptions&ao);
  ~FitToTemplate();
  static void registerKeywords( Keywords& keys );
  void calculate();
  void apply();
  unsigned getNumberOfDerivatives(){plumed_merror("You should not call this function");};
};

PLUMED_REGISTER_ACTION(FitToTemplate,"FIT_TO_TEMPLATE")

void FitToTemplate::registerKeywords( Keywords& keys ){
  Action::registerKeywords( keys );
  ActionAtomistic::registerKeywords( keys );
  keys.add("compulsory","STRIDE","1","the frequency with which molecules are reassembled.  Unless you are completely certain about what you are doing leave this set equal to 1!");
  keys.add("compulsory","REFERENCE","a file in pdb format containing the reference structure and the atoms involved in the CV.");
  keys.add("compulsory","TYPE","SIMPLE","the manner in which RMSD alignment is performed.  Should be OPTIMAL or SIMPLE.");
}

FitToTemplate::FitToTemplate(const ActionOptions&ao):
Action(ao),
ActionPilot(ao),
ActionAtomistic(ao),
ActionWithValue(ao),
rmsd(NULL)
{
  string reference;
  parse("REFERENCE",reference);
  type.assign("SIMPLE");
  parse("TYPE",type);

 // if(type!="SIMPLE") error("Only TYPE=SIMPLE is implemented in FIT_TO_TEMPLATE");

  checkRead();

  PDB pdb;

  // read everything in ang and transform to nm if we are not in natural units
  if( !pdb.read(reference,plumed.getAtoms().usingNaturalUnits(),0.1/atoms.getUnits().getLength()) )
      error("missing input file " + reference );

  requestAtoms(pdb.getAtomNumbers());

  std::vector<Vector> positions=pdb.getPositions();
  weights=pdb.getOccupancy();
  aligned=pdb.getAtomNumbers();


  // normalize weights
  double n=0.0; for(unsigned i=0;i<weights.size();++i) n+=weights[i]; n=1.0/n;
  for(unsigned i=0;i<weights.size();++i) weights[i]*=n;

  // normalize weights for rmsd calculation
  vector<double> weights_measure=pdb.getBeta();
  n=0.0; for(unsigned i=0;i<weights_measure.size();++i) n+=weights_measure[i]; n=1.0/n;
  for(unsigned i=0;i<weights_measure.size();++i) weights_measure[i]*=n;

  // subtract the center 
  for(unsigned i=0;i<weights.size();++i) center+=positions[i]*weights[i];
  for(unsigned i=0;i<weights.size();++i) positions[i]-=center;

  if(type=="OPTIMAL" or type=="OPTIMAL-FAST" ){
	  rmsd=new RMSD();
          rmsd->set(weights,weights_measure,positions,type,false,false);// note: the reference is shifted now with center in the origin
	  log<<"  Method chosen for fitting: "<<rmsd->getMethod()<<" \n";
  }
  // register the value of rmsd (might be useful sometimes)
  addValue(); setNotPeriodic();

  doNotRetrieve();
}


void FitToTemplate::calculate(){

 	Vector cc;

  	for(unsigned i=0;i<aligned.size();++i){
  	  cc+=weights[i]*modifyPosition(aligned[i]);
  	}

  	if (type=="SIMPLE"){
  		shift=center-cc;
		setValue(shift.modulo());
  		for(unsigned i=0;i<getTotAtoms();i++){
  		  Vector & ato (modifyPosition(AtomNumber::index(i)));
  		  ato+=shift;
  		}
	}
  	else if( type=="OPTIMAL" or type=="OPTIMAL-FAST"){
// we store positions here to be used in apply()
// notice that in apply() it is not guaranteed that positions are still equal to their value here
// since they could have been changed by a subsequent FIT_TO_TEMPLATE
		positions.resize(aligned.size());
	        for (unsigned i=0;i<aligned.size();i++) positions[i]=modifyPosition(aligned[i]);

		// specific stuff that provides all that is needed
  	        double r=rmsd->calc_FitElements( positions, rotation ,  drotdpos , centeredpositions, center_positions);
		setValue(r);
		for(unsigned i=0;i<getTotAtoms();i++){
			Vector & ato (modifyPosition(AtomNumber::index(i)));
			ato=matmul(rotation,ato-center_positions)+center;
		}
// rotate box
		Pbc & pbc(modifyGlobalPbc());
		pbc.setBox(matmul(pbc.getBox(),transpose(rotation)));
	}

}

void FitToTemplate::apply(){
  if (type=="SIMPLE") {
  	Vector totForce;
  	for(unsigned i=0;i<getTotAtoms();i++){
  	  totForce+=modifyGlobalForce(AtomNumber::index(i));
  	}
	Tensor & vv(modifyGlobalVirial());
  	vv+=Tensor(center,totForce);
  	for(unsigned i=0;i<aligned.size();++i){
  	  Vector & ff(modifyGlobalForce(aligned[i]));
  	  ff-=totForce*weights[i];
  	}
  } else if ( type=="OPTIMAL" or type=="OPTIMAL-FAST") { 
  	Vector totForce;
	for(unsigned i=0;i<getTotAtoms(); i++) {
        	Vector & f(modifyGlobalForce(AtomNumber::index(i)));
// rotate back forces
		f=matmul(transpose(rotation),f);
// accumulate rotated c.o.m. forces - this is already in the non rotated reference frame
        	totForce+=f;
	}
        Tensor& virial(modifyGlobalVirial());
// notice that an extra Tensor(center,matmul(rotation,totForce)) is required to
// compute the derivatives of the rotation with respect to center
	Tensor ww=matmul(transpose(rotation),virial+Tensor(center,matmul(rotation,totForce)));
// rotate back virial
	virial=matmul(transpose(rotation),matmul(virial,rotation));

// now we compute the force due to alignment
	for(unsigned i=0;i<aligned.size(); i++) {
		Vector g;
		for(unsigned k=0;k<3;k++){
// this could be made faster computing only the diagonal of d
			Tensor d=matmul(ww,RMSD::getMatrixFromDRot(drotdpos,i,k));
			g[k]=(d(0,0)+d(1,1)+d(2,2));
		}
// here is the extra contribution
		modifyGlobalForce(aligned[i])+=-g-weights[i]*totForce;
// here it the contribution to the virial
// notice that here we can use absolute positions since, for the alignment to be defined,
// positions should be in one well defined periodic image
		virial+=extProduct(positions[i],g);
	}
// finally, correction to the virial
	virial+=extProduct(matmul(transpose(rotation),center),totForce);
  }
}

FitToTemplate::~FitToTemplate(){
  if(rmsd) delete rmsd;
}

}
}
