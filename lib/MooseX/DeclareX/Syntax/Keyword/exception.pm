package MooseX::DeclareX::Syntax::Keyword::exception;

BEGIN {
	$MooseX::DeclareX::Syntax::Keyword::exception::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Syntax::Keyword::exception::VERSION   = '0.001';
}

require MooseX::Declare;
require Throwable::Error;

use Moose;
extends 'MooseX::DeclareX::Syntax::Keyword::class';

use constant preferred_identifier => 'exception';

after add_namespace_customizations => sub {
	my ($self, $ctx) = @_;
	$ctx->add_preamble_code_parts('extends qw/Throwable::Error/');
};

around auto_make_immutable => sub { 0 };

"For the manufacture of the most exceptional classes."
