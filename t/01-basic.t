use Test;
use URI2;
use v6;

# no scheme
{
    my $u = URI2.new: '//u:p@foo.com:123/bar?baz#woo%20hoo';
    is($u.^name, 'URI2', "instance type");
    ok($u.scheme ~~ URI2::Scheme, 'scheme');
    is($u.authority, 'u:p@foo.com:123', 'authority');
    is($u.authority.userinfo, 'u:p', 'userinfo');
    is($u.authority.host, 'foo.com', 'host');
    is($u.authority.port, 123, 'port');
    is($u.path, '/bar', 'path');
    is($u.path[0], '', 'path[0]');
    is($u.path[1], 'bar', 'path[1]');
    is($u.query, 'baz', 'query');
    is($u.fragment.value, 'woo hoo', 'fragment.value');
    is($u.fragment, 'woo%20hoo', 'fragment.Str');
    is($u, '//u:p@foo.com:123/bar?baz#woo%20hoo', 'round trip');
}

# scheme class loader
{
    my $u = URI2.new: 'http://bar.com';
    is($u.^name, 'URI2::HTTP', "instance type");
    is($u, 'http://bar.com', 'round trip');
}

done-testing;

# vim:ft=perl6
