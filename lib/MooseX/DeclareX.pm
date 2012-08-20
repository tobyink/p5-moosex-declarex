package MooseX::DeclareX;

use 5.010;
use strict;
use warnings;
use utf8;

BEGIN {
	$MooseX::DeclareX::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::VERSION   = '0.001';
}

use constant DEFAULT_KEYWORDS => [qw(class role namespace exception)];
use constant DEFAULT_PLUGINS  => [qw(build)];

use Class::Load 0 qw(load_class);
use Data::OptList 0;
use MooseX::Declare 0;
use TryCatch 0;

sub import
{
	my ($class, %args) = @_;
   my $caller = ($args{into} ||= caller(0));

	$_->setup_for($caller, provided_by => $class) for __PACKAGE__->_keywords(\%args);
	
	strict->import;
	warnings->import;
	TryCatch->import({ into => $caller });
}

sub _keywords
{
	my ($class, $args) = @_;
	my @return;
	
	my $kinds = Data::OptList::mkopt( $args->{keywords} || DEFAULT_KEYWORDS );
	foreach my $pair (@$kinds)
	{
		my ($class, $opts) = @$pair;
		$opts //= {};
		
		load_class(
			my $module = join '::' => qw[MooseX DeclareX Keyword], $class
		);
		
		my $kw = $module->new( $opts->{init} ? $opts->{init} : (identifier => $class) );
		push @return, $kw;
		
		my $plugins = Data::OptList::mkopt(
			$opts->{plugins} || $args->{plugins} || DEFAULT_PLUGINS,
		);
		
		foreach my $pair2 (@$plugins)
		{
			my ($class2, $opts2) = @$pair2;
			
			my $module2 = join '::' => (qw[MooseX DeclareX Plugin], $class2);
			load_class $module2;
			
			$module2->plugin_setup($kw);
		}
	}
	
	return @return;
}


1;

__END__

=head1 NAME

MooseX::DeclareX - more sugar for MooseX::Declare

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=MooseX-DeclareX>.

=head1 SEE ALSO

L<MooseX::Declare>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

