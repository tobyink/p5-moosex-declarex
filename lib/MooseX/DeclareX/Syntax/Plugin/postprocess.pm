package MooseX::DeclareX::Syntax::Plugin::postprocess;

BEGIN {
	$MooseX::DeclareX::Syntax::Plugin::postprocess::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Syntax::Plugin::postprocess::VERSION   = '0.001';
}

use Moose;
with 'MooseX::DeclareX::Plugin';

use MooseX::Declare ();
use Moose::Util ();

sub plugin_setup
{
	my ($class, $kw) = @_;
	
	$kw->meta->add_around_method_modifier('default_inner', \&_default_inner)
		if $kw->can('default_inner');
}

sub _default_inner
{
	my $orig = shift;
	my $self = shift;
	
	my $return = $self->$orig(@_);
	
	push @$return,
		'MooseX::DeclareX::Feature::Plugin::postprocess'->new(
			identifier    => 'postprocess',
			modifier_type => 'around',
		);
	
	return $return;
}

package MooseX::DeclareX::Feature::Plugin::postprocess;

use Moose;
extends 'MooseX::Declare::Syntax::Keyword::MethodModifier';

override register_method_declaration => sub
{
	my ($me, $meta, $name, $method) = @_;
	
	my $subroutine = sub
	{
		my $orig = shift;
		my $self = shift;
		
		if (wantarray)
		{
			my @rv = $self->$orig(@_);
			return $method->body->($self, @rv);
		}
		elsif (defined wantarray)
		{
			my $rv = $self->$orig(@_);
			return $method->body->($self, $rv);
		}
		else
		{
			unshift @_, $self;
			goto $orig;
		}
	};
	
	return Moose::Util::add_method_modifier(
		$meta->name,
		$me->modifier_type,
		[$name => $subroutine],
	);
};

1;
