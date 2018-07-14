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
--- 'DateTime (message=''My datetime'') #<DateTime: 2018-07-14T10:18:04-05:00 ((2458314j,55084s,502867000n),-18000s,2299161j)>'
```
