import os
import os.path
from random import randint
from math import sqrt

def numrand():
    return randint(-10, 10)

def verificaTriangulo(Ax, Ay, Bx,  By, Cx, Cy ):
    '''
            Distancia entre dois pontos : d2AB = (XB – XA)2 + (YB -YA)2
                                /\
                              /    \
                        A  /        \ B
                           /           \
                         /_______\
                                C
            Condições de existencia de um triangulo:
                                | b - c | < a < b + c
                                | a - c | < b < a + c
                                | a - b | < c < a + b
    '''
    A = sqrt( ((Bx - Ax)**2) + ((By - Ay)**2))
    B = sqrt( ((Cx - Ax)**2) + ((Cy - Ay)**2))
    C = sqrt( ((Cx - Bx)**2) + ((Cy - By)**2))

    if( ((abs(B - C)) < A < B + C) & ((abs(A - C)) < B < A + C) & ((abs(A - B)) < C < A + B)):
        return True
    else:
        return False

# sorteia 4 coordenadas de um triangulo
def arquivo():
    arq = open('a.in', 'w')
    while True:
        x1 = numrand()
        y1 = numrand()
        x2 = numrand()
        y2 = numrand()
        x3 = numrand()
        y3 = numrand()
        if(verificaTriangulo(x1, y1, x2,  y2, x3, y3 )):
            break
    xpt = numrand()
    ypt = numrand()
    arq.write(str(x1)+" "+str(y1)+"\n")
    arq.write(str(x2)+" "+str(y2)+"\n")
    arq.write(str(x3)+" "+str(y3)+"\n")
    arq.write(str(xpt)+" "+str(ypt)+"\n")
    arq.close()

def executapython():
    os.system("python3 PointInTriangle.py < a.in > singPY.txt")

def executaverilog():
    os.system("iverilog sing.v -o sing")
    os.system("./sing")


def comparaArq():
    if((os.system("diff -q saidaSingPy.txt saidaSingVerilog.txt")) == 0):
        print("Saidas iguais!\n")
    else:
        print("Saidas diferentes!\n")

def main():
    qt = int(input())
    arqPointInTriangle = open('saidaSingPy.txt', 'w')
    arqSing = open('saidaSingVerilog.txt', 'w')
    for i in range(0,qt):
        arquivo()
        executapython()
        executaverilog()
        arqPY = open('singPY.txt', 'r')
        arqVerilog = open('singVerilog.txt', 'r')
        saidapy = arqPY.read()
        saidaverilog = arqVerilog.read()
        arqPY.close()
        arqVerilog.close()
        if(saidapy != saidaverilog):
            arq = open('teste.txt', 'w')
            arq.write("Saida PY: " +saidapy)
            arq.write("Saida Verilog: " +saidaverilog)
            arqin = open('a.in', 'r')
            textoin = arqin.read()
            arqin.close()
            arq.write(textoin+"\n")
            arq.close()

        arqPointInTriangle.write(str(saidapy))
        arqSing.write(str(saidaverilog))
    arqPointInTriangle.close()
    arqSing.close()

if __name__ == "__main__":
    main()
    comparaArq()
    if(os.path.isfile('saidaSingPy.txt')):
        os.system("rm -r saidaSingPy.txt")
    if(os.path.isfile('saidaSingVerilog.txt')):
        os.system("rm -r saidaSingVerilog.txt")
    if(os.path.isfile('singPY.txt')):
        os.system("rm -r singPY.txt")
    if(os.path.isfile('singVerilog.txt')):
        os.system("rm -r singVerilog.txt")
    if(os.path.isfile('a.in')):
        os.system("rm -r a.in")
    if(os.path.isfile('sing')):
        os.system("rm -r sing")
