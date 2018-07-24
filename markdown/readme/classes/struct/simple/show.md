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
  size: 3
  Member 0:
    Name:
      Symbol:
        to_s: a
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol:
        to_s: b
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol:
        to_s: c
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 2
```
