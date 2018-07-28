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
Hash (message='My nested hash'):
  size: 2
  default: 
  default_proc: 
  Pair 0:
    Key:
      Symbol:
        to_s: a
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        size: 2
        default: 
        default_proc: 
        Pair 0:
          Key:
            Symbol:
              to_s: b
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Pair 1:
          Key:
            Symbol:
              to_s: c
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Pair 1:
    Key:
      Symbol:
        to_s: d
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        size: 2
        default: 
        default_proc: 
        Pair 0:
          Key:
            Symbol:
              to_s: e
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Pair 1:
          Key:
            Symbol:
              to_s: f
              size: 1
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
```
