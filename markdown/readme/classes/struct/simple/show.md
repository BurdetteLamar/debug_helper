#### Simple Struct

This example shows a simple struct.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct = MyStruct.new(0, 1, 2)
DebugHelper.show(struct, 'My simple struct')
```

The output shows details of the struct.

```show.yaml```:
```yaml
---
MyStruct (size=3 name=My simple struct):
  Member 0:
    Name: :a
    Value: 0 (Fixnum)
  Member 1:
    Name: :b
    Value: 1 (Fixnum)
  Member 2:
    Name: :c
    Value: 2 (Fixnum)
```
