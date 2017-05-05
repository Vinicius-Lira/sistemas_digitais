#include <stdio.h>
#include <stdlib.h>

void BatalhaNaval(int p1_a, int p1_b, int p1_c, int p2_a, int p2_b, int p2_c, int * p1, int * p2){
    if((p1_a == p2_a) && (p1_b == p2_b) && (p1_c == p2_c)){
        *p1 = 1;
        *p2 = 0;
    }else{
        *p1 = 0;
        *p2 = 1;
    }

}

int main(){
    int i = 0;
    int p1_a, p1_b, p1_c, p2_a, p2_b, p2_c, p1, p2;
    for(i = 0;i < 6;i++){
        scanf("%d %d %d %d %d %d",&p1_a,&p1_b,&p1_c,&p2_a,&p2_b,&p2_c);
        BatalhaNaval(p1_a,p1_b,p1_c,p2_a,p2_b,p2_c,&p1,&p2);
        printf("%d %d %d %d %d %d resultado:S1: %d S2: %d \n",p1_a,p1_b,p1_c,p2_a,p2_b,p2_c,p1,p2);
    }
    return 0;
}
