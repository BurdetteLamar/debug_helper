#### Circular Sets

This example shows sets that make a circular reference.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set_0 = Set.new([])
set_1 = Set.new([])
set_0.add(set_1)
set_1.add(set_0)
DebugHelper.show(set_0, 'My circular sets')
```

The output shows details of the sets.

The circular reference is not followed.

```show.yaml```:
```yaml
--- 'Set (message=''My circular sets'') #<Set:0x000000028de0a8>'
```
