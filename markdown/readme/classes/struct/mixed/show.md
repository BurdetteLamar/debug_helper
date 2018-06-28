#### Mixed Struct

This example shows a struct of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct = MyStruct.new(0, 'one', :two)
DebugHelper.show(struct, 'My mixed struct')
```

The output shows details of the struct.

```show.yaml```:
```yaml
---
MyStruct (size=3 name='My mixed struct'):
  Member 0:
    Name: :a
    Value: Fixnum 0
  Member 1:
    Name: :b
    Value:
      String (size=3 encoding=UTF-8 ascii_only=true bytesize=3):
      - one
  Member 2:
    Name: :c
    Value:
      Symbol (size=3): :two
```
