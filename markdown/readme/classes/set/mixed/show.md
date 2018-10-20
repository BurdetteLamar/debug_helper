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
  Set#size: 3
  Element 0: Integer 0
  Element 1:
    String:
      String#to_s: one
      String#size: 3
      String#encoding: !ruby/encoding UTF-8
      String#ascii_only?: true
      String#bytesize: 3
  Element 2:
    Symbol:
      Symbol#to_s: two
      Symbol#size: 3
      Symbol#encoding: !ruby/encoding US-ASCII
```
