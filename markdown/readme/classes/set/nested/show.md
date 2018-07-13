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
--- 'Set (message=''My nested sets'') #<Set:0x00000002921b28>'
```
