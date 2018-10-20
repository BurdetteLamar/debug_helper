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
Set (message='My nested sets'):
  Set#size: 3
  Element 0: Integer 0
  Element 1:
    Set:
      Set#size: 2
      Element 0: Integer 1
      Element 1: Integer 2
  Element 2:
    Set:
      Set#size: 2
      Element 0: Integer 3
      Element 1: Integer 4
```
