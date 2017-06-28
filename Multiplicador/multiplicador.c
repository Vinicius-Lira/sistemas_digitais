#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void somador(int a, int b, int Cin, int * Cout, int * S){
    *S = (a ^ b) ^ Cin;
    *Cout = (((a ^ b) & Cin) ^ (a & b));
}

void meioSomador(int a, int b, int * Cout, int * S){
    *S = a ^ b;
    *Cout = a & b;
}

int * somador10bits(int A[], int B[]){
	int Cout0 = 0;
    int Cin1 = 0, Cout1 = 0;
    int Cin2 = 0, Cout2 = 0;
    int Cin3 = 0, Cout3 = 0;
    int Cin4 = 0, Cout4 = 0;
	int Cin5 = 0, Cout5 = 0;
	int Cin6 = 0, Cout6 = 0;
	int Cin7 = 0, Cout7 = 0;
	int Cin8 = 0, Cout8 = 0;
	int Cin9 = 0, Cout9 = 0;
    int * S = (int *) calloc (10, sizeof (int));

	//Somador de 10 bits
	meioSomador(A[0], B[0], &Cout0, &S[0]);
	Cin1 = Cout0;
	somador(A[1], B[1], Cin1, &Cout1, &S[1]);
	Cin2 = Cout1;
	somador(A[2], B[2], Cin2, &Cout2, &S[2]);
	Cin3 = Cout2;
	somador(A[3], B[3], Cin3, &Cout3, &S[3]);
	Cin4 = Cout3;
	somador(A[4], B[4], Cin4, &Cout4, &S[4]);
	Cin5 = Cout4;
	somador(A[5], B[5], Cin5, &Cout5, &S[5]);
	Cin6 = Cout5;
	somador(A[6], B[6], Cin6, &Cout6, &S[6]);
	Cin7 = Cout6;
	somador(A[7], B[7], Cin7, &Cout7, &S[7]);
	Cin8 = Cout7;
	somador(A[8], B[8], Cin8, &Cout8, &S[8]);
	Cin9 = Cout8;
	somador(A[9], B[9], Cin9, &Cout9, &S[9]);

    return S;
}


void movebit(int V[], int numBit, int sizeV){
    int i = 0, j;
    int aux = 0;
    for(i = 0; i < numBit; i++){
        for(j = sizeV; j > -1; j--){
            aux = V[j - 1];
            V[j] = aux;
        }
    }
}


int main(){
	int SW[10];
	int * aux = (int *) calloc (10, sizeof (int));
	int * result = (int *) calloc (10, sizeof (int));
	int count = 0, deslocamento = 0, j;
    int i = 0;

    SW[4] = 1; SW[3] = 1; SW[2] = 1; SW[1] = 1; SW[0] = 1;

	SW[9] = 1; SW[8] = 1; SW[7] = 1; SW[6] = 1; SW[5] = 1;


    memset(result,(int)0,sizeof(int)*10);
    memset(aux,(int)0,sizeof(int)*10);

    printf("Primeiro valor:");
    for(i = 4;i > -1; i--){
        scanf("%d", &SW[i]);
    }
    printf("\nSegundo valor:");
    for(i = 9;i > 4; i--){
        scanf("%d", &SW[i]);
    }

    printf("\n\n");
    for(i = 5; i < 10; i++){
        count = 0;
        //multiplica com todos
        for(j = 0; j < 5; j++){
            aux[count] = SW[j] & SW[i];
            count++;
        }
        movebit(aux, deslocamento, 10);

        result = somador10bits(result, aux);

        memset(aux,(int)0,sizeof(int)*10);
        deslocamento++;
    }

	for(i = 9; i > -1;i--){
        printf("%d ",  result[i]);
    }
    printf("\n\n");
	return 0;
}

/*
https://www2.pcs.usp.br/~labdig/material/Exemplo_1_Multiplicador_Binario.pdf

https://es.wikibooks.org/wiki/Programaci%C3%B3n_en_Verilog/Elementos_b%C3%A1sicos_del_lenguaje#L.C3.B3gica_de_bit

*/
