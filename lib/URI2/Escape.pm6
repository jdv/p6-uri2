use Grammar::RFC3986;
use v6;

role URI2::Escape {
    method escape (
        Str:D $unescaped_string,
        :$pattern = /<!Grammar::RFC3986::unreserved>./,
        :$code = { $_.Str.encode('UTF-8').list>>.Str>>.fmt('%%%02X').join('') }
    ) {
        $unescaped_string.subst($pattern, $code, :g);
    }

    method unescape (Str:D $escaped_string) {
        Buf.new(
            $escaped_string.subst(
                /'%' (<Grammar::RFC3986::HEXDIG> ** 2)/,
                { :16(~$0).chr },
                :g
            ).ords
        ).decode('UTF-8');
    }
}

# vim:ft=perl6
