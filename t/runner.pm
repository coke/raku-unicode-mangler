unit module runner;

use Test;

sub mangled($kind, $in, $out, $desc) is export {
    is run($*EXECUTABLE-NAME, 'bin/uni-mangler', "--$kind", $in, :out).out.slurp-rest.chomp, $out, $desc;
}
