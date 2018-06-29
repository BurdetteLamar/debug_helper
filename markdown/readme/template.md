# Debug Helper

This helper assists in [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques), by printing (to ```stdout```) an analysis (as ```yaml```) of a given object.

For the collection classes ```Array```, ```Hash```, and ```Struct```, the analysis is recursive;  that is, the collection's values are themselves analyzed.

Classes fully treated:

@[:markdown](class_links.md)

Others are treated as:

- [Object](#object)

@[:markdown](class_inclusions.md)
