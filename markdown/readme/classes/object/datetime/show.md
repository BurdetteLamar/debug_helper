#### DateTime

This example shows a datetime.

```show.rb```:
```ruby
require 'debug_helper'

datetime = DateTime.now
DebugHelper.show(datetime, 'My datetime')
```

The output shows details of the datetime.

```show.yaml```:
```yaml
--- 'DateTime (message=''My datetime'') #<DateTime: 2018-07-17T10:06:48-05:00 ((2458317j,54408s,181332000n),-18000s,2299161j)>'
```
