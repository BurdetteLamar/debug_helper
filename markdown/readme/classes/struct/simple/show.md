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
MyStruct (size=3 message='My simple struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 2
```
