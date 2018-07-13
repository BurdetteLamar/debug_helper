#### Nested Sets

This example shows nested sets.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set = Set.new(
    [0,
     Set.new([1, 2]),
     Set.new([3, 4]),
     ])
DebugHelper.show(set, 'My nested sets')
```

The output shows details of the sets.

```show.yaml```:
```yaml
---
Set (message='My nested sets' size=3):
  Element 0: Fixnum 0
  Element 1:
    Set (size=2):
      Element 0: Fixnum 1
      Element 1: Fixnum 2
  Element 2:
    Set (size=2):
      Element 0: Fixnum 3
      Element 1: Fixnum 4
```
