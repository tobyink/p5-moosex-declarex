use Test::More tests => 1;
use MooseX::DeclareX plugins => [qw(preprocess postprocess)];

class Joiner
{
	has separator => (is => 'rw', isa => 'Str', required => 1);
	
	method go (@strings) {
		join $self->separator => @strings;
	}	
}

role DebuggerForJoiner
{
	preprocess go (@strings) {
		map { "[$_]" } @strings
	}

	postprocess go ($result) {
		return "{$result}";
	}
}

class DebuggedJoiner
	extends Joiner
	with DebuggerForJoiner;

my $j = DebuggedJoiner->new(separator => q[ ]);
is(
	$j->go(qw(foo bar baz)),
	'{[foo] [bar] [baz]}',
);
