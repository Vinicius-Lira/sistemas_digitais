#include <stdio.h>
#include <stdlib.h>

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

void triangle_1(){
    int x = 10, y = 10;
    int i = 11, k = 60;
    while(1){
        if((x > 10) && (x <= i) && (y < k)){
            printf("#");
        }
        if(x == 100){
            x = 0;
            printf("\n");
            if(y == 80){
                y = 0;
                break;
            }else {
                y++;
                i++;
                k++;
            }
        }else {
            x++;
        }
    }
}

void triangle_2(Point P,Point A, Point B, Point C){
    int x = 0, y = 0;
    Point pt;
    while(1){
        pt.x = x;
        pt.y = y;
        //imprime * para desenhar triangulo
        if(PointInTriangle( pt, A, B, C)){
            if(((pt.x == P.x) && (pt.y == P.y)) && (PointInTriangle( P, A, B, C))){
                printf("# ");
            }else{
                printf("* ");
            }
        }else{
            printf("  ");
        }

        //Contadores de posição
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
}

int main(){
    // triangle_1();
    Point A, B, C, P;
    A.x = 3;
    A.y = 5;
    B.x = 10;
    B.y = 1;
    C.x = 10;
    C.y = 8;
    P.x = 5;
    P.y = 5;
    triangle_2(P, A, B, C);
    printf("\n\n");
    return 0;
}
