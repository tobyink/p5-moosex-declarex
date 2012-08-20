package MooseX::DeclareX::Syntax::Keyword::class;

require MooseX::Declare;

use Moose;
extends 'MooseX::Declare::Syntax::Keyword::Class';
with 'MooseX::DeclareX::Plugin';

sub preferred_identifier { 'class' }

before add_namespace_customizations => sub {
	my ($self, $ctx) = @_;
	$_->setup_for($ctx->namespace, provided_by => ref $self)
		foreach @{ $self->default_inner };
};

1;