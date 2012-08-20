use 5.010;
use MooseX::DeclareX
	plugins => [qw(build having abstract)],
	;

class Primate
	is abstract
{
	#requires 'classification';  ### XXX - no worky!!!
	has 'name' => (is => 'ro', isa => 'Str');
}

class Monkey
	extends Primate
{
	has 'classification' => (is => 'ro', isa => 'Str');
}

my $bobo = Monkey::->new(name => 'Bobo');
say $bobo->name;
