#!/usr/bin/env perl6

my %hacks;

sub MAIN(Str $input, :$hack = 'circle') {

    if !(%hacks{$hack}:exists) {
        die "invalid hack, must be one of: " ~ %hacks.keys;
    }

    my $result = "";
    
    for $input.comb -> $char {
        my $mod = %hacks{$hack};
        my $new-char;
        if $mod ~~ Callable {
            $new-char = $mod($char);
        }
        $new-char //= $char;
        $result ~= $new-char;
    }

    say $result;
}

BEGIN %hacks = (
    'circle' => -> $char {
        use MONKEY-SEE-NO-EVAL;
        try EVAL '"\c[CIRCLED ' ~ $char.uniname ~ ']"';
    }
)
