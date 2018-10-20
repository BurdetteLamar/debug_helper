#### Simple Set

This example shows a simple set of integers.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set = Set.new([5, 10, 15])
DebugHelper.show(set, 'My simple set')
```

The output shows details of the set.

```show.yaml```:
```yaml
---
Set (message='My simple set'):
  Set#size: 3
  Element 0: Integer 5
  Element 1: Integer 10
  Element 2: Integer 15
```
