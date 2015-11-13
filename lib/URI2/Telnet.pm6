use URI2::AuthorityPart;
use URI2::Build;
use URI2::Out;
use URI2::PathPart;
use URI2::SchemePart;
use v6;

class URI2::Telnet
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::Out
    does URI2::PathPart
    does URI2::SchemePart
{ method !default_port { 23 } }

# vim:ft=perl6
