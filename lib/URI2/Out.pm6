use v6;

role URI2::Out {
    method Str (::?CLASS:D:) {
        (self.scheme ~ ':' if self.?scheme)
          ~ ( '//' ~ self.authority if self.?authority)
          ~ (self.path if self.?path) ~ ('?' ~ self.query if self.?query)
          ~ ('#' ~ self.fragment if self.?fragment);
    }
}

# vim:ft=perl6
