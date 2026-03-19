=begin comment

For any of the B<SOLO> items that have display issues, add those to the skiplist.
These can be done in bulk.

For any of the B<COMBO> items, skip them if a significant percentage of the combinations
fail. Remove one a time this way because this may improve the percentage for other combiners.

=end comment


sub MAIN() {

    # Cheat
    my @skips = "resources/skiplist-codes".IO.lines.map(*.chr.ord);

    my $test-latin = ('a'..'z').pick(1);

    my %combining-class-values =
        'above', %(
            'kana-voicing', 8,
            'attached-above-left', 212,
            'attached-above', 214,
            'attached-above-right', 216,
            'above-left', 228,
            'above', 230,
            'above-right', 232,
            'double-above', 234,
        ),
        'below', %(
            'attached-below-left', 200,
            'attached-below', 202,
            'attached-below-right', 204,
            'below-left', 218,
            'below', 220,
            'below-right', 222,
            'double-below', 233,
            'iota-subscript', 240,
        ),
        'unused', %(
            'overlay', 1,          # renders fine by itself but obscures the original letter
            'han-reading', 6,      # no characters
            'nukta', 7,            # mixed above/below
            'virama', 9,           # mixed above/below
            'attached-left', 208,  # no characters
            'left', 224,           # ugly
            'attached-right', 210, # no characters
            'right', 226,          # no characters
        ),
    ;

    my $attr = 'Canonical_Combining_Class';
    my @all = (0x0000..0xFFFF).grep(*.uniprop($attr) != "0");
    my %types;

    for %combining-class-values.keys -> $group {
        next if $group eq "unused";
        for %combining-class-values{$group}.kv -> $name, $value {
            %types{$group} = Array.new unless %types{$group};
            @(%types{$group}).append: @all.grep(*.uniprop($attr) == $value).map(*.chr);
        }
    }


    # solo combiners from all types
    for %types.keys.sort(*.fc) -> $name {
        next unless %types{$name}.elems;
        my $count = 0;
        say "\n*** SOLO: $name";
        for @(%types{$name}).sort -> $combiner {
            next if @skips.grep($combiner.ord);
            say '' if $count >0 && $count %% 10;
            print display-ord($combiner);
            print ' ';
            print $test-latin ~ $combiner;
            print ' ';
            $count++;
        }
        say '';
    }

    # BELOW/ABOVE
    for @(%types<below>).sort -> $below {
        next if @skips.grep($below.ord);
        my $count = 0;;
        say "\n*** COMBO: below {display-ord($below)}";
        for @(%types<above>).sort -> $above {
            next if @skips.grep($above.ord);
            say '' if $count >0 && $count %% 10;
            print display-ord($above);
            print ' ';
            print $test-latin ~ $above ~ $below;
            print ' ';
            $count++;
        }
        say '';
    }

    # ABOVE/BELOW
    for @(%types<above>).sort -> $above {
        next if @skips.grep($above.ord);
        my $count = 0;
        say "\n*** COMBO: above {display-ord($above)}";
        for @(%types<below>).sort -> $below {
            next if @skips.grep($below.ord);
            say '' if $count >0 && $count %% 10;
            print display-ord($below);
            print ' ';
            print $test-latin ~ $above ~ $below;
            print ' ';
            $count++;
        }
        say '';
    }
}

sub display-ord($combiner) {
    my $ord = $combiner.ord.base(16);
    '0x' ~ ($ord.chars == 3 ?? '0' !! '') ~ $ord;
}
