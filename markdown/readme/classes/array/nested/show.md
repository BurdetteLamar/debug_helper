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
Array (message='My nested arrays'):
  Array#size: 3
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1: Integer 2
  Element 2:
    Array:
      Array#size: 2
      Element 0: Integer 3
      Element 1: Integer 4
```
