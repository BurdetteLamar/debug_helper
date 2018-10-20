#### Simple Array

This example shows a simple array of integers.

```show.rb```:
```ruby
require 'debug_helper'

ary = [5, 10, 15]
DebugHelper.show(ary, 'My simple array')
```

The output shows details of the array.

```show.yaml```:
```yaml
---
Array (message='My simple array'):
  Array#size: 3
  Element 0: Integer 5
  Element 1: Integer 10
  Element 2: Integer 15
```
