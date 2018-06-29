#### Range

This example shows a range.

```show.rb```:
```ruby
require 'debug_helper'

range = Range.new(0, 9)
DebugHelper.show(range, 'My range')
```

The output shows details of the range.

```show.yaml```:
```yaml
--- Range (name='My range') 0..9
...
```
