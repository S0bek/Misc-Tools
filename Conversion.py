#!/usr/bin/python

'''Petit programme pour convertir un nombre decimal en binaire et vice-versa'''

import os
import sys
from optparse import OptionParser

prog = os.path.basename(sys.argv[0])

# Traitement des arguments
parser = OptionParser()
parser.prog = prog
parser.usage = "\n" + parser.prog + " -b 10110001\n" + parser.prog + " -d 162"
parser.description = "Outil permettant de convertir un nombre binaire en decimal, et vice-versa"
parser.add_option("-b", "--binaire", type=str, dest="binaire", help="Nombre a convertir au format decimal")
parser.add_option("-d", "--decimal", type=str, dest="deci", help="Nombre a convertir au format binaire")
(options, args) = parser.parse_args()

# On verifie les arguments fournis au programme
if (options.binaire == None) and (options.deci == None):
        parser.print_help(file=None)
        exit(1)
else:
    if options.binaire == None:
        number = options.deci

    elif options.deci == None:
        number = options.binaire

    else:
        parser.print_help(file=None)
        exit(1)

# Conversion
class Conversion(object):

    binrep = [0, 0, 0, 0, 0, 0, 0, 0]
    size = len(binrep) -1

    def __init__(self , number):
        self.number = number

    def __repr__(self):
        if not options.binaire == None:
            self.ToDecimal()
            return "La representation decimale du nombre fourni donne: %s" %  str(self.decimal)
        if not options.deci == None:
            self.ToBinary(self.number)
            return "La representation binaire du nombre fourni donne: %s" % str(self.binary)

    def ToDecimal(self):

        # On peut definir implicitement des attributs de classe qui pourront etre utilises dans toutes les methodes de la classe
        self.decimal = 0

        for cipher in self.number:
            if int(cipher) == 1:
                result = 2 ** self.size
                self.decimal += result
            self.size -= 1

        return self.decimal

    def ToBinary(self , number):
        #pass
        self.number = int(self.number)

        def ToBin(number):

            while number - (2 ** self.size) > 0:
                number -= (2 ** self.size)
                self.binrep[self.size] = 1
                self.size -= 1

            else:

                if number - (2 ** self.size) == 0:
                    self.binrep[self.size] = 1

                else:
                    self.size -= 1
                    # On reitere via la recursivite
                    ToBin(number)

            self.binary = ''.join(str(x) for x in self.binrep)[::-1]
            return self.binary

        self.binary = ToBin(self.number)

conversion = Conversion(number)
print(conversion)
