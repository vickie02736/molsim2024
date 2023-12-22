#include <stdio.h>
#include <stdlib.h>

int main(){

    char line[255];
    FILE * fpointer = fopen("employees.txt", "r"); // w = write, r = read, a = append

    fgets(line, 255, fpointer); // read the first line
    fgets(line, 255, fpointer); // read the first line

    printf("%s", line);
    fclose(fpointer); // close the file

    return 0;   
}