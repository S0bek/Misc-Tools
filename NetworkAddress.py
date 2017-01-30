#!/usr/bin/python

'''Programme permettant de calculer automatiquement une adresse reseau pour un subnet donne
   en prenant en parametre un adresse ip et le masque de sous reseau associe
'''

ip = str(raw_input("Veuillez saisir l'adresse IP pour calculer son adresse reseau: "))
netmask = str(raw_input("Veuillez saisir le masque de sous-reseau: "))

ip_num = ip.split('.')
netmask_num = netmask.split('.')

#Fonction de conversion d'un nombre binaire en decimal
def bintodec(binary):
    dec = 0
    base = 8

    if len(binary) > base: return
    base -= 1

    for bit in binary:
        if bit == '1':
            dec += 2 ** base
        base -= 1

    return str(dec)

#Fonction de calcul de l'adresse reseau du subnet dans laquelle se trouve l'ip fournie en parametre en fonction du netmask associe
def compute_subnet(ip , netmask):
    subnet = ''
    subnet_address = ''

    if not (type(ip) == list and type(netmask) == list): return 1

    for i in range(0 , len(ip)):
        dec = bin(int(ip[i]))[2:].zfill(8)
        netdec = bin(int(netmask[i]))[2:].zfill(8)

        for i in range(0 , len(dec)):
            if dec[i] == '1' and netdec[i] == '1':
                subnet += '1'
            else:
                subnet += '0'
        subnet_address += subnet + "."
        subnet = ''

    subnet_address = subnet_address[0:-1:]
    subnet_address = "".join([bintodec(byte) + "." for byte in subnet_address.split(".")])[0:-1:]
    return subnet_address

#Corps principal du script
print("\nAdresse reseau calculee pour le subnet: %s" % (compute_subnet(ip_num , netmask_num)))


