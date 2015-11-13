use URI2::AuthorityPart;
use URI2::Build;
use URI2::MailTo::PathPart;
use URI2::Out;
use URI2::QueryPart;
use URI2::SchemePart;
use v6;

class URI2::MailTo
    does URI2::AuthorityPart
    does URI2::Build
    does URI2::MailTo::PathPart
    does URI2::Out
    does URI2::QueryPart
    does URI2::SchemePart
{}

# vim:ft=perl6
