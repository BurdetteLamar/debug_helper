# Debug Helper

If (like me), your debugging style is [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques) (like me), you will have shoved this into your code many times:

@[ruby](show_hash.rb)

And this:

@[ruby](show_array.rb)

This helper assists in debugging by printing an analysis of a given object.  The analysis is a ```yaml``` structure, and is written to ```stdout```.

For certain classes (see below), the analysis is very detailed.

For the collection classes ```Array```, ```Hash```, and ```Struct```, the analysis is also recursive;  that is, the collection's values are themselves analyzed.

Classes treated in detail:

@[:markdown](class_links.md)

Others are treated as:

- [Object](#object)

@[:markdown](class_inclusions.md)
