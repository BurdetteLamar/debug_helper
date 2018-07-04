# Debug Helper

If (like me), your debugging style is [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques), you will have shoved this into your code many times:

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

## Class Method or Module Method?

Most examples in this documentation show use of the class method:

```ruby
require 'debug_helper'
DebugHelper.show(obj, message)
```

You can also choose to use the module method, ```putd``` (Thanks, [palkan](https://www.reddit.com/user/palkan)!), which looks a lot like ```puts```.

```ruby
require 'debug_helper'
include DebugHelper::Putd
putd obj, message
```

Just be sure to ```include DebugHelper::Putd```.

@[:markdown](class_inclusions.md)
