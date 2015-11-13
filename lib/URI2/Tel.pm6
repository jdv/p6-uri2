use URI2::AuthorityPart;
use URI2::Build;
use URI2::Out;
use URI2::SchemePart;
use URI2::Tel::PathPart;
use v6;

class URI2::Tel
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::Out
    does URI2::SchemePart
    does URI2::Tel::PathPart
{}

# vim:ft=perl6
