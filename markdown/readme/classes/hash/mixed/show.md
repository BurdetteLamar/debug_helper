#### Mixed Hash

This example shows a hash of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

hash = {
    :a => 0,
    :b => 'one',
    :c => :two,
}
DebugHelper.show(hash, 'My mixed hash')
```

The output shows details of the hash.

```show.yaml```:
```yaml
---
Hash (size=3 name='My mixed hash'):
  Pair 0:
    Key:
      Symbol (size=1 encoding=US-ASCII): :a
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1 encoding=US-ASCII): :b
    Value:
      String (size=3 encoding=UTF-8 ascii_only=true bytesize=3):
      - one
  Pair 2:
    Key:
      Symbol (size=1 encoding=US-ASCII): :c
    Value:
      Symbol (size=3 encoding=US-ASCII): :two
```