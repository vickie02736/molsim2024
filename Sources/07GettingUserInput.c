#include <stdio.h>
#include <stdlib.h>

int main()
{

    int age; 
    printf("Enter your age: ");
    scanf("%d", &age);
    printf("You are %d years old", age);

    double gpa; 
    printf("Enter your gpa: ");
    scanf("%lf", &gpa); // %lf is used for doubles
    printf("Your gpa is %f", gpa); // %f is used for doubles

    char grade;
    printf("Enter your grade: ");
    scanf("%c", &grade); // %c is used for characters
    printf("Your grade is %c", grade); 

    char name1[20]; // 20 is the max number of characters
    printf("Enter your name: ");
    scanf("%s", name1);  // %s is used for strings
    printf("Your name is %s", name1); // %s is used for stringsS

    char name2[20]; // 20 is the max number of characters
    printf("Enter your name: ");
    fgets(name2, 20, stdin); // fgets is used for strings
    printf("Your name is %s", name2); // %s is used for stringsS

    return 0;
}