use URI2::URN::Path::Segment;
use URI2::Path;
use v6;

class URI2::URN::Path is URI2::Path {
    has URI2::URN::Path::Segment @.segments
      handles <list elems AT-POS EXISTS-POS>;
}

# vim:ft=perl6
