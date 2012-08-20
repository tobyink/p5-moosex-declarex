package MooseX::DeclareX::Plugin::private;

use Moose;
with 'MooseX::DeclareX::Plugin';

use MooseX::Declare ();
use Moose::Util ();
use MooseX::Privacy ();
use MooseX::Privacy::Meta::Method::Private ();

sub plugin_setup
{
	my ($class, $kw) = @_;
	
	Moose::Util::apply_all_roles(
		$kw,
		'MooseX::DeclareX::Plugin::private::Role',
	)
		if $kw->can('add_namespace_customizations');
}

package MooseX::DeclareX::Plugin::private::Role;

use Moose::Role;

after add_namespace_customizations => sub 
{
	my ($self, $ctx, $package, $attribs) = @_;
	$ctx->add_scope_code_parts(
		"BEGIN { MooseX::DeclareX::Plugin::private::Parser->import() }",
		"BEGIN { Moose::Util::MetaRole::apply_metaroles(for => __PACKAGE__, class_metaroles => { class => ['MooseX::Privacy::Meta::Class'] }) }",
	);
	return 1;
};

package MooseX::DeclareX::Plugin::private::Parser;

use Moose;
extends 'MooseX::DeclareX::MethodPrefix';

override prefix_keyword => sub { 'private' };
override install_method => sub {
	my ($self, $method) = @_;
	my $wrapped = 'MooseX::Privacy::Meta::Method::Private'->wrap(
		name          => $method->name,
		package_name  => $method->package_name,
		body          => $method,
	);
	Class::MOP::class_of( $method->package_name )
		->add_private_method($method->name, $wrapped);
};

1;

