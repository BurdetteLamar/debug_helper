#### Mixed OpenStruct

This example shows an open struct of mixed values.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(:a => 0, :b => 'one', :c => :two)
DebugHelper.show(ostruct, 'My mixed open struct')
```

The output shows details of the open struct.

```show.yaml```:
```yaml
---
OpenStruct (message='My mixed open struct'):
  size: 
  Member 0:
    Name:
      Symbol:
        to_s: a
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol:
        to_s: b
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      String:
        to_s: one
        size: 3
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Member 2:
    Name:
      Symbol:
        to_s: c
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        to_s: two
        size: 3
        encoding: !ruby/encoding US-ASCII
```
