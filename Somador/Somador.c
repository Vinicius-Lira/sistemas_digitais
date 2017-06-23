#include <stdio.h>
#include <stdlib.h>

void somador(int a, int b, int Cin, int * Cout, int * S){
    *S = (a ^ b) ^ Cin;
    *Cout = (((a ^ b) & Cin) ^ (a & b));
}

void meioSomador(int a, int b, int * Cout, int * S){
    *S = a ^ b;
    *Cout = a & b;
}

int main(){
    int a1 = 0, b1 = 0, Cout1 = 0, S1 = 0;
    int a2 = 0, b2 = 0, Cin2 = 0, Cout2 = 0, S2 = 0;
    int a3 = 0, b3 = 0, Cin3 = 0, Cout3 = 0, S3 = 0;
    int a4 = 0, b4 = 0, Cin4 = 0, Cout4 = 0, S4 = 0;
    int a5 = 1, b5 = 1, Cin5 = 0, Cout5 = 0, S5 = 0;

    meioSomador(a1, b1, &Cout1, &S1);
    Cin2 = Cout1;
    somador(a2, b2, Cin2, &Cout2, &S2);
    Cin3 = Cout2;
    somador(a3, b3, Cin3, &Cout3, &S3);
    Cin4 = Cout3;
    somador(a4, b4, Cin4, &Cout4, &S4);
    Cin5 = Cout4;
    somador(a5, b5, Cin5, &Cout5, &S5);

    printf("%d %d %d %d %d %d\n", Cout5, S5, S4, S3, S2, S1);
    return 0;
}
