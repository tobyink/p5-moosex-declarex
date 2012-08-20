package MooseX::DeclareX::Plugin::abstract;

BEGIN {
	$MooseX::DeclareX::Plugin::abstract::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Plugin::abstract::VERSION   = '0.001';
}

use Moose;
with 'MooseX::DeclareX::Plugin';

use MooseX::Declare ();
use Moose::Util ();

sub plugin_setup
{
	my ($class, $kw) = @_;

	if ($kw->isa('MooseX::DeclareX::Keyword::class'))
	{
		$kw->register_feature(abstract => \&_abstract);
		$kw->register_feature(concrete => sub { (1) });
	}
}

sub _abstract
{
	my ($self, $ctx, $package) = @_;
	$ctx->add_scope_code_parts('use MooseX::ABC');
}

1;
