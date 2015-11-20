use URI2::Value;
use v6;

class URI2::Authority::UserInfo does URI2::Value {
    method escaped (::?CLASS:D:) { $.canonical }
}

# vim:ft=perl6
