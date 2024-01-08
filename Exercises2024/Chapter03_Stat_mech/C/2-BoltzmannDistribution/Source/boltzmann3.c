#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ENERGY_LEVELS 10000
#define PLANCKS_CONSTANT_HBAR 1.0545718e-34  // in J·s 
#define BOLTZMANN_CONSTANT 1.380649e-23      // in J/K

int main(void)
{
  int j, NumberOfEnergyLevels;
  double Beta, Temperature, MomentOfInertia, PartitionFunction, EnergyLevel;
  FILE *FilePtr;

  // read parameters
  printf("Number Of Energy Levels (2-10000) ? ");
  fscanf(stdin,"%d",&NumberOfEnergyLevels);

  printf("Temperature (K) ? ");
  fscanf(stdin,"%lf",&Temperature);

  printf("Moment of Inertia (kg·m^2) ? ");
  fscanf(stdin,"%lf",&MomentOfInertia);

  // check input
  if(NumberOfEnergyLevels < 2 || NumberOfEnergyLevels > MAX_ENERGY_LEVELS ||
     Temperature < 1e-7 || Temperature >= 1e7)
  {
    printf("Input parameter error, should be\n");
    printf("\tNumberOfEnergyLevels (2-%d)\n", MAX_ENERGY_LEVELS);
    printf("\tTemperature (1e-7 - 1e7 K)\n");
    exit(0);
  }

  Beta = 1.0 / (BOLTZMANN_CONSTANT * Temperature);
  PartitionFunction = 0.0;

  // Open file to write results
  FilePtr = fopen("results4.dat","w");

  // loop over all levels
  for(j = 0; j < NumberOfEnergyLevels; j++)
  {
    EnergyLevel = PLANCKS_CONSTANT_HBAR * PLANCKS_CONSTANT_HBAR / (2 * MomentOfInertia) * j * (j + 1);
    int Degeneracy = 2 * j + 1;
    double BoltzmannFactor = Degeneracy * exp(-Beta * EnergyLevel);

    PartitionFunction += BoltzmannFactor;
    fprintf(FilePtr, "%d %e\n", j, BoltzmannFactor);
  }

  fprintf(FilePtr, "Partition Function: %e\n", PartitionFunction);
  fclose(FilePtr);

  return 0;
}
