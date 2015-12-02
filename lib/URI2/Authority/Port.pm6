use URI2::Value;
use v6;

class URI2::Authority::Port does URI2::Value[Int] {
    has Int $.default;

    method escaped (::?CLASS:D:) { $.canonical }

    method canonical (::?CLASS:D:) {
        $.value === $.default ?? Int !! $.value;
    }
}

# vim:ft=perl6
