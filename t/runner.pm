unit module runner;

use Test;

sub mangled($kind, $in, $out, $desc) is export {
    is run($*EXECUTABLE-NAME, 'mangle.p6', "--hack=$kind", $in, :out).out.slurp-rest.chomp, $out, $desc;
}
