use Test;
use URI2;
use v6;

{
    my $u_str = 'ftp://ftp.is.co.za/rfc/rfc1808.txt';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::FTP', "instance type");
    is($u.scheme, 'ftp', 'scheme');
    is($u.authority, 'ftp.is.co.za', 'authority');
    is($u.path, '/rfc/rfc1808.txt', 'path');
    ok($u.query ~~ URI2::Query, 'query');
    ok($u.fragment ~~ URI2::Fragment, 'fragment');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'http://www.ietf.org/rfc/rfc2396.txt';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::HTTP', "instance type");
    is($u.scheme, 'http', 'scheme');
    is($u.authority, 'www.ietf.org', 'authority');
    is($u.path, '/rfc/rfc2396.txt', 'path');
    ok($u.query ~~ URI2::Query, 'query');
    ok($u.fragment ~~ URI2::Fragment, 'fragment');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'ldap://[2001:db8::7]/c=GB?objectClass?one';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::LDAP', "instance type");
    is($u.scheme, 'ldap', 'scheme');
    is($u.authority, '[2001:db8::7]', 'authority');
    is($u.path, '/c=GB', 'path');
    is($u.query, 'objectClass?one', 'query');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'mailto:John.Doe@example.com';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::MailTo', "instance type");
    is($u.scheme, 'mailto', 'scheme');
    ok($u.authority ~~ URI2::Authority, 'authority');
    is($u.path, 'John.Doe@example.com', 'path');
    ok($u.query ~~ URI2::Query, 'query');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'news:comp.infosystems.www.servers.unix';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::News', "instance type");
    is($u.scheme, 'news', 'scheme');
    ok($u.authority ~~ URI2::Authority, 'authority');
    is($u.path, 'comp.infosystems.www.servers.unix', 'path');
    ok($u.query ~~ URI2::Query, 'query');
    ok($u.fragment ~~ URI2::Fragment, 'fragment');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'tel:+1-816-555-1212';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::Tel', "instance type");
    is($u.scheme, 'tel', 'scheme');
    ok($u.authority ~~ URI2::Authority, 'authority');
    is($u.path, '+1-816-555-1212', 'path');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'telnet://192.0.2.16:80/';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::Telnet', "instance type");
    is($u.scheme, 'telnet', 'scheme');
    is($u.authority, '192.0.2.16:80', 'authority');
    is($u.path, '/', 'path');
    is($u, $u_str, 'round trip');
}

{
    my $u_str = 'urn:oasis:names:specification:docbook:dtd:xml:4.1.2';
    diag($u_str);
    my $u = URI2.new: $u_str;
    is($u.^name, 'URI2::URN', "instance type");
    is($u.scheme, 'urn', 'scheme');
    ok($u.authority ~~ URI2::Authority, 'authority');
    is($u.path, 'oasis:names:specification:docbook:dtd:xml:4.1.2', 'path');
    ok($u.query ~~ URI2::Query, 'query');
    ok($u.fragment ~~ URI2::Fragment, 'fragment');
    is($u, $u_str, 'round trip');
}

done-testing;

# vim:ft=perl6
