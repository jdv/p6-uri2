use URI2::Tel::Path::Segment;
use URI2::Path;
use v6;

class URI2::Tel::Path is URI2::Path {
    has URI2::Tel::Path::Segment @.segments
      handles <list elems AT-POS EXISTS-POS>;
}

# vim:ft=perl6
