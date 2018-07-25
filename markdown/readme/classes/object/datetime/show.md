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
--- 'DateTime (message=''My datetime'') #<DateTime: 2018-07-25T13:55:31-05:00 ((2458325j,68131s,157575000n),-18000s,2299161j)>'
```
