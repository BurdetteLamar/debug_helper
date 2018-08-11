#### Simple OpenStruct

This example shows a simple open struct.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(:a => 0, :b => 1, :c => 2)
DebugHelper.show(ostruct, 'My simple struct')
```

The output shows details of the open struct.

```show.yaml```:
```yaml
---
OpenStruct (message='My simple struct'):
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Fixnum 2
```
