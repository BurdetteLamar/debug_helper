#### Nested Arrays

This example shows nested arrays.

```show.rb```:
```ruby
require 'debug_helper'

ary = [0, [1, 2], [3, 4]]
DebugHelper.show(ary, 'My nested arrays')
```

The output shows details of the arrays.

```show.yaml```:
```yaml
---
Array (size=3 name=My nested arrays):
  Element 0: 0 (Fixnum)
  Element 1:
    Array (size=2 name=1):
      Element 0: 1 (Fixnum)
      Element 1: 2 (Fixnum)
  Element 2:
    Array (size=2 name=2):
      Element 0: 3 (Fixnum)
      Element 1: 4 (Fixnum)
```
