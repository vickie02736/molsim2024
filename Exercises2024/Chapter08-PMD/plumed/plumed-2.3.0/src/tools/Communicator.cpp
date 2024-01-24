/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Copyright (c) 2011-2016 The plumed team
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
#include "Communicator.h"
#include "Exception.h"
#include <cstdlib>

using namespace std;

namespace PLMD{

Communicator::Communicator()
#ifdef __PLUMED_HAS_MPI
: communicator(MPI_COMM_SELF)
#endif
{
}

// cppcheck complains about this:
// Member variable 'Communicator::communicator' is not initialized in the constructor
// this is a false positive so I suppress it
// cppcheck-suppress uninitMemberVar
Communicator::Communicator(const Communicator&pc){
  Set_comm(pc.communicator);
}

Communicator::Status Communicator::StatusIgnore;

// cppcheck complains about this:
// Member variable 'Communicator::communicator' is not assigned a value in 'Communicator::operator='
// this is a false positive so I suppress it
// cppcheck-suppress operatorEqVarError
Communicator& Communicator::operator=(const Communicator&pc){
  if (this != &pc){
      Set_comm(pc.communicator);
  }
  return *this;
}

int Communicator::Get_rank()const{
  int r=0;
#ifdef __PLUMED_HAS_MPI
  if(initialized()) MPI_Comm_rank(communicator,&r);
#endif
  return r;
}

Communicator& Communicator::Get_world(){
  static Communicator c;
#ifdef __PLUMED_HAS_MPI
  if(initialized()) c.communicator=MPI_COMM_WORLD;
#endif
  return c;
}


int Communicator::Get_size()const{
  int s=1;
#ifdef __PLUMED_HAS_MPI
  if(initialized()) MPI_Comm_size(communicator,&s);
#endif
  return s;
}

void Communicator::Set_comm(MPI_Comm c){
#ifdef __PLUMED_HAS_MPI
  if(initialized()){
    if(communicator!=MPI_COMM_SELF && communicator!=MPI_COMM_WORLD) MPI_Comm_free(&communicator);
    if(c!=MPI_COMM_SELF) MPI_Comm_dup(c,&communicator);
  }
#else
  (void) c;
#endif
}

Communicator::~Communicator(){
#ifdef __PLUMED_HAS_MPI
  if(initialized() && communicator!=MPI_COMM_SELF && communicator!=MPI_COMM_WORLD) MPI_Comm_free(&communicator);
#endif
}

void Communicator::Set_comm(void*val){
#ifdef __PLUMED_HAS_MPI
 plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
 if(val) Set_comm(*(MPI_Comm*)val);
#else
 (void) val;
 plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

void Communicator::Set_fcomm(void*val){
#ifdef __PLUMED_HAS_MPI
 plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  if(val){
    MPI_Comm comm=MPI_Comm_f2c(*(MPI_Fint*)val);
    Set_comm(comm);
  }
#else
  (void) val;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

void Communicator::Abort(int errorcode){
#ifdef __PLUMED_HAS_MPI
  if(initialized()){
    MPI_Abort(communicator,errorcode);
  }
  std::exit(errorcode);
#else
  std::exit(errorcode);
#endif
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
void Communicator::Bcast(Data data,int root){
#if defined(__PLUMED_HAS_MPI)
  if(initialized()) MPI_Bcast(data.pointer,data.size,data.type,root,communicator);
#else
  (void) data;
  (void) root;
#endif
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
void Communicator::Sum(Data data){
#if defined(__PLUMED_HAS_MPI)
  if(initialized()) MPI_Allreduce(MPI_IN_PLACE,data.pointer,data.size,data.type,MPI_SUM,communicator);
#else
  (void) data;
#endif
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
Communicator::Request Communicator::Isend(ConstData data,int source,int tag){
  Request req;
#ifdef __PLUMED_HAS_MPI
  plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  void*s=const_cast<void*>((const void*)data.pointer);
  MPI_Isend(s,data.size,data.type,source,tag,communicator,&req.r);
#else
  (void) data;
  (void) source;
  (void) tag;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
  return req;
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
void Communicator::Allgatherv(ConstData in,Data out,const int*recvcounts,const int*displs){
#if defined(__PLUMED_HAS_MPI)
  plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  void*s=const_cast<void*>((const void*)in.pointer);
  void*r=const_cast<void*>((const void*)out.pointer);
  int*rc=const_cast<int*>(recvcounts);
  int*di=const_cast<int*>(displs);
  if(s==NULL)s=MPI_IN_PLACE;
  MPI_Allgatherv(s,in.size,in.type,r,rc,di,out.type,communicator);
#else
  (void) in;
  (void) out;
  (void) recvcounts;
  (void) displs;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
void Communicator::Allgather(ConstData in,Data out){
#if defined(__PLUMED_HAS_MPI)
  plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  void*s=const_cast<void*>((const void*)in.pointer);
  void*r=const_cast<void*>((const void*)out.pointer);
  if(s==NULL)s=MPI_IN_PLACE;
  MPI_Allgather(s,in.size,in.type,r,out.size/Get_size(),out.type,communicator);
#else
  (void) in;
  (void) out;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

// data should be passed by value to allow conversions
// cppcheck-suppress passedByValue
void Communicator::Recv(Data data,int source,int tag,Status&status){
#ifdef __PLUMED_HAS_MPI
  plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  if(&status==&StatusIgnore) MPI_Recv(data.pointer,data.size,data.type,source,tag,communicator,MPI_STATUS_IGNORE);
  else                       MPI_Recv(data.pointer,data.size,data.type,source,tag,communicator,&status.s);
#else
  (void) data;
  (void) source;
  (void) tag;
  (void) status;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}





void Communicator::Barrier()const{
#ifdef __PLUMED_HAS_MPI
  if(initialized()) MPI_Barrier(communicator);
#endif
}

MPI_Comm & Communicator::Get_comm(){
    return communicator;
}

bool Communicator::initialized(){
  int flag=false;
#if defined(__PLUMED_HAS_MPI)
  MPI_Initialized(&flag);
#endif
  if(flag) return true;
  else return false;
}

void Communicator::Request::wait(Status&s){
#ifdef __PLUMED_HAS_MPI
 plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  if(&s==&StatusIgnore) MPI_Wait(&r,MPI_STATUS_IGNORE);
  else MPI_Wait(&r,&s.s);
#else
  (void) s;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

#ifdef __PLUMED_HAS_MPI
template<> MPI_Datatype Communicator::getMPIType<float>(){ return MPI_FLOAT;}
template<> MPI_Datatype Communicator::getMPIType<double>(){ return MPI_DOUBLE;}
template<> MPI_Datatype Communicator::getMPIType<int>()   { return MPI_INT;}
template<> MPI_Datatype Communicator::getMPIType<char>()   { return MPI_CHAR;}
template<> MPI_Datatype Communicator::getMPIType<unsigned>()   { return MPI_UNSIGNED;}
template<> MPI_Datatype Communicator::getMPIType<long unsigned>()   { return MPI_UNSIGNED_LONG;}
#else
template<> MPI_Datatype Communicator::getMPIType<float>(){ return MPI_Datatype();}
template<> MPI_Datatype Communicator::getMPIType<double>(){ return MPI_Datatype();}
template<> MPI_Datatype Communicator::getMPIType<int>(){ return MPI_Datatype();}
template<> MPI_Datatype Communicator::getMPIType<char>(){ return MPI_Datatype();}
template<> MPI_Datatype Communicator::getMPIType<unsigned>(){ return MPI_Datatype();}
template<> MPI_Datatype Communicator::getMPIType<long unsigned>(){ return MPI_Datatype();}
#endif


void Communicator::Split(int color,int key,Communicator&pc)const{
#ifdef __PLUMED_HAS_MPI
  MPI_Comm_split(communicator,color,key,&pc.communicator);
#else
  (void) color;
  (void) key;
  (void) pc;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
}

int Communicator::Status::Get_count(MPI_Datatype type)const{
  int i;
#ifdef __PLUMED_HAS_MPI
  plumed_massert(initialized(),"you are trying to use an MPI function, but MPI is not initialized");
  MPI_Get_count(const_cast<MPI_Status*>(&s),type,&i);
#else
  i=0;
  plumed_merror("you are trying to use an MPI function, but PLUMED has been compiled without MPI support");
#endif
  return i;
}

}

