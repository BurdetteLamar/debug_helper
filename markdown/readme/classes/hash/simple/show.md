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
Hash (size=3 name=My simple hash):
  Pair 0:
    Key:
      Symbol (size=1): :a
    Value: 0 (Fixnum)
  Pair 1:
    Key:
      Symbol (size=1): :b
    Value: 1 (Fixnum)
  Pair 2:
    Key:
      Symbol (size=1): :c
    Value: 2 (Fixnum)
```