use MooseX::DeclareX
	keywords => [qw(class role exception)],
	;

exception MonkeyError
{
	has bananas => (is => 'ro', isa => 'Num');
}

MonkeyError->throw(bananas => 2, message => "Not enough bananas!");

