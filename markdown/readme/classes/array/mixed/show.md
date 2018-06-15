#### Simple Array

This example shows an array of mixed values.

This Ruby code passes a simple array and a name to the helper.

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
Array (size=3 name=My mixed array):
  Element 0: 0 (Fixnum)
  Element 1:
    String (size=3 encoding=UTF-8 name=1):
    - one
  Element 2:
    Symbol (size=3): :two
```
