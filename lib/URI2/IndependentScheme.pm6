use v6;

role URI2::IndependentScheme {
    method scheme_to_class {
        {
            ftp    => 'URI2::FTP',
            http   => 'URI2::HTTP',
            https  => 'URI2::HTTPS',
            ldap   => 'URI2::LDAP',
            mailto => 'URI2::MailTo',
            news   => 'URI2::News',
            tel    => 'URI2::Tel',
            telnet => 'URI2::Telnet',
            urn    => 'URI2::URN',
        }
    }
}

# vim:ft=perl6
