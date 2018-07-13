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
--- 'Set (message=''My simple set'') #<Set:0x000000027f23b0>'
```
