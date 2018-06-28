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
Array (name='My simple array' size=3):
  Element 0: Fixnum 5
  Element 1: Fixnum 10
  Element 2: Fixnum 15
```
