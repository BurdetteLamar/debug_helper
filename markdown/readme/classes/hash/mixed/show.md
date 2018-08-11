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
Hash (message='My mixed hash'):
  Hash#size: 3
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      String:
        String#to_s: one
        String#size: 3
        String#encoding: !ruby/encoding UTF-8
        String#ascii_only?: true
        String#bytesize: 3
  Pair 2:
    Key:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        Symbol#to_s: two
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
```
