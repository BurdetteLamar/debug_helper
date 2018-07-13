#### Mixed Array

This example shows an array of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

ary = [0, 'one', :two]
DebugHelper.show(ary, 'My mixed array')
```

The output shows details of the array.

```show.yaml```:
```yaml
---
Array (message='My mixed array' size=3):
  Element 0: Fixnum 0
  Element 1:
    String (size=3):
      to_s: one
      encoding: !ruby/encoding UTF-8
      ascii_only?: true
      bytesize: 3
  Element 2:
    Symbol (size=3):
      to_s: two
      encoding: !ruby/encoding US-ASCII
```
