class P:
    def __init__(self, x, y):
        self.x = x
        self.y = y

def sing(p1, p2, p3):
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);

def PointInTriangle(pt, v1, v2, v3):
    b1 = sing(pt, v1, v2) < 0.0
    b2 = sing(pt, v2, v3) < 0.0
    b3 = sing(pt, v3, v1) < 0.0

    return (b1 == b2) and (b2 == b3)

listaPx = list(range(4))
listaPy = list(range(4))
i = 0
while True:
    try:
        listaPx[i], listaPy[i] = [int(x) for x in input().split()]
        print("%d %d" %(listaPx[i], listaPy[i]))
    except EOFError:
        break
    i += 1
    if i == 4:
        X = PointInTriangle(P(listaPx[3], listaPy[3]), P(listaPx[0], listaPy[0]), P(listaPx[1], listaPy[1]), P(listaPx[2], listaPy[2]))
        print("X: ",X)
        i = 0
