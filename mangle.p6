#!/usr/bin/env perl6

my (%hacks, %posts);

sub MAIN(Str $input, :$hack = 'circle') {

    if !(%hacks{$hack}:exists) {
        die "invalid hack, must be one of: " ~ %hacks.keys;
    }

    my $result = "";
    
    for $input.comb -> $char {
        my $mod = %hacks{$hack};
        my $new-char;
        given $mod {
            when Callable {
                $new-char = $mod($char);
            }
            when Associative {
                $new-char = $mod{$char};
            }
        }
        $new-char //= $char;
        $result ~= $new-char;
    }

    if %posts{$hack}:exists {
        $result = %posts{$hack}($result);
    };
    say $result;
}

BEGIN %hacks = (
    'circle' => -> $char {
        use MONKEY-SEE-NO-EVAL;
        try EVAL '"\c[CIRCLED ' ~ $char.uniname ~ ']"';
    }
    # Original table courtesy
    # http://www.fileformat.info/convert/text/upside-down-map.htm
    'invert' => %(
        "!", "¡",
        '"', "„",
        "&", "⅋",
        "'", ",",
        "(", ")",
        ".", "˙",
        "3", "Ɛ",
        "4", "ᔭ",
        "6", "9",
        "7", "Ɫ",
        ";", "؛",
        "<", ">",
        "?", "¿",
        "A", "∀",
        "B", "𐐒",
        "C", "Ↄ",
        "D", "◖",
        "E", "Ǝ",
        "F", "Ⅎ",
        "G", "⅁",
        "J", "ſ",
        "K", "⋊",
        "L", "⅂",
        "M", "W",
        "N", "ᴎ",
        "P", "Ԁ",
        "Q", "Ό",
        "R", "ᴚ",
        "T", "⊥",
        "U", "∩",
        "V", "ᴧ",
        "Y", "⅄",
        "[", "]",
        "_", "‾",
        "a", "ɐ",
        "b", "q",
        "c", "ɔ",
        "d", "p",
        "e", "ǝ",
        "f", "ɟ",
        "g", "ƃ",
        "h", "ɥ",
        "i", "ı",
        "j", "ɾ",
        "k", "ʞ",
        "l", "ʃ",
        "m", "ɯ",
        "n", "u",
        "p", "d",
        "r", "ɹ",
        "t", "ʇ",
        "v", "ʌ",
        "w", "ʍ",
        "y", "ʎ",
        '{', '}',
        "‿", "⁀",
        "⁅", "⁆",
        "∴", "∵",
    )
);

BEGIN %posts = (
    'invert' => &flip
);
