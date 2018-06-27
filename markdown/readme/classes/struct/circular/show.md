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
MyStruct (size=3 name=My circular struct):
  Member 0:
    Name: :a
    Value:
      MyStruct (size=3):
        Member 0:
          Name: :a
          Value: "#<struct MyStruct a=#<struct MyStruct a=#<struct MyStruct:...>,
            b=4, c=5>, b=1, c=2> (MyStruct)"
        Member 1:
          Name: :b
          Value: 4 (Fixnum)
        Member 2:
          Name: :c
          Value: 5 (Fixnum)
  Member 1:
    Name: :b
    Value: 1 (Fixnum)
  Member 2:
    Name: :c
    Value: 2 (Fixnum)
```
