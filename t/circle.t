#!/usr/bin/env perl6

use Test;
plan 2;

is run($*EXECUTABLE-NAME, 'mangle.p6', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', :out).out,
    'ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ', 'UPPERCASE';
is run($*EXECUTABLE-NAME, 'mangle.p6', 'abcdefghijklmnopqrstuvwxyz', :out).out,
    'ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ', 'lowercase';
