use Grammar::RFC3986;
use URI2::IndependentScheme;
use v6;

unit role URI2::Build;

multi method new (\self:U: Str $uri) { self.new(Grammar::RFC3986.parse($uri)) }

multi method new (\self:U: Match $match) {
    my $uri_or_relative_ref = $match<URI-reference><URI>
        || $match<URI-reference><relative-ref>;
    my $hier_or_relative_part = $uri_or_relative_ref<hier-part>
        || $uri_or_relative_ref<relative-part>;

    my %obj_attrs;

    my $obj;
    if self ~~ URI2::IndependentScheme {
        if $uri_or_relative_ref<scheme> -> $scheme {
            if self.scheme_to_class{$scheme} -> $scheme_class_name {
                my $scheme_class = ::($scheme_class_name);
                unless $scheme_class {
                    require ::($scheme_class_name);
                    $scheme_class = ::($scheme_class_name);
                    CATCH { default { die $_ } }
                }
                $obj = $scheme_class.new;
            }
        }
    }
    $obj //= ::?CLASS.new;

    if $uri_or_relative_ref<scheme> -> $_ {
        if self !~~ URI2::IndependentScheme {
            my $mapped_class = URI2::IndependentScheme.scheme_to_class{~$_};
            die "Class is not registered for scheme"
            if !$mapped_class || $mapped_class ne ::?CLASS.^name;
        }
        %obj_attrs<scheme> = $obj.scheme.new: :value(~$_);
    }

    {
        my $meth = $obj.^find_private_method('default_port');
        if $hier_or_relative_part<authority> -> $_ {
            %obj_attrs<authority> = $obj.authority.new(
                $_,
                |($meth ?? :default_port($meth.($obj)) !! ())
            );
        }
    }

    my @path_parts = <path-abempty path-absolute path-noscheme
        path-rootless path-empty>;
    for @path_parts {
        if $hier_or_relative_part{$_} -> $p {
            %obj_attrs<path> = $obj.path.new: $p;
            last;
        }
    }

    if $uri_or_relative_ref<query> -> $_ {
        %obj_attrs<query> = $obj.query.new: $_;
    }

    if $uri_or_relative_ref<fragment> -> $_ {
        %obj_attrs<fragment> = $obj.fragment.new: :value(~$_);
    }

    $obj.clone(|%obj_attrs);
}

# TODO: default_port will break down here
multi method mutate (\self:D: Hash:D $twiddles) {
    my $type_obj;

    if $twiddles<scheme> || self.scheme.value -> $scheme {
        my $scheme_class_name
            = URI2::IndependentScheme.new.scheme_to_class{$scheme};
        if $scheme_class_name {
            my $scheme_class = ::($scheme_class_name);
            unless $scheme_class {
                require ::($scheme_class_name);
                $scheme_class = ::($scheme_class_name);
                CATCH { default { die $_ } }
            }
            $type_obj = $scheme_class;
        }
    }
    $type_obj //= ::?CLASS;

    my @build_queue;
    my @visit_stack;
    my $obj_slots = %(map { .name.substr(2) => .type }, $type_obj.^attributes);
    my $stack_entry = [Nil, $obj_slots, $twiddles, self];
    $stack_entry[0] := $type_obj;
    @visit_stack.push: $stack_entry;

    while @visit_stack {
        my $stack_entry = @visit_stack.pop;
        my $type_obj := $stack_entry[0];
        my ($obj_slots, $twiddles, $self) = $stack_entry[1..3];

        for $obj_slots.kv -> $name, $slot_type_obj is rw {
            my ($slot, $value, $twiddles_value, $self_value);

            if $type_obj ~~ Positional {
                $slot := $obj_slots[$name];
                with $twiddles[$name] { $twiddles_value = $_ }
                with $self[$name] { $self_value = $_.clone }
            }
            elsif $type_obj ~~ Associative {
                $slot := $obj_slots{$name};
                with $twiddles{$name} { $twiddles_value = $_ }
                with $self{$name} { $self_value = $_.clone }
            }
            else {
                $slot := $obj_slots{$name};
                with $twiddles{$name} { $twiddles_value = $_ }
                with try $self.?"$name"() { $self_value = $_.clone }
            }
            $value = $twiddles_value // $self_value;

            next unless $value.defined;
            if $value.defined && $value !~~ any(Positional, Associative) {
                $slot = $value; next;
            }

            my $stack_entry = [];
            $stack_entry[0] := $slot_type_obj;

            if $slot_type_obj ~~ Positional {
                $stack_entry.push: [$slot_type_obj.of xx $value.elems];
                $slot_type_obj = Array;
            }
            elsif $slot_type_obj ~~ Associative {
                $stack_entry.push:
                  %(map { $_ => $slot_type_obj.of }, $value.keys);
                $slot_type_obj = Hash;
            }
            else {
                $stack_entry.push: %(
                    map { .name.substr(2) => .type },
                    $slot_type_obj.^attributes
                );
            }

            $stack_entry.append($twiddles_value, $self_value);
            @visit_stack.push: $stack_entry;
            $slot = $slot_type_obj;
        }

        my $queue_entry = [ Nil, $obj_slots ];
        $queue_entry[0] := $type_obj;
        @build_queue.push: $queue_entry;
    }

    while @build_queue {
        my $queue_entry = @build_queue.pop;
        my $type_obj := $queue_entry[0];
        my $obj_slots = $queue_entry[1];
        if $type_obj ~~ Associative { $type_obj .= new: (|$obj_slots) }
        else { $type_obj .= new: |$obj_slots; }
    }

    $type_obj;
}

# vim:ft=perl6
