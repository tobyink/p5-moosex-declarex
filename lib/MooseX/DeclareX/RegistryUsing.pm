package MooseX::DeclareX::RegistryUsing;

use Moose::Role;
use MooseX::Declare::Context::WithOptions::Patch::Extensible 0.001;

around allowed_option_names => sub
{
	my $orig    = shift;
	my $self    = shift;
	
	my $allowed = $self->$orig(@_);
	push @$allowed, keys %MooseX::DeclareX::Registry::context_allow_options;
	return $allowed;
};

1;
