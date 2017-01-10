#!/usr/bin/env perl6

use lib 't';
use runner;

use Test;
plan 2;

mangled 'invert', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Z⅄XWᴧ∩⊥SᴚΟԀOᴎW⅂⋊ſIH⅁ℲƎ◖Ↄ𐐒∀', 'UPPERCASE';
mangled 'invert', 'abcdefghijklmnopqrstuvwxyz', 'zʎxʍʌuʇsɹqdouɯʃʞɾıɥƃɟǝpɔqɐ', 'lowercase';
