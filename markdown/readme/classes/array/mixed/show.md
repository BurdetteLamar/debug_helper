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
  size: 3
  Element 0: Fixnum 0
  Element 1:
    String:
      to_s: one
      size: 3
      encoding: !ruby/encoding UTF-8
      ascii_only?: true
      bytesize: 3
  Element 2:
    Symbol:
      to_s: two
      size: 3
      encoding: !ruby/encoding US-ASCII
```
