#include <stdio.h>
#include <stdlib.h>

void sayHi1(); // function prototype
void sayHi2(char name[], int age); 

int main()
{
    printf("Top\n");
    sayHi1();
    sayHi2("Mike", 40);
    sayHi2("Tom", 20);
    sayHi2("Oscar", 70);
    printf("Bottom");
    return 0; 
}

void sayHi1() {
    printf("Hello user\n");
}


void sayHi2(char name[], int age) {
    printf("Hello %s, you are %d\n", name, age);
}
