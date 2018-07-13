#### Nested Hashes

This example shows nested hashes.

```show.rb```:
```ruby
require 'debug_helper'

hash = {
    :a => {
        :b => 0,
        :c => 1,
    },
    :d => {
        :e => 2,
        :f => 3,
    }
}
DebugHelper.show(hash, 'My nested hash')
```

The output shows details of the hashes.

```show.yaml```:
```yaml
---
Hash (size=2 message='My nested hash'):
  Pair 0:
    Key:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1):
              to_s: b
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Pair 1:
          Key:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Pair 1:
    Key:
      Symbol (size=1):
        to_s: d
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1):
              to_s: e
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Pair 1:
          Key:
            Symbol (size=1):
              to_s: f
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
```
