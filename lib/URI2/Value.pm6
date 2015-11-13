use v6;
use URI2::Escape;

role URI2::Value {
    method canonical (::?CLASS:D:) { $.value }

    method escaped (::?CLASS:D:) { URI2::Escape.escape: $.canonical }

    method Str (::?CLASS:D:) { $.escaped }
}

# vim:ft=perl6
