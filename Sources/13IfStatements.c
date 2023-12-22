#include <stdio.h>
#include <stdlib.h>

int max1(int num1, int num2){
    int result;
    if(num1 > num2){
        result = num1;
    }
    else{
        result = num2;
    }
    return result; 
}

int max2(int num1, int num2, int num3){
    int result;
    if(num1 >= num2 && num1 >= num3){  // >= is used to handle the case when all the numbers are equal, && is used for AND
        result = num1;
    }
    else if(num2 >= num1 && num2 >= num3){
        result = num2;
    }
    else{
        result = num3;
    }
    return result; 
}


int main(){

    printf("%d\n", max1(2, 5));
    printf("%d\n", max2(2, 5, 10));

    if(3 > 2 || 2 > 5){  // || is used for OR
        printf("True\n");
    }else{
        printf("False\n");
    }
    
    if( 3 != 2){
        printf("True\n");
    }

    if(!(3 > 2)){
        printf("True\n"); // ! is used for NOT
    }
    return 0;
}