#!/usr/bin/env perl6

use MONKEY-SEE-NO-EVAL;

my %hacks = (
    circle => "CIRCLED",
    super  => "SUPERSCRIPT" 

);

sub MAIN(Str $input, :$hack = 'circle') {

    if !(%hacks{$hack}:exists) {
        die "invalid hack, must be one of: " ~ %hacks.keys;
    }

    my $result = "";
    
    for $input.comb -> $char {
        my $mod = %hacks{$hack};
        my $new-char = try EVAL '"\c[' ~ $mod ~ ' ' ~ $char.uniname ~ ']"';
        $new-char //= $char;
        $result ~= $new-char;
    }

    say $result;
}
