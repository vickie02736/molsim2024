#include <stdio.h>
#include <stdlib.h>

int main()
{
    int age = 30;
    int *pAge = &age; // * is a pointer, & is a memory address

    printf("pAge's memory address: %p\n", (void*)pAge); // %p is a pointer
    printf("%d\n", *pAge); 
    printf("%d\n", *&age); 
    printf("%p\n", &*&age); 

    return 0;
}
