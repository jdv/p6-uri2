use URI2::Path::Segment;
use v6;

class URI2::Path {
    has URI2::Path::Segment @.segments
      handles <list elems AT-POS EXISTS-POS>;

    multi method new (\self:U: Match $p) {
        my $obj = self.new;
        $obj.clone(
            segments => [$p.split('/').map: {
                $obj.segments.of.new: :value($_)
            }],
        );
    }

    method Str (::?CLASS:D:) {
        @.segments.map({ $_ ?? $_ !! '' }).join('/');
    }
}

# vim:ft=perl6
