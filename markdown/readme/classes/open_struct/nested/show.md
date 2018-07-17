#### Nested OpenStructs

This example shows nested open structs.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(
                        :a => OpenStruct.new(
                                            :b => 0,
                                            :c => 1,
                        ),
                        :d => OpenStruct.new(
                                            :e => 2,
                                            :f => 3,
                        )
)
DebugHelper.show(ostruct, 'My nested struct')
```

The output shows details of the open structs.

```show.yaml```:
```yaml
---
OpenStruct (message='My nested struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol (size=1):
              to_s: b
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Member 1:
          Name:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Member 1:
    Name:
      Symbol (size=1):
        to_s: d
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol (size=1):
              to_s: e
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Member 1:
          Name:
            Symbol (size=1):
              to_s: f
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
```
