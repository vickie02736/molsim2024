#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "system.h"


void WritePdb(FILE *FilePtr)
{
  int i;
  static int Countmodel=0;

  Countmodel++;

  fprintf(FilePtr,"%s %9d\n","MODEL", Countmodel);
  fprintf(FilePtr,"CRYST1   %6.3f   %6.3f   %6.3f  90.00  90.00  90.00 P 1         1\n", 2.0*Box, 2.0*Box, 2.0*Box);

  for(i=0;i<NumberOfParticles;i++)
  {
    fprintf(FilePtr,"%s%7d%s%12d    %8.3lf%8.3lf%8.3lf                      %2s\n",
      "ATOM",i,"  H",i,Positions[i].x*2.0,Positions[i].y*2.0,Positions[i].z*2.0," H");
  }
  fprintf(FilePtr,"%s\n","ENDMDL");
}

void Store(void)
{
  int i;
  FILE *FilePtr;

  FilePtr=fopen("restart.dat","w");
  fprintf(FilePtr,"%lf\n",Box);
  fprintf(FilePtr,"%d\n",NumberOfParticles);
  fprintf(FilePtr,"%lf\n",MaximumDisplacement);

  for(i=0;i<NumberOfParticles;i++)
    fprintf(FilePtr,"%lf %lf %lf\n",
      Positions[i].x,Positions[i].y,Positions[i].z);
  fclose(FilePtr);
}

