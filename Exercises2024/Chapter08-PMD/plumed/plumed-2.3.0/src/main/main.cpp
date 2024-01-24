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
#include "wrapper/Plumed.h"
#include <cstring>

#ifdef __PLUMED_HAS_MPI
#include <mpi.h>
#endif

using namespace std;

/**
  This main uses only the interface published in
  Plumed.h. The object file generated from this .cpp
  is the only part of the plumed library that should
  not be linked with external MD codes, so as 
  to avoid linker error.
*/
int main(int argc,char**argv){
#ifdef __PLUMED_HAS_MPI
  bool nompi=false;
  if(argc>1 && !strcmp(argv[1],"--no-mpi")) nompi=true;
  if(argc>1 && !strcmp(argv[1],"--mpi"))    nompi=false;
  if(!nompi) MPI_Init(&argc,&argv);
#endif
  int ret=0;

  PLMD::Plumed* p=new PLMD::Plumed;
  p->cmd("CLTool setArgc",&argc);
  p->cmd("CLTool setArgv",argv);
#ifdef __PLUMED_HAS_MPI
  if(!nompi){
    MPI_Comm comm;
    MPI_Comm_dup(MPI_COMM_WORLD,&comm);
    p->cmd("CLTool setMPIComm",&comm);
  }
#endif
  p->cmd("CLTool run",&ret);
  delete p;

#ifdef __PLUMED_HAS_MPI
  if(!nompi) MPI_Finalize();
#endif
  return ret;
}
