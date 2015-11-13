use v6;

grammar Grammar::RFC3986 {
    token TOP { ^ <URI-reference> $ }

    # URI = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
    token URI { <scheme> ':' <hier-part> [ '?' <query> ]? [ '#' <fragment> ]? }

    # hier-part = "//" authority path-abempty / path-absolute / path-rootless
    # / path-empty
    token hier-part {
        '//' <authority> <path-abempty> || <path-absolute> || <path-rootless>
        || <path-empty>
    }

    # URI-reference = URI / relative-ref
    token URI-reference { <URI> || <relative-ref> }

    # absolute-URI = scheme ":" hier-part [ "?" query ]
    token absolute-URI { <scheme> ':' <hier-part> [ '?' <query> ]? }

    # relative-ref = relative-part [ "?" query ] [ "#" fragment ]
    token relative-ref {
        <relative-part> [ '?' <query> ]? [ '#' <fragment> ]?
    }

    # relative-part = "//" authority path-abempty / path-absolute
    # / path-noscheme / path-empty
    token relative-part {
        '//' <authority> <path-abempty> || <path-absolute> || <path-noscheme>
        || <path-empty>
    }

    # scheme = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
    token scheme { <ALPHA> [ <ALPHA> || <DIGIT> || < + - . > ]* }

    # authority = [ userinfo "@" ] host [ ":" port ]
    token authority { [ <userinfo> '@' ]? <host> [ ':' <port> ]? }

    # userinfo = *( unreserved / pct-encoded / sub-delims / ":" )
    token userinfo {
        [ <unreserved> || <pct-encoded> || <sub-delims> || ':' ]*
    }

    # host = IP-literal / IPv4address / reg-name
    token host { <IP-literal> || <IPv4address> || <reg-name> }

    # port = *DIGIT
    token port { <DIGIT>* }

    # IP-literal = "[" ( IPv6address / IPvFuture  ) "]"
    token IP-literal { '[' [ <IPv6address> || <IPvFuture> ] ']' }

    # IPvFuture = "v" 1*HEXDIG "." 1*( unreserved / sub-delims / ":" )
    token IPvFuture {
        'v' <HEXDIG>+ '.' [ <unreserved> || <sub-delims> || ':' ]+
    }

    #IPv6address   =                            6( h16 ":" ) ls32
    #              /                       "::" 5( h16 ":" ) ls32
    #              / [               h16 ] "::" 4( h16 ":" ) ls32
    #              / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32
    #              / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32
    #              / [ *3( h16 ":" ) h16 ] "::"    h16 ":"   ls32
    #              / [ *4( h16 ":" ) h16 ] "::"              ls32
    #              / [ *5( h16 ":" ) h16 ] "::"              h16
    #              / [ *6( h16 ":" ) h16 ] "::"
    token IPv6address {
                                                  [<h16>':']**6<ls32>
        ||                                     '::'[<h16>':']**5<ls32>
        ||                              <h16> ?'::'[<h16>':']**4<ls32>
        ||[[<h16>':'<!before ':'>]?     <h16>]?'::'[<h16>':']**3<ls32>
        ||[[<h16>':'<!before ':'>]**0..2<h16>]?'::'[<h16>':']**2<ls32>
        ||[[<h16>':'<!before ':'>]**0..3<h16>]?'::' <h16>':'    <ls32>
        ||[[<h16>':'<!before ':'>]**0..4<h16>]?'::'             <ls32>
        ||[[<h16>':'<!before ':'>]**0..5<h16>]?'::'             <h16>
        ||[[<h16>':'<!before ':'>]**0..6<h16>]?'::'
    }

    # h16 = 1*4HEXDIG
    token h16 { <HEXDIG> ** 1..4 }

    # ls32 = ( h16 ":" h16 ) / IPv4address
    token ls32 { [ <h16> ':' <h16> ] || <IPv4address> }

    # IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet
    token IPv4address       {
        <dec-octet> '.' <dec-octet> '.' <dec-octet> '.' <dec-octet>
    }

    # dec-octet = DIGIT             ; 0-9
    #           / %x31-39 DIGIT     ; 10-99
    #           / "1" 2DIGIT        ; 100-199
    #           / "2" %x30-34 DIGIT ; 200-249
    #           / "25" %x30-35      ; 250-255
    token dec-octet {
        <DIGIT>
        || <[1..9]> <DIGIT>
        || '1' <DIGIT> <DIGIT>
        || '2' <[0..4]> <DIGIT>
        || '25' <[0..5]>
    }

    # reg-name = *( unreserved / pct-encoded / sub-delims )
    token reg-name { [ <unreserved> || <pct-encoded> || <sub-delims> ]* }

    # path = path-abempty  ; begins with "/" or is empty
    #      / path-absolute ; begins with "/" but not "//"
    #      / path-noscheme ; begins with a non-colon segment
    #      / path-rootless ; begins with a segment
    #      / path-empty    ; zero characters
    token path {
        <path-abempty> || <path-absolute> || <path-noscheme> || <path-rootless>
        || <path-empty>
    }

    # path-abempty  = *( "/" segment )
    token path-abempty { [ '/' <segment> ]* }

    # path-absolute = "/" [ segment-nz *( "/" segment ) ]
    token path-absolute { '/' [ <segment-nz> [ '/' <segment> ]* ]? }

    # path-noscheme = segment-nz-nc *( "/" segment )
    token path-noscheme { <segment-nz-nc> [ '/' <segment> ]* }

    # path-rootless = segment-nz *( "/" segment )
    token path-rootless { <segment-nz> [ '/' <segment> ]* }

    # path-empty = ""
    # changed as per Errata ID: 2033
    token path-empty { '' }

    # segment = *pchar
    token segment { <pchar>* }

    # segment-nz = 1*pchar
    token segment-nz { <pchar>+ }

    # segment-nz-nc = 1*( unreserved / pct-encoded / sub-delims / "@" )
    #               ; non-zero-length segment without any colon ":"
    token segment-nz-nc {
        [ <unreserved> || <pct-encoded> || <sub-delims> || '@' ]+
    }

    # pchar = unreserved / pct-encoded / sub-delims / ":" / "@"
    token pchar { <unreserved> || <pct-encoded> || <sub-delims> || < : @ > }

    # query = *( pchar / "/" / "?" )
    token query { [ <pchar> || < / ? > ]* }

    # fragment = *( pchar / "/" / "?" )
    token fragment { [ <pchar> || < / ? > ]* }

    # pct-encoded = "%" HEXDIG HEXDIG
    token pct-encoded { '%' <HEXDIG> <HEXDIG> }

    # unreserved = ALPHA / DIGIT / "-" / "." / "_" / "~"
    token unreserved { <ALPHA> || <DIGIT> || < - . _ ~ > }

    # reserved = gen-delims / sub-delims
    token reserved { <gen-delims> || <sub-delims> }

    # gen-delims = ":" / "/" / "?" / "#" / "[" / "]" / "@"
    token gen-delims { < : / ? # [ ] @ > }

    # sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
    #               / "*" / "+" / "," / ";" / "="
    token sub-delims { < ! $ & ' ( ) * + , ; = > }

    # HEXDIG =  DIGIT / "A" / "B" / "C" / "D" / "E" / "F"
    #        / "a" / "b" / "c" / "d" / "e" / "f"
    # added a..z as per section 2.1 of rfc3986
    token HEXDIG { [ <DIGIT> || <[A..F]> || <[a..f]> ] }

    # ALPHA = %x41-5A / %x61-7A  ; A-Z / a-z
    token ALPHA { <[A..Za..z]> }

    # DIGIT =  %x30-39 ; 0-9
    token DIGIT { <[0..9]> }
}

# vim:ft=perl6
