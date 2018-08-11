#### Circular Hashes

This example shows hashes that make a circular reference.

```show.rb```:
```ruby
require 'debug_helper'

hash_0 = {}
hash_1 = {}
hash_0.store(:foo, hash_1)
hash_1.store(:bar, hash_0)
DebugHelper.show(hash_0, 'My circular hashes')
```

The output shows details of the hashes.

The circular reference is not followed.

```show.yaml```:
```yaml
---
Hash (message='My circular hashes'):
  Hash#size: 1
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: foo
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        Hash#size: 1
        Hash#default: 
        Hash#default_proc: 
        Pair 0:
          Key:
            Symbol:
              Symbol#to_s: bar
              Symbol#size: 3
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Hash {:foo=>{:bar=>{...}}}
```
