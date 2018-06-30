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
Hash (size=2 name='My nested hash'):
  Pair 0:
    Key:
      Symbol (size=1 encoding=US-ASCII): :a
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1 encoding=US-ASCII): :b
          Value: Fixnum 0
        Pair 1:
          Key:
            Symbol (size=1 encoding=US-ASCII): :c
          Value: Fixnum 1
  Pair 1:
    Key:
      Symbol (size=1 encoding=US-ASCII): :d
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1 encoding=US-ASCII): :e
          Value: Fixnum 2
        Pair 1:
          Key:
            Symbol (size=1 encoding=US-ASCII): :f
          Value: Fixnum 3
```
