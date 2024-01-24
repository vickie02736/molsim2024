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
#include "Colvar.h"
#include "ActionRegister.h"
#include "tools/NeighborList.h"
#include "tools/OpenMP.h"

#include <string>
#include <cmath>

using namespace std;

namespace PLMD {
namespace colvar {

//+PLUMEDOC COLVAR PRE 
/*
Calculates the Paramegnetic Resonance Enhancement  intensity ratio between two atoms.
The reference atom for the spin label is added with SPINLABEL, the affected atom(s)
are give as numbered GROUPA1, GROUPA2, ...
The additional parameters needed for the calculation are given as INEPT, the inept
time, TAUC the correlation time, OMEGA, the larmor frequency and RTWO for the relaxation
time.

\par Examples

In the following example five PRE intensities are calculated using the distance between the
oxigen of the spin label and the backbone hydrogens. Omega is the NMR frequency, RTWO the
R2 for the hydrogens, INEPT of 8 ms for the experiment and a TAUC of 1.21 ns

\verbatim
PRE ...
LABEL=HN_pre
INEPT=8
TAUC=1.21
OMEGA=900
SPINLABEL=1818
GROUPA1=86  RTWO1=0.0120272827
GROUPA2=177 RTWO2=0.0263953158
GROUPA3=285 RTWO3=0.0058899829
GROUPA4=335 RTWO4=0.0102072646
GROUPA5=451 RTWO5=0.0086341843
... PRE

PRINT ARG=HN_pre.* FILE=PRE.dat STRIDE=1

\endverbatim

*/
//+ENDPLUMEDOC

class PRE : public Colvar {   
private:
  bool             pbc;
  double           constant, inept;
  vector<double>   rtwo;
  vector<unsigned> nga;
  NeighborList     *nl;
public:
  static void registerKeywords( Keywords& keys );
  explicit PRE(const ActionOptions&);
  ~PRE();
  virtual void calculate();
};

PLUMED_REGISTER_ACTION(PRE,"PRE")

void PRE::registerKeywords( Keywords& keys ){
  Colvar::registerKeywords( keys );
  componentsAreNotOptional(keys);
  useCustomisableComponents(keys);
  keys.add("compulsory","INEPT","is the INEPT time (in ms).");
  keys.add("compulsory","TAUC","is the correlation time (in ns) for this electron-nuclear interaction.");
  keys.add("compulsory","OMEGA","is the Larmor frequency of the nuclear spin (in MHz).");
  keys.add("atoms","SPINLABEL","The atom to be used as the paramagnetic center.");
  keys.add("numbered","GROUPA","the atoms involved in each of the contacts you wish to calculate. "
                   "Keywords like GROUPA1, GROUPA2, GROUPA3,... should be listed and one contact will be "
                   "calculated for each ATOM keyword you specify.");
  keys.reset_style("GROUPA","atoms");
  keys.add("numbered","RTWO","The relaxation of the atom/atoms in the corresponding GROUPA of atoms. "
                   "Keywords like RTWO1, RTWO2, RTWO3,... should be listed.");
  keys.addFlag("ADDEXP",false,"Set to TRUE if you want to have fixed components with the experimetnal values.");  
  keys.add("numbered","PREINT","Add an experimental value for each PRE.");
  keys.addOutputComponent("pre","default","the # PRE");
  keys.addOutputComponent("exp","ADDEXP","the # PRE experimental intensity");
}

PRE::PRE(const ActionOptions&ao):
PLUMED_COLVAR_INIT(ao),
pbc(true)
{
  bool nopbc=!pbc;
  parseFlag("NOPBC",nopbc);
  pbc=!nopbc;  

  vector<AtomNumber> atom;
  parseAtomList("SPINLABEL",atom);
  if(atom.size()!=1) error("Number of specified atom should be 1");

  // Read in the atoms
  vector<AtomNumber> t, ga_lista, gb_lista;
  for(int i=1;;++i ){
     parseAtomList("GROUPA", i, t );
     if( t.empty() ) break;
     for(unsigned j=0;j<t.size();j++) {ga_lista.push_back(t[j]); gb_lista.push_back(atom[0]);}
     nga.push_back(t.size());
     t.resize(0); 
  }

  // Read in reference values
  rtwo.resize( nga.size() ); 
  unsigned ntarget=0;
  for(unsigned i=0;i<nga.size();++i){
     if( !parseNumbered( "RTWO", i+1, rtwo[i] ) ) break;
     ntarget++; 
  }
  if( ntarget==0 ){
      parse("RTWO",rtwo[0]);
      for(unsigned i=1;i<nga.size();++i) rtwo[i]=rtwo[0];
  } else if( ntarget!=nga.size() ) error("found wrong number of RTWO values");

  double tauc=0.;
  parse("TAUC",tauc);
  if(tauc==0.) error("TAUC must be set");

  double omega=0.;
  parse("OMEGA",omega);
  if(omega==0.) error("OMEGA must be set");

  inept=0.;
  parse("INEPT",inept);
  if(inept==0.) error("INEPT must be set");
  inept *= 0.001; // ms2s

  const double ns2s   = 0.000000001;
  const double MHz2Hz = 1000000.;
  const double Kappa  = 12300000000.00; // this is 1/15*S*(S+1)*gamma^2*g^2*beta^2 
                                        // where gamma is the nuclear gyromagnetic ratio, 
                                        // g is the electronic g factor, and beta is the Bohr magneton
                                        // in nm^6/s^2
  constant = (4.*tauc*ns2s+(3.*tauc*ns2s)/(1+omega*omega*MHz2Hz*MHz2Hz*tauc*tauc*ns2s*ns2s))*Kappa;

  bool addexp=false;
  parseFlag("ADDEXP",addexp);

  vector<double> exppre;
  if(addexp) {
    exppre.resize( nga.size() ); 
    unsigned ntarget=0;

    for(unsigned i=0;i<nga.size();++i){
       if( !parseNumbered( "PREINT", i+1, exppre[i] ) ) break;
       ntarget++; 
    }
    if( ntarget!=nga.size() ) error("found wrong number of PREINT values");
  }

  // Create neighbour lists
  nl= new NeighborList(gb_lista,ga_lista,true,pbc,getPbc());

  // Ouput details of all contacts
  unsigned index=0; 
  for(unsigned i=0;i<nga.size();++i){
    log.printf("  The %uth PRE is calculated using %u equivalent atoms:\n", i, nga[i]);
    log.printf("    %d", ga_lista[index].serial());
    index++;
    for(unsigned j=1;j<nga[i];j++) {
      log.printf(" %d", ga_lista[index].serial());
      index++;
    }
    log.printf("\n");
  }

  if(pbc)      log.printf("  using periodic boundary conditions\n");
  else         log.printf("  without periodic boundary conditions\n");

  for(unsigned i=0;i<nga.size();i++) {
    string num; Tools::convert(i,num);
    addComponentWithDerivatives("pre_"+num);
    componentIsNotPeriodic("pre_"+num);
  }

  if(addexp) {
    for(unsigned i=0;i<nga.size();i++) {
      string num; Tools::convert(i,num);
      addComponent("exp_"+num);
      componentIsNotPeriodic("exp_"+num);
      Value* comp=getPntrToComponent("exp_"+num); 
      comp->set(exppre[i]);
    }
  }

  requestAtoms(nl->getFullAtomList());
  checkRead();
}

PRE::~PRE(){
  delete nl;
} 

void PRE::calculate()
{
// cycle over the number of PRE
#pragma omp parallel for num_threads(OpenMP::getNumThreads()) 
  for(unsigned i=0;i<nga.size();i++) {
    vector<Vector> deriv; 
    Tensor dervir;
    double pre=0;
    unsigned index=0;
    for(unsigned k=0; k<i; k++) index+=nga[k]; 
    // cycle over equivalent atoms 
    for(unsigned j=0;j<nga[i];j++) {
      const double c_aver=constant/((double)nga[i]);
      // the first atom is always the same (the paramagnetic group)
      const unsigned i0=nl->getClosePair(index+j).first;
      const unsigned i1=nl->getClosePair(index+j).second;

      Vector distance;
      if(pbc) distance=pbcDistance(getPosition(i0),getPosition(i1));
      else    distance=delta(getPosition(i0),getPosition(i1));

      const double r2=distance.modulo2();
      const double r6=r2*r2*r2;
      const double r8=r6*r2;
      const double tmpir6=c_aver/r6;
      const double tmpir8=-6.*c_aver/r8;

      pre += tmpir6;

      Vector tmpv = -tmpir8*distance;
      deriv.push_back(tmpv);
      dervir   +=  Tensor(distance,tmpv);
    }
    const double ratio = rtwo[i]*exp(-pre*inept) / (rtwo[i]+pre);
    const double fact = -ratio*(inept+1./(rtwo[i]+pre));

    Value* val=getPntrToComponent(i);
    val->set(ratio);
    setBoxDerivatives(val, fact*dervir);

    for(unsigned j=0;j<nga[i];j++) {
      const unsigned i0=nl->getClosePair(index+j).first;
      const unsigned i1=nl->getClosePair(index+j).second;
      setAtomsDerivatives(val, i0,  fact*deriv[j]);
      setAtomsDerivatives(val, i1, -fact*deriv[j]);
    }
  }
}

}
}
