use Grammar::RFC3986;
use URI2::Escape;
use v6;

class URI2::Tel::Path::Segment is URI2::Path::Segment {
    method escaped (::?CLASS:D:) {
        URI2::Escape.escape(
            $.canonical,
            pattern => /[ <!Grammar::RFC3986::unreserved> & <![+]> ]./
        );
    }
}

# vim:ft=perl6
