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
--- 'DateTime (message=''My datetime'') #<DateTime: 2018-07-25T18:07:41-05:00 ((2458325j,83261s,119718000n),-18000s,2299161j)>'
```
