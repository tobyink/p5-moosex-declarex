package MooseX::DeclareX::Syntax::Keyword::role;

require MooseX::Declare;

use Moose;
extends 'MooseX::Declare::Syntax::Keyword::Role';
with 'MooseX::DeclareX::Plugin';
with 'MooseX::DeclareX::Registry';

sub preferred_identifier { 'role' }

before add_namespace_customizations => sub {
	my ($self, $ctx) = @_;
	$_->setup_for($ctx->namespace, provided_by => ref $self)
		foreach @{ $self->default_inner };
};

1;
