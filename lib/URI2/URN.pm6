use URI2::AuthorityPart;
use URI2::Build;
use URI2::FragmentPart;
use URI2::Out;
use URI2::QueryPart;
use URI2::SchemePart;
use URI2::URN::PathPart;
use v6;

class URI2::URN
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::FragmentPart
    does URI2::Out
    does URI2::QueryPart
    does URI2::SchemePart
    does URI2::URN::PathPart
{}

# vim:ft=perl6
