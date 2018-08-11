#### Nested Structs

This example shows nested structs.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct_0 = Struct.new(:a, :b)
MyStruct_1 = Struct.new(:c, :d)
struct_1a = MyStruct_1.new(2, 3)
struct_1b = MyStruct_1.new(4, 5)
struct_0 = MyStruct_0.new(struct_1a, struct_1b)
DebugHelper.show(struct_0, 'My nested struct')
```

The output shows details of the structs.

```show.yaml```:
```yaml
---
MyStruct_0 (message='My nested struct'):
  MyStruct_0#size: 2
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1:
        MyStruct_1#size: 2
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: d
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1:
        MyStruct_1#size: 2
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Fixnum 4
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: d
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Fixnum 5
```
