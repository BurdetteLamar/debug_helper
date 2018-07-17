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
Array (size=3 message='My simple array'):
  Element 0: Fixnum 5
  Element 1: Fixnum 10
  Element 2: Fixnum 15
```
