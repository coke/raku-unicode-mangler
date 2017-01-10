#!/usr/bin/env perl6

use lib 't';
use runner;

use Test;
plan 2;

mangled 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ', 'UPPERCASE';
mangled 'abcdefghijklmnopqrstuvwxyz', 'ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ', 'lowercase';
