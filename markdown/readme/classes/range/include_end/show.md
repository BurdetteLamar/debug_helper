#### Inclusive Range

This example shows a ```Range``` that includes its end value.

```show.rb```:
```ruby
require 'debug_helper'

range = (0..4)
DebugHelper.show(range, 'My inclusive range')
```

The output shows details of the ```Range```.

```show.yaml```:
```yaml
---
Range (message='My inclusive range'):
  Range#first: 0
  Range#last: 4
  Range#exclude_end?: false
```
