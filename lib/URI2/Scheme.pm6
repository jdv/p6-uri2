use URI2::Value;
use v6;

class URI2::Scheme does URI2::Value {
    method canonical (::?CLASS:D:) { $.value.lc }
}

# vim:ft=perl6
