use Test;
use URI2::Escape;
use v6;

{
    my $str = "foo \r\nbar";
    my $str_escaped = URI2::Escape.escape: $str;
    is($str_escaped, 'foo%20%0D%0Abar', 'escape basic' );
    is(URI2::Escape.unescape($str_escaped), $str, 'unescape basic' );
}

{
    my $str = 'a-zA..Z0~9~';
    my $str_escaped = URI2::Escape.escape: $str;
    ok($str_escaped eq $str, 'unreserved "escaped"' );
    is(URI2::Escape.unescape($str_escaped), $str, '"unescape" unreserved' );
}

{
    my $str = "drücken \x1F639 D\x0323\x0307";
    my $str_escaped = URI2::Escape.escape: $str;
    is($str_escaped, 'dr%C3%BCcken%20%F0%9F%98%B9%20%E1%B8%8C%CC%87',
      'escape unicode');
    is(URI2::Escape.unescape($str_escaped), $str, 'unescape unicode' );
}

{
    my $str = "abc";
    my $str_escaped = URI2::Escape.escape($str, :pattern(/<![ac]>./));
    is($str_escaped, 'a%62c', 'escape pattern');
}

done-testing;

# vim:ft=perl6
