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
Array (message='My mixed array'):
  Array#size: 3
  Element 0: Integer 0
  Element 1:
    String:
      String#to_s: one
      String#size: 3
      String#encoding: !ruby/encoding UTF-8
      String#ascii_only?: true
      String#bytesize: 3
  Element 2:
    Symbol:
      Symbol#to_s: two
      Symbol#size: 3
      Symbol#encoding: !ruby/encoding US-ASCII
```
