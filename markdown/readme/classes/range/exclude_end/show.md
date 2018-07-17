#### Simple Array

This example shows a ```Range``` that excludes its end value.

```show.rb```:
```ruby
require 'debug_helper'

range = (0...4)
DebugHelper.show(range, 'My exclusive range')
```

The output shows details of the ```Range```.

```show.yaml```:
```yaml
---
Range (message='My exclusive range'):
  first: 0
  last: 4
  exclude_end?: true
```
