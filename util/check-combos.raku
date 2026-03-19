# Test various combos
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

    for %types.keys.sort(*.fc) -> $name {
        next unless %types{$name}.elems;
        my $count = 0;
        say "\n*** $name";
        for @(%types{$name}).sort -> $combiner {
            next if @skips.grep($combiner.ord);
            say '' if $count >0 && $count %% 10;
            my $ord = $combiner.ord.base(16);
            print '0x' ~ ($ord.chars == 3 ?? '0' !! '') ~ $ord;
            print ' ';
            print $test-latin ~ $combiner;
            print ' ';
            $count++;
        }
        say '';
    }
}
