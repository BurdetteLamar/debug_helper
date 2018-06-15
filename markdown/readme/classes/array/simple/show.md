#### Simple Array

This example shows a simple array of integers.

```show.rb```:
```ruby
require 'debug_helper'

ary = [5, 10, 15]
DebugHelper.show(ary, 'My simple array')
```

The Ruby code passes an array and a name to the helper.

```show.yaml```:
```yaml
Array (size=3 name=My simple array):
  Element 0: 5 (Fixnum)
  Element 1: 10 (Fixnum)
  Element 2: 15 (Fixnum)
```
