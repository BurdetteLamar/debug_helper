#### Nested Structs

This example shows nested structs.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct_0 = MyStruct.new(0, 1, 2)
struct_1 = MyStruct.new(3, 4, 5)
struct_0.a = struct_1
DebugHelper.show(struct_0, 'My nested struct')
```

The output shows details of the structs.

```show.yaml```:
```yaml
---
MyStruct (size=3 name=My nested struct):
  Member 0:
    Name: :a
    Value:
      MyStruct (size=3):
        Member 0:
          Name: :a
          Value: Fixnum 3
        Member 1:
          Name: :b
          Value: Fixnum 4
        Member 2:
          Name: :c
          Value: Fixnum 5
  Member 1:
    Name: :b
    Value: Fixnum 1
  Member 2:
    Name: :c
    Value: Fixnum 2
```
