import os
import os.path
from random import randint

def numrand():
    return randint(0, 1000)
# sorteia 4 coordenadas de um triangulo
def arquivo():
    arq = open('a.in', 'w')
    for i in range(0, 4):
        x = numrand()
        y = numrand()
        arq.write(str(x)+" "+str(y))
        if(i < 3):
            arq.write("\n")
    arq.close()

def executapython():
    os.system("python3 PointInTriangle.py < a.in > singPY.txt")

def executaverilog():
    os.system("./sing")


def comparaArq():
    arq1 = open('saidaSingPy.out', 'r')
    arq2 = open('saidaSingVerilog.out', 'r')
    saida1 = arq1.read()
    saida2 = arq2.read()
    if(saida1 == saida2):
        print("True")
    else:
        print("False")

def main():
    qt = int(input())
    arqPointInTriangle = open('saidaSingPy.out', 'w')
    arqSing = open('saidaSingVerilog.out', 'w')
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
        arqPointInTriangle.write(str(saidapy))
        arqSing.write(str(saidaverilog))
    arqPointInTriangle.close()
    arqSing.close()

if __name__ == "__main__":
    main()
    comparaArq()
    '''if(os.path.isfile('saidaSingPy.out')):
        os.system("rm -r saidaSingPy.out")
    if(os.path.isfile('saidaSingVerilog.out')):
        os.system("rm -r saidaSingVerilog.out")
    if(os.path.isfile('singPY.txt')):
        os.system("rm -r singPY.txt")
    if(os.path.isfile('singVerilog.txt')):
        os.system("rm -r singVerilog.txt")
    if(os.path.isfile('a.in')):
        os.system("rm -r a.in")'''
