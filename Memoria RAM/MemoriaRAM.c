#include <stdio.h>
#include <stdlib.h>
#define H 20
typedef struct fPoint {
    int x;
    int y;
}Point;

float sing (Point A, Point B, Point C){
    return (A.x - C.x) * (B.y - C.y) - (B.x - C.x) * (A.y - C.y);
}

int PointInTriangle(Point pt, Point A, Point B, Point C){
    int b1 = 0, b2 = 0, b3 = 0;

    b1 = sing(pt, A, B) < 0.0f;
    b2 = sing(pt, B, C) < 0.0f;
    b3 = sing(pt, C, A) < 0.0f;

    if ((b1 == b2) && (b2 == b3)){
        return 1;
    }else
        return 0;
}

void triangle(Point P,Point A, Point B, Point C, int * PointXleft, int * PointXRigth, int * PointY){
    int x = 0, y = 0, auxLeftX = 0, auxTopY = 0;
    Point pt;
    while(1){
        pt.x = x;
        pt.y = y;
        //imprime * para desenhar triangulo
        if(PointInTriangle( pt, A, B, C)){
            //Verifica se a variavel auxLeftX for zero então PointXleft recebe a primeira posição do x do triangulo
            if(auxLeftX == 0){
                PointXleft[y] = x;
                auxLeftX = 1;
            }else{
                PointXRigth[y] = x;
            }

            if(auxTopY == 0){
                PointY[0] = y;
                auxTopY = 1;
            }else{
                PointY[1] = y;
            }
            /*
            if(((pt.x == P.x) && (pt.y == P.y)) && (PointInTriangle( P, A, B, C))){
                // printf("# ");
            }else{


            }*/
        }

        //Contadores de posição
        if(x == 100){
            x = 0;
            auxLeftX = 0;
            if(y == 20){
                y = 0;
                break;
            }else {
                y++;
            }
        }else {
            x++;
        }
    }
}


void imprimeTriangulo(int PointXLeft[], int PointXRigth[], int PointY[]){
    int x = 0, y = 0;
    while(1){
        if(y >= PointY[0] && y <= PointY[1]){
            if(x > PointXLeft[y] && x < PointXRigth[y]){
                printf("* ");
            }else{
                printf("  ");
            }
        }

        if(x == 100){
            x = 0;
            printf("\n");
            if(y == 20){
                y = 0;
                break;
            }else {
                y++;
            }
        }else {
            x++;
        }
    }
    printf("\n");
}

void inicializaVetor(int * v, int size){
    int i;
    for(i = 0; i < size; i++)
        v[i] = 0;
}

int main(){
    // int x = 0, y = 0;
    int PointXLeft[H];
    int PointXRigth[H];
    int PointY[2];
    int i;
    Point P, A, B, C;
    P.x = 12;
    P.y = 8;
    A.x = 4;
    A.y = 10;
    B.x = 15;
    B.y = 10;
    C.x = 15;
    C.y = 4;

    inicializaVetor(PointXLeft, H);
    inicializaVetor(PointXRigth, H);
    inicializaVetor(PointY, 2);

    triangle(P, A, B, C, PointXLeft, PointXRigth, PointY);
    /*for(i = 0; i < H; i++)
        printf("LEFT: %d RIGTH: %d Y: %d\n", PointXLeft[i], PointXRigth[i], PointY[0]);*/
    imprimeTriangulo( PointXLeft, PointXRigth, PointY);

    return 0;
}
