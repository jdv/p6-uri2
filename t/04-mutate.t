use Test;
use URI2;
use v6;

{
    diag('schemeless to ftp');
    my $u = URI2.new: '//u:p@foo.com:123/bar?baz#woo%20hoo';
    my $u2 = $u.mutate({
        scheme => { value => 'ftp', },
        authority => { port => { value => 999, }, },
    });
    is($u2, 'ftp://u:p@foo.com:999/bar?baz#woo%20hoo', 'round trip');
}

{
    diag('http to ftp');
    my $u = URI2.new: 'http://u:p@foo.com:123/bar?baz=456#woo%20hoo';
    my $u2 = $u.mutate({
        scheme => { value => 'ftp', },
        authority => { port => { value => 999, }, },
    });
    is($u2, 'ftp://u:p@foo.com:999/bar?baz=456#woo%20hoo', 'round trip');
}

{
    diag('everything');
    my $u = URI2.new: 'http://u:p@foo.com:123/bar?baz=456#woo%20hoo';
    my $u2 = $u.mutate({
        scheme => { value => 'ftp', },
        authority => {
            host => { value => '10.1.2.3', },
            port => { value => 999, },
            userinfo => { value => 'u2:p3', },
        },
        path => {
            segments => [
                { value => '', },
                { value => 'bla', },
            ],
        },
        query => {
            params => {
                bla => '4321',
            },
        },
    });
    is($u2, 'ftp://u2:p3@10.1.2.3:999/bla?bla=4321#woo%20hoo', 'round trip');
}

done-testing;

# vim:ft=perl6
