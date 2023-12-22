#include <stdio.h>
#include <stdlib.h>

double cube(double num); // Function prototype

int main(){

    printf("Answer: %f", cube(3.0));
    return 0;
}

double cube(double num){
    printf("Here\n");
    return num * num * num;
}