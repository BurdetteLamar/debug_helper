#### Simple Hash

This example shows a simple hash.

```show.rb```:
```ruby
require 'debug_helper'

hash = {:a => 0, :b => 1, :c => 2}
DebugHelper.show(hash, 'My simple hash')
```

The output shows details of the hash.

```show.yaml```:
```yaml
---
Hash (message='My simple hash'):
  Hash#size: 3
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Pair 1:
    Key:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Pair 2:
    Key:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
```
