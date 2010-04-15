use strict;

use PPI::Document;
use PPI::Dumper;


# Load a document
my $Document = PPI::Document->new( $ARGV[0] );

my $sub_nodes = $Document->find( 
    sub { $_[1]->isa('PPI::Statement::Sub') }
);

foreach my $sub (@{ $sub_nodes }) {
    print "Sub '".$sub->name."' has the following variables:\n";
    my $symbols   = $sub->find(
        sub { $_[1]->isa('PPI::Token::Symbol') }
    );
    my $var_nodes = $sub->find(
        sub { $_[1]->isa('PPI::Statement::Variable') }
    );

    print "\tVariable Declarations:\n";
    print "\t\t" . $_->symbols . " - [ " . join( ',', @{ $_->location } ) . "]\n" for @$var_nodes;
    print "\tTokens:\n";
    foreach my $var ( @{ $symbols } ) {
        print "\t\t" . $var->symbol ." - [ ". join( ',', @{ $var->location } ) . "]\n";
    }

}

