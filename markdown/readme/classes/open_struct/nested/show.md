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
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: b
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 0
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 1
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: d
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: e
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 2
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: f
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 3
```
