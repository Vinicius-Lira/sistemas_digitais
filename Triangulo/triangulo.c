#include <stdio.h>
#include <stdlib.h>

struct fPoint {
    float x;
    float y;
};

float sing (struct fPoint p1, struct fPoint p2, struct fPoint p3){
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

int PointInTriangle(struct fPoint pt, struct fPoint v1, struct fPoint v2, struct fPoint v3){
    int b1 = 0, b2 = 0, b3 = 0;

    b1 = sing(pt, v1, v2) < 0.0f;
    b2 = sing(pt, v2, v3) < 0.0f;
    b3 = sing(pt, v3, v1) < 0.0f;

    if ((b1 == b2) && (b2 == b3)){
        return 1;
    }else
        return 0;
}

int main(){
    struct fPoint point1;
    struct fPoint point2;
    struct fPoint point3;
    struct fPoint pt;
    scanf("%f %f", &point1.x, &point1.y);
    scanf("%f %f", &point2.x, &point2.y);
    scanf("%f %f", &point3.x, &point3.y);
    scanf("%f %f", &pt.x, &pt.y);
    printf("%d\n", PointInTriangle(pt, point1, point2, point3));
    return 0;
}
