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
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      String (size=3):
        to_s: one
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol (size=3):
        to_s: two
        encoding: !ruby/encoding US-ASCII
```
