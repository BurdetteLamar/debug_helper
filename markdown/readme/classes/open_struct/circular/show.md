#### Circular OpenStructs

This example shows open structs that make a circular reference.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct_0 = OpenStruct.new
ostruct_1 = OpenStruct.new
ostruct_0.a = ostruct_1
ostruct_1.a = ostruct_0
DebugHelper.show(ostruct_0, 'My circular ostruct')
```

The output shows details of the open structs.

The circular reference is not followed.

```show.yaml```:
```yaml
---
OpenStruct (message='My circular ostruct'):
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: a
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: 'OpenStruct #<OpenStruct a=#<OpenStruct a=#<OpenStruct ...>>>'
```
