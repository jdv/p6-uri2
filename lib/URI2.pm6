use URI2::AuthorityPart;
use URI2::Build;
use URI2::FragmentPart;
use URI2::IndependentScheme;
use URI2::Out;
use URI2::PathPart;
use URI2::QueryPart;
use URI2::SchemePart;
use v6;

role URI2
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::FragmentPart
    does URI2::IndependentScheme
    does URI2::Out
    does URI2::PathPart
    does URI2::QueryPart
    does URI2::SchemePart
{}

# vim:ft=perl6
