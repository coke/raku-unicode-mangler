# Overview

Silly script to let you take unicode input and transform it, e.g.

    $ uni-mangler 'Perl 6' #defaults to circle
    Ⓟⓔⓡⓛ ⑥

    $ uni-mangler --hack=invert 'Hello, github!'
    ¡quɥʇıƃ ,oʃʃǝH

    $ uni-mangler --hack=bold 'A bird, a plane.'
    𝐀 𝐛𝐢𝐫𝐝, 𝐚 𝐩𝐥𝐚𝐧𝐞.
   
    $ uni-mangler --hack=paren 'lisplike'
    ⒧⒤⒮⒫⒧⒤⒦⒠

    $ uni-mangler --hack=combo 'combo breaker'
    c̩͘o̍ͧmͮ͠b̄͋o̸̫ ̣͚b͠ͅř̗ẻ͔aͪ͢k̥̀e̒͋r͎̦

    $ uni-mangler --hack=outline 'Butterflies'
    𝔹𝕦𝕥𝕥𝕖𝕣𝕗𝕝𝕚𝕖𝕤

    $ uni-mangler --hack=random 'Happy Birthday!'
    Ⓗ⒜ⓟ𝐩𝐲 𐐒⒤𝐫⒯⒣pɐ⒴¡

## Combining Characters

Where possible, preserve input combining marks:

    $ uni-mangler --hack=outline 'përl'
    𝕡𝕖̈𝕣𝕝
