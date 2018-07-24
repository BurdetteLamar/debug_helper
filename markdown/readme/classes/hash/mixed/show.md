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
    Value:
      String:
        to_s: one
        size: 3
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Pair 2:
    Key:
      Symbol:
        to_s: c
        size: 1
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        to_s: two
        size: 3
        encoding: !ruby/encoding US-ASCII
```
