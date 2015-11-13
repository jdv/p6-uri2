use URI2::Escape;
use URI2::Value;
use v6;

class URI2::Path::Segment does URI2::Value {
    has Str $.value;

    submethod BUILD (:$!value) { $!value = URI2::Escape.unescape: $!value }
}

# vim:ft=perl6
