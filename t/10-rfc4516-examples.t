use Test;
use URI2;
use v6;

#ldap:///o=University%20of%20Michigan,c=US
#ldap://ldap1.example.net/o=University%20of%20Michigan,c=US
#ldap://ldap1.example.net/o=University%20of%20Michigan,c=US?postalAddress
#ldap://ldap1.example.net:6666/o=University%20of%20Michigan,c=US??sub?(cn=Babs%20Jensen)
#LDAP://ldap1.example.com/c=GB?objectClass?ONE
#ldap://ldap2.example.com/o=Question%3f,c=US?mail
#ldap://ldap3.example.com/o=Babsco,c=US???(four-octet=%5c00%5c00%5c00%5c04)
#ldap://ldap.example.com/o=An%20Example%5C2C%20Inc.,c=US
#
## eq
#ldap://ldap.example.net
#ldap://ldap.example.net/
#ldap://ldap.example.net/?
#
#ldap:///??sub??e-bindname=cn=Manager%2cdc=example%2cdc=com
#ldap:///??sub??!e-bindname=cn=Manager%2cdc=example%2cdc=com

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

done-testing;

# vim:ft=perl6
