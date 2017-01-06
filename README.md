# Overview

Silly script to let you take unicode input and transform it, e.g.

    $ perl6 mangle.p6 'Perl 6' #defaults to circle
    Ⓟⓔⓡⓛ ⑥

    $ perl6 mangle.p6 --hack=invert 'Hello, github!'
    ¡quɥʇıƃ ,oʃʃǝH

    $ perl6 mangle.p6 --hack=bold 'A bird, a plane.'
    𝐀 𝐛𝐢𝐫𝐝, 𝐚 𝐩𝐥𝐚𝐧𝐞.
   
    $ perl6 mangle.p6 --hack=paren 'lisplike'
    ⒧⒤⒮⒫⒧⒤⒦⒠
