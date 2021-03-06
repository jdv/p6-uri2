use URI2::Value;
use v6;

class URI2::Authority::Host does URI2::Value {
    method escaped (::?CLASS:D:) { $.canonical }

    method canonical (::?CLASS:D:) { $.value.lc }
}

# vim:ft=perl6
