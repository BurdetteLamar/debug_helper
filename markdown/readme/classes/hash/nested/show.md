#### Nested Hashes

This example shows nested hashes.

```show.rb```:
```ruby
require 'debug_helper'

hash = {
    :a => {
        :b => 0,
        :c => 1,
    }
}
DebugHelper.show(hash, 'My nested hash')
```

The output shows details of the hashes.

```show.yaml```:
```yaml
---
Hash (size=1 name=My nested hash):
  Pair 0:
    Key:
      Symbol (size=1): :a
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1): :b
          Value: 0 (Fixnum)
        Pair 1:
          Key:
            Symbol (size=1): :c
          Value: 1 (Fixnum)
```
