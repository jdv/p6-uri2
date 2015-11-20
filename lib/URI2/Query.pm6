use URI2::Escape;
use URI2::Value;
use v6;

#TODO: break up better?
class URI2::Query does URI2::Value {
    has %.params handles <AT-KEY EXISTS-KEY>;

    has @.keywords handles <elems AT-POS EXISTS-POS>;

    method escaped (::?CLASS:D:) {
        if %!params {
            return %!params.pairs.map({
                my $k = $_.key; $_.value.map({
                    URI2::Escape.escape($k) ~ '=' ~ URI2::Escape.escape($_)
                })
            }).join('&');
        }
        elsif @!keywords { return @!keywords.join('+') }
        else { return $!value }
    }

    multi method new(\self:U: Match $q) {
        my %obj_attrs;
        my $obj = self.new;

        my $query = ~$q;
        if $query ~~ /'='/ {
            #TODO:  http/form mimetype issue...
            # does this interfere with others?
            $query .= trans('+' => ' ');
            for $query.split(/<[&;]>/) {
                my ($k, $v) = $_.split('=');
                %obj_attrs<params>{URI2::Escape.unescape($k)}.push(
                    URI2::Escape.unescape($v)
                );
            }
        }
        elsif $query ~~ /'+'/ { %obj_attrs<keywords> = $query.split('+') }
        else { %obj_attrs<value> = $query }

        $obj.clone(|%obj_attrs);
    }
}

# vim:ft=perl6
