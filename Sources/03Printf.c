#include <stdio.h>
#include <stdlib.h>

int main()
{

    printf("1. Hello\nWorld\n");
    printf("2. Hello\"World\n");

    printf("3. My favourite %s is %d. \n", "number", 500);
    printf("4. My favourite %s is %f. \n", "number", 3.1415);

    int favNum = 7;
    char myChar = 'i';
    printf("5. My favourite %s is %d. \n", "number", favNum);
    printf("6. My favourite %c is %d. \n", myChar, favNum);


    return 0;
}