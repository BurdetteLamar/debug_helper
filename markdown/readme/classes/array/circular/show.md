#### Circular Arrays

This example shows arrays that make a circular reference.

```show.rb```:
```ruby
require 'debug_helper'

ary_0 = []
ary_1 = []
ary_0.push(ary_1)
ary_1.push(ary_0)
DebugHelper.show(ary_0, 'My circular arrays')
```

The output shows details of the arrays.

The circular reference is not followed.

```show.yaml```:
```yaml
---
Array (size=1 message='My circular arrays'):
  Element 0:
    Array (size=1):
      Element 0: Array [[[...]]]
```
