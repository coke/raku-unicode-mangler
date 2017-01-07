#!/usr/bin/env perl6

use Test;
plan 2;

is run($*EXECUTABLE-NAME, 'mangle.p6', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', :out).out.slurp-rest.chomp,
    'ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ', 'UPPERCASE';
is run($*EXECUTABLE-NAME, 'mangle.p6', 'abcdefghijklmnopqrstuvwxyz', :out).out.slurp-rest.chomp,
    'ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ', 'lowercase';
