package MooseX::DeclareX::Keyword::namespace;

BEGIN {
	$MooseX::DeclareX::Keyword::namespace::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Keyword::namespace::VERSION   = '0.003';
}

require MooseX::Declare;

use Moose;
extends 'MooseX::Declare::Syntax::Keyword::Namespace';
with 'MooseX::DeclareX::Plugin';
with 'MooseX::DeclareX::Registry';

has allowed_option_names => (
	is        => 'ro',
	isa       => 'ArrayRef',
	default   => sub { [] },
);

sub preferred_identifier { 'namespace' }

sub add_optional_customizations {}

1;
