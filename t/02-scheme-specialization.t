use Test;
use URI2::HTTPS;
use URI2;
use v6;

{
    diag("specialized type via constructor invocant");
    my $u = URI2::HTTPS.new: 'https://u:p@foo.com/bar?baz=123#woohoo';
    is($u.^name, 'URI2::HTTPS', "instance type");
    is($u.scheme, 'https', 'scheme');
    is($u.authority, 'u:p@foo.com', 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz=123', 'query');
    is($u.fragment, 'woohoo', 'fragment');
    is($u, 'https://u:p@foo.com/bar?baz=123#woohoo', 'round trip');
}

{
    diag("specialized type via scheme discovery");
    my $u = URI2.new: 'https://u:p@foo.com/bar?baz=123#woohoo';
    is($u.^name, 'URI2::HTTPS', "instance type");
    is($u.scheme, 'https', 'scheme');
    is($u.authority, 'u:p@foo.com', 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz=123', 'query');
    is($u.fragment, 'woohoo', 'fragment');
    is($u, 'https://u:p@foo.com/bar?baz=123#woohoo', 'round trip');
}

{
    diag("unspecialized type via scheme recognition fail");
    my $u = URI2.new: 'waffles://u:p@foo.com/bar?baz=123#woohoo';
    is($u.^name, 'URI2', "instance type");
    is($u.scheme, 'waffles', 'scheme');
    is($u.authority, 'u:p@foo.com', 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz=123', 'query');
    is($u.fragment, 'woohoo', 'fragment');
    is($u, 'waffles://u:p@foo.com/bar?baz=123#woohoo', 'round trip');
}

{
    diag("unspecialized type via scheme discovery fail");
    my $u = URI2.new( '/bar?baz=123#woohoo' );
    is($u.^name, 'URI2', "unspecialized type via scheme discovery fail");
    ok($u.scheme ~~ URI2::Scheme, 'scheme');
    ok($u.authority ~~ URI2::Authority, 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz=123', 'query');
    is($u.fragment, 'woohoo', 'fragment');
    is($u, '/bar?baz=123#woohoo', 'round trip');
}

{
    diag("fail on discovered scheme and constructor invocant mismatch");
    my $e;
    {
        URI2::HTTPS.new: 'waffles://u:p@foo.com/bar?baz=123#woohoo';
        CATCH { default { $e = $_ } }
    }
    is(~$e, 'Class is not registered for scheme', 'error');
}

done-testing;

# vim:ft=perl6
