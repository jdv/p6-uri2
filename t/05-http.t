use Test;
use URI2;
use v6;

{
    diag('query form');
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
    #TODO: does anyone use this?  is it needed?  where is it spec'd?
    diag('query keywords');
    my $u = URI2.new: 'https://u:p@foo.com/bar?baz+123#woohoo';
    is($u.^name, 'URI2::HTTPS', "instance type");
    is($u.scheme, 'https', 'scheme');
    is($u.authority, 'u:p@foo.com', 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz+123', 'query');
    is($u.fragment, 'woohoo', 'fragment');
    is($u, 'https://u:p@foo.com/bar?baz+123#woohoo', 'round trip');
}

{
    diag('the html form mime type plus is a space thing');
    my $u = URI2.new: 'http://u:p@foo.com/bar?baz+space=123+456';
    is($u.^name, 'URI2::HTTP', "instance type");
    is($u.scheme, 'http', 'scheme');
    is($u.authority, 'u:p@foo.com', 'authority');
    is($u.path, '/bar', 'path');
    is($u.query, 'baz%20space=123%20456', 'query');
    ok($u.fragment ~~ URI2::Fragment, 'fragment');
    is($u, 'http://u:p@foo.com/bar?baz%20space=123%20456', 'round trip');
}

{
    #TODO move this
    diag('port');
    my $u = URI2.new: 'http://foo.com:80';
    is($u, 'http://foo.com', 'round trip');
    my $u2 = URI2.new: 'http://foo.com:81';
    is($u2, 'http://foo.com:81', 'round trip');
}

done-testing;

# vim:ft=perl6
