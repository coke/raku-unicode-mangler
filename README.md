# Overview

Silly script to let you take unicode input and transform it.
Some samples:

    $ uni-mangler --circle '#rakulang'
    #ⓡⓐⓚⓤⓛⓐⓝⓖ

    $ uni-mangler --invert 'Hello, github!'
    ¡quɥʇıƃ ,oʃʃǝH

    $ uni-mangler --bold 'A bird, a plane.'
    𝐀 𝐛𝐢𝐫𝐝, 𝐚 𝐩𝐥𝐚𝐧𝐞.
   
    $ uni-mangler --paren 'lisplike'
    ⒧⒤⒮⒫⒧⒤⒦⒠

    $ uni-mangler --combo 'combo breaker'
    c̩͘o̍ͧmͮ͠b̄͋o̸̫ ̣͚b͠ͅř̗ẻ͔aͪ͢k̥̀e̒͋r͎̦

    $ uni-mangler --italic 'The Telltale Heart'
    𝘛𝘩𝘦 𝘛𝘦𝘭𝘭𝘵𝘢𝘭𝘦 𝘏𝘦𝘢𝘳𝘵

    $ uni-mangler --square 'Presenting'
    🄿 🅁 🄴 🅂 🄴 🄽 🅃 🄸 🄽 🄶

    $ uni-mangler --nsquare 'A little boxy'
    🅰   🅻 🅸 🆃 🆃 🅻 🅴   🅱 🅾 ❎ 🆈

    $ uni-mangler --random 'Happy Birthday!'
    Ⓗ⒜ⓟ𝐩𝐲 𐐒⒤𝐫⒯⒣pɐ⒴¡

## Combining Characters

Where possible, preserve input combining marks:

    $ uni-mangler --outline rákü
    𝕣𝕒́𝕜𝕦̈

## Related Modules

For a more focused approach on the Mathematical Alphanumeric Symbols unicode block, try:
[Text::MathematicalCase](https://raku.land/zef:lizmat/Text::MathematicalCase)
