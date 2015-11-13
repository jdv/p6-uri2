use URI2::Authority::Host;
use URI2::Authority::Port;
use URI2::Authority::UserInfo;
use v6;

class URI2::Authority {
    has URI2::Authority::UserInfo $.userinfo;
    has URI2::Authority::Host $.host;
    has URI2::Authority::Port $.port;

    multi method new(\self:U: Match $a,:$default_port) {
        my %obj_attrs;
        my $obj = self.new;

        %obj_attrs<userinfo> = $obj.userinfo.new: :value(~$_)
          with $a<userinfo>;
        %obj_attrs<host> = $obj.host.new: :value(~$_) with $a<host>;
        my %port_args;
        %port_args<value> = +$_ with $a<port>;
        %port_args<default> = +$_ with $default_port;
        %obj_attrs<port> = $obj.port.new(|%port_args);

        $obj.clone(|%obj_attrs);
    }

    multi method Str (::?CLASS:D:) {
        ($_ ~ '@' with $.userinfo) ~ ($_ with $.host)
        ~ (':' ~ $.port if $.port.Str.defined && $.port.Str.chars );
    }
}

# vim:ft=perl6
