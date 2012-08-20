package MooseX::DeclareX::Syntax::Keyword::namespace;

require MooseX::Declare;

use Moose;
extends 'MooseX::Declare::Syntax::Keyword::Namespace';
with 'MooseX::DeclareX::Plugin';

sub preferred_identifier { 'namespace' }

sub add_optional_customizations {}

1;
