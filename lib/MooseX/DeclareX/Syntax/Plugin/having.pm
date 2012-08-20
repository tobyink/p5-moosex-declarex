package MooseX::DeclareX::Syntax::Plugin::having;

BEGIN {
	$MooseX::DeclareX::Syntax::Plugin::having::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Syntax::Plugin::having::VERSION   = '0.001';
}

use Moose;
with 'MooseX::DeclareX::Plugin';

use MooseX::Declare ();
use Moose::Util ();

sub plugin_setup
{
	my ($class, $kw) = @_;
	
	Moose::Util::apply_all_roles(
		$kw,
		'MooseX::DeclareX::Feature::Plugin::having',
	);
	
	MooseX::Declare::Context::WithOptions->meta->add_around_method_modifier(
		allowed_option_names => sub {
			my ($orig, $self, $x) = @_;
			if ($x)
			{
				push @$x, 'having';
				return $self->$orig($x);
			}
			else
			{
				$x = $self->$orig();
				push @$x, 'having';
				return $x;
			}
		}
	);
}

package MooseX::DeclareX::Feature::Plugin::having;

use Moose::Role;
	
sub add_having_option_customizations
{
	my ($self, $ctx, $package, $attribs) = @_;
	my @code_parts;
	push @code_parts, sprintf(
		"has [%s] => (is => q/ro/, isa => q/Any/)\n",
		join ', ',
			map { "q/$_/" }
			@{ ref $attribs ? $attribs : [$attribs] }
		);
	$ctx->add_scope_code_parts(@code_parts);
	return 1;
}

1;
