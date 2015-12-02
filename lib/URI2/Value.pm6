use v6;
use URI2::Escape;

role URI2::Value [::T = Str] {
    has T $.value = T;

    multi method new (\self:U: Str:D :$value, *%others) {
        self.bless: |%(
            value => $value.contains('%')
              ?? URI2::Escape.unescape: $value
              !! $value,
        %others);
    }

    method canonical (::?CLASS:D:) { $.value }

    method escaped (::?CLASS:D:) { URI2::Escape.escape: $.canonical }

    multi method Str (::?CLASS:D:) { $.escaped }

    multi method Bool (::?CLASS:D:) { $.escaped ?? True !! False }
}

# vim:ft=perl6
