use URI2::Value;
use v6;

class URI2::Authority::Port does URI2::Value {
    has Int $.value;
    has Int $.default;

    method escaped (::?CLASS:D:) { $.canonical }

    #TODO: fix this
    method canonical (::?CLASS:D:) {
        $.value.defined && $.default.defined
          && $.value == $.default
          ?? ''
          !! $.value;
    }
}

# vim:ft=perl6
