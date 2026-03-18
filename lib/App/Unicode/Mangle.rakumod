unit class App::Unicode::Mangle:ver<1.0.4>;

my (%hacks, %posts);

sub mangle(Str $input, :$hack = 'circle') is export {
    die "invalid option, must be one of: " ~ %hacks.keys.sort
        unless %hacks{$hack}:exists;

    my $result = $input.comb.map({
        one-char($hack, $_);
    }).join;

    if %posts{$hack}:exists {
        $result = %posts{$hack}($result);
    };
    $result;
}

sub one-char($hack, $char) {
    my $mod = %hacks{$hack};
    my $new-char;

    my $try-char = $char.samemark('a');
    given $mod {
        when Callable {
            $new-char = $mod($try-char);
        }
        when Associative {
            $new-char = $mod{$try-char};
        }
    }

    # Missed? try with original marks.
    if !$new-char.DEFINITE {
        given $mod {
            when Callable {
                $new-char = $mod($char);
            }
            when Associative {
                $new-char = $mod{$char};
            }
        }
    }

    # Didn't work? pass through original char
    $new-char //= $char;

    # Now add in the marks from the original character.
    # But, cheat; don't do this for the one character
    # we know that starts out with a mark but transforms
    # into something without
    if $char ne "Ό" {
        my @combinors = $char.NFD.list;
        @combinors.shift;
        for @combinors -> $mark {
            $new-char ~= chr($mark);
        }
    }

    $new-char;
}

BEGIN our $num-combiners = 2;

sub try-some(Str $char, Int $count) {
    state @combinors = (0x0300..0x036F,0x1DC0..0x1DFF).flat.grep({
        uniprop($_, 'Canonical_Combining_Class') ne "0"
    }).map({.chr});
    $char ~ @combinors.pick($count).join;
}


BEGIN %hacks = (
    'random' => -> $char {
        one-char(%hacks.keys.grep({$_ ne "random"}).pick(1), $char);
    },
    'circle' => -> $char {
        try ('CIRCLED ' ~ $char.uniname).uniparse;
    },
    'paren' => -> $char {
        try ('PARENTHESIZED ' ~ $char.uniname).uniparse;
    },
    'bold' => -> $char {
        my $name = $char.uniname;
        $name ~~ s/ 'LATIN ' //;
        $name ~~ s/ 'LETTER ' //;
        $name = "MATHEMATICAL BOLD $name";
        try $name.uniparse;
    },
    'outline' => -> $char {
        my $name = $char.uniname;
        $name ~~ s/ 'LATIN ' //;
        $name ~~ s/ 'LETTER ' //;
        $name = "DOUBLE-STRUCK $name";
        my $try = try $name.uniparse;
        $try //= try ('MATHEMATICAL ' ~ $name).uniparse;
    },
    'combo' => -> $char {
        my $suggest = try-some($char, $num-combiners);
        while $suggest.uninames.grep({.contains('<reserved'|'REPLACEMENT')}) {
            $suggest = try-some($char, $num-combiners);
        }
        $suggest;
    },
    'square' => -> $char {
        my $name = $char.uniname;
        $name = 'SQUARED ' ~ $name;
        $name ~~ s/SMALL/CAPITAL/;
        try $name.uniparse;
    },
    'nsquare' => -> $char {
        my $name = $char.uniname;
        $name = 'NEGATIVE SQUARED ' ~ $name;
        $name ~~ s/SMALL/CAPITAL/;
        if $name eq 'NEGATIVE SQUARED LATIN CAPITAL LETTER X' {
            $name = 'NEGATIVE SQUARED CROSS MARK';
        }
        try $name.uniparse;
    },
    'italic' => -> $char {
        my $name = $char.uniname;
        $name = 'MATHEMATICAL SANS-SERIF ITALIC ' ~ $name;
        $name ~~ s/ 'LATIN ' //;
        $name ~~ s/ 'LETTER ' //;
        try $name.uniparse;
    },
    # Original table courtesy
    # http://www.fileformat.info/convert/text/upside-down-map.htm

    'invert' => -> $char {
        my %mappings = %(
            "!", "¡", '"', "„", "&", "⅋", "'", ",", "(", ")",
            ".", "˙", "3", "Ɛ", "4", "ᔭ", "6", "9", "7", "Ɫ",
            ";", "؛", "<", ">", "?", "¿", "A", "∀", "B", "𐐒",
            "C", "Ↄ", "D", "◖", "E", "Ǝ", "F", "Ⅎ", "G", "⅁",
            "J", "ſ", "K", "⋊", "L", "⅂", "M", "W", "N", "ᴎ",
            "P", "Ԁ", "Q", "Ό", "R", "ᴚ", "T", "⊥", "U", "∩",
            "V", "ᴧ", "Y", "⅄", "[", "]", "_", "‾", "a", "ɐ",
            "b", "q", "c", "ɔ", "e", "ǝ", "f", "ɟ", "g", "ƃ",
            "h", "ɥ", "i", "ı", "j", "ɾ", "k", "ʞ", "l", "ʃ",
            "m", "ɯ", "n", "u", "p", "d", "r", "ɹ", "t", "ʇ",
            "v", "ʌ", "w", "ʍ", "y", "ʎ", '{', '}', "‿", "⁀",
            "⁅", "⁆", "∴", "∵"
        );
        %mappings{$char} // %mappings.antipairs.Hash{$char};
    }
);

sub spacer($arg) { $arg.comb.join(' ') }

BEGIN %posts = (
    'invert'  => &flip,
    'square'  => &spacer,
    'nsquare' => &spacer,
    'random'  => &spacer
);
