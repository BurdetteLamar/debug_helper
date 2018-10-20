#### Circular Structs

This example shows structs that make a circular reference.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct_0 = MyStruct.new(0, 1, 2)
struct_1 = MyStruct.new(3, 4, 5)
struct_0.a = struct_1
struct_1.a = struct_0
DebugHelper.show(struct_0, 'My circular struct')
```

The output shows details of the structs.

The circular reference is not followed.

```show.yaml```:
```yaml
---
MyStruct (message='My circular struct'):
  MyStruct#size: 3
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct:
        MyStruct#size: 3
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: a
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: 'MyStruct #<struct MyStruct a=#<struct MyStruct a=#<struct MyStruct:...>,
            b=4, c=5>, b=1, c=2>'
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: b
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 4
        Member 2:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 5
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
```
