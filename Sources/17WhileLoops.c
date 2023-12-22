#include <stdio.h>
#include <stdlib.h>

int main(){

    int index1 = 1;
    while(index1 <= 5){
        printf("%d\n", index1);
        index1++; // index = index + 1
    }

    int index2 = 6;
    do{
        printf("%d\n", index2);
        index2++;
    }while(index2 <= 5); // do while loop will run at least once (even if the condition is false

    return 0;
}