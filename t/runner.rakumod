unit module runner;

use Test;

sub mangled-run($kind, $in) is export {
    run($*EXECUTABLE-NAME, '-I.', 'bin/uni-mangler', "--$kind", $in, :out).out.slurp-rest.chomp;
}

sub mangled($kind, $in, $out, $desc) is export {
    is mangled-run($kind, $in), $out, $desc;
}
