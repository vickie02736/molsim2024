#include <stdio.h>
#include <stdlib.h>

int main()
{

    int luckyNumbers1[] = {4, 8, 15, 16, 23, 42}; // Array of integers
    luckyNumbers1[2] = 200; // Change the value of the second element
    printf("%d\n", luckyNumbers1[2]);  //4 

    int luckyNumbers2[10]; // Array of integers
    luckyNumbers2[1] = 80; 
    printf("%d\n", luckyNumbers2[0]);  

    char phrase[20] = "Array"; // Array of characters

    return 0;
}