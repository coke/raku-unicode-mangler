unit module runner;

use Test;

sub mangled($in, $out, $desc) is export {
    is run($*EXECUTABLE-NAME, 'mangle.p6', $in, :out).out.slurp-rest.chomp, $out, $desc;
}
