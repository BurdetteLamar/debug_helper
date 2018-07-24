#### Mixed Set

This example shows a set of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

require 'set'

set = Set.new([0, 'one', :two])
DebugHelper.show(set, 'My mixed set')
```

The output shows details of the set.

```show.yaml```:
```yaml
---
Set (message='My mixed set'):
  size: 3
  Element 0: Fixnum 0
  Element 1:
    String:
      to_s: one
      size: 3
      encoding: !ruby/encoding UTF-8
      ascii_only?: true
      bytesize: 3
  Element 2:
    Symbol:
      to_s: two
      size: 3
      encoding: !ruby/encoding US-ASCII
```
