#include <stdio.h>
#include <stdlib.h>


int main(){

    double num1;
    double num2;
    char op; // op stands for operator

    printf("Enter a number: ");
    scanf("%lf", &num1);
    printf("Enter operator: ");
    scanf(" %c", &op); // space is used to ignore the newline character
    printf("Enter a number: ");
    scanf("%lf", &num2);

    if(op == '+'){
        printf("%f\n", num1 + num2);
    }
    else if(op == '-'){
        printf("%f\n", num1 - num2);
    }
    else if(op == '*'){
        printf("%f\n", num1 * num2);
    }
    else if(op == '/'){
        printf("%f\n", num1 / num2);
    }
    else{
        printf("Invalid operator\n");
    }

    return 0; 
}