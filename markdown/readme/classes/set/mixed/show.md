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
--- 'Set (message=''My mixed set'') #<Set:0x0000000280c350>'
```
