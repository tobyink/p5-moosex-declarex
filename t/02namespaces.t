use MooseX::DeclareX keywords => [qw(class role exception)];
use Test::More tests => 2;

class Foo {
	class ::Bar {
		::is(__PACKAGE__, 'Foo::Bar');
	}
}

class Foo {
	class ::Bar {
		role ::Baz {
			exception ::Quux {
				::is(__PACKAGE__, 'Foo::Bar::Baz::Quux');
			}
		}
	}
}
