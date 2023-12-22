# include <stdio.h>
# include <stdlib.h>

int main()
{
    int age = 30;
    int * pAge = &age; // * is a pointer, & is a memory address

    printf("age's memory address: %p\n", &age);
    printf("pAge's memory address: %p\n", pAge);
    printf("pAge's value: %d\n", *pAge);

    return 0;
}