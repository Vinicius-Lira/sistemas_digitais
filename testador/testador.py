import os
import os.path
from random import randint

def numrand():
    return randint(0, 1000)

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
    os.system("python3 PointInTriangle.py < a.in > a.out")

def comparaArq():
    arq1 = open('saidaPY.out', 'r')
    arq2 = open('saidaVerilog.out', 'r')
    saida1 = arq1.read()
    saida2 = arq2.read()
    if(saida1 == saida2):
        print("True")
    else:
        print("False")

def main(qtteste):
    qt = int(input())
    arq = open('saidaPY.out', 'w')
    for i in range(0,qtteste):
        arquivo()
        executapython()
        arq1 = open('a.out', 'r')
        saida = arq1.read()
        arq1.close()
        arq.write(str(saida))
        os.system("rm -r a.out")
        os.system("rm -r a.in")
    arq.close()

if __name__ == "__main__":
    main(100)
    comparaArq()
    if(os.path.isfile('saidaPY.out')):
        os.system("rm -r saidaPY.out")
    if(os.path.isfile('saidaVerilog.out')):
        os.system("rm -r saidaVerilog.out")
