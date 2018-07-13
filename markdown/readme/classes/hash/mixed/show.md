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
Hash (size=3 message='My mixed hash'):
  Pair 0:
    Key:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      String (size=3):
        to_s: one
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Pair 2:
    Key:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol (size=3):
        to_s: two
        encoding: !ruby/encoding US-ASCII
```
