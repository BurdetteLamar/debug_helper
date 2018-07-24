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
  size: 
  Member 0:
    Name:
      Symbol:
        to_s: a
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        size: 
        Member 0:
          Name:
            Symbol:
              to_s: b
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Member 1:
          Name:
            Symbol:
              to_s: c
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Member 1:
    Name:
      Symbol:
        to_s: d
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        size: 
        Member 0:
          Name:
            Symbol:
              to_s: e
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Member 1:
          Name:
            Symbol:
              to_s: f
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
```
