#!/usr/bin/env perl6

use lib 't';
use runner;

use Test;
plan 6;

# original

mangled 'invert', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Z⅄XMᴧ∩⊥SᴚΌԀOᴎW⅂⋊ſIH⅁ℲƎ◖Ↄ𐐒∀', 'UPPERCASE';
mangled 'invert', 'abcdefghijklmnopqrstuvwxyz', 'zʎxʍʌnʇsɹbdouɯʃʞɾıɥƃɟǝpɔqɐ', 'lowercase';

# reversed

mangled 'invert', 'Z⅄XMᴧ∩⊥SᴚΌԀOᴎW⅂⋊ſIH⅁ℲƎ◖Ↄ𐐒∀', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'UPPERCASE roundtrip';
mangled 'invert', 'zʎxʍʌnʇsɹbdouɯʃʞɾıɥƃɟǝpɔqɐ', 'abcdefghijklmnopqrstuvwxyz', 'lowercase roundtrip';


# non-alpha
mangled 'invert', '!"&\'(.3467;<?[_{‿⁅∴',  '∵⁆⁀}‾]¿>؛Ɫ9ᔭƐ˙),⅋„¡', 'non alpha';
mangled 'invert', '∵⁆⁀}‾]¿>؛Ɫ9ᔭƐ˙),⅋„¡', '!"&\'(.3467;<?[_{‿⁅∴',  'non alpha roundtrip';
