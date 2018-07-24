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
Hash (size=3 message='My simple hash'):
  size: 3
  Pair 0:
    Key:
      Symbol:
        to_s: a
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol:
        to_s: b
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Pair 2:
    Key:
      Symbol:
        to_s: c
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 2
```
