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
Array (size=3 name='My nested arrays'):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1: Fixnum 2
  Element 2:
    Array (size=2):
      Element 0: Fixnum 3
      Element 1: Fixnum 4
```
