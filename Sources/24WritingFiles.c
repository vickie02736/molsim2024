#include <stdio.h>
#include <stdlib.h>

int main(){
    FILE * fpointer1 = fopen("employees.txt", "w"); // w = write, r = read, a = append
    fprintf(fpointer1, "Jim, Salesman\nPam, Receptionist\nOscar, Accounting");
    fclose(fpointer1); // close the file

    FILE * fpointer2 = fopen("employees.txt", "a"); // a = append
    fprintf(fpointer2, "\nKelly, Customer Service");

    fclose(fpointer2); // close the file

    return 0;   
}