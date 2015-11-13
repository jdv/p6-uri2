use URI2::AuthorityPart;
use URI2::Build;
use URI2::LDAP::PathPart;
use URI2::Out;
use URI2::QueryPart;
use URI2::SchemePart;
use v6;

class URI2::LDAP
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::LDAP::PathPart
    does URI2::Out
    does URI2::QueryPart
    does URI2::SchemePart
{ method !default_port { 389 } }

# vim:ft=perl6
