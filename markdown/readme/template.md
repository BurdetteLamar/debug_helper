# Debug Helper

If (like me), your debugging style is [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques) (like me), you will have shoved this into your code many times:

@[ruby](show_hash.rb)

And this:

@[ruby](show_array.rb)

This helper assists in debugging by printing (to ```stdout```) an analysis (as ```yaml```) of a given object.

For the collection classes ```Array```, ```Hash```, and ```Struct```, the analysis is recursive;  that is, the collection's values are themselves analyzed.

Classes fully treated:

@[:markdown](class_links.md)

Others are treated as:

- [Object](#object)

@[:markdown](class_inclusions.md)
