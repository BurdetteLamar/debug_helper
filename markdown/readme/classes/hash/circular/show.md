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
Hash (size=1 name='My circular hashes'):
  Pair 0:
    Key:
      Symbol (size=3 encoding=US-ASCII): :foo
    Value:
      Hash (size=1):
        Pair 0:
          Key:
            Symbol (size=3 encoding=US-ASCII): :bar
          Value: Hash {:foo=>{:bar=>{...}}}
```
