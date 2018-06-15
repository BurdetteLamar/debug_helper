#### Simple Array

This example shows a simple array of integers.

This Ruby code passes a simple array and a name to the helper.

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
Array (size=3 name=My simple array):
  Element 0: 5 (Fixnum)
  Element 1: 10 (Fixnum)
  Element 2: 15 (Fixnum)
```
