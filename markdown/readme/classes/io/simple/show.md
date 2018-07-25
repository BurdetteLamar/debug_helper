#### Simple Dir

This example shows a simple ```IO```.

```show.rb```:
```ruby
require 'debug_helper'

io = IO.new(IO.sysopen(__FILE__, 'r'), 'r')
DebugHelper.show(dir, 'My simple io')
```

The output shows details of the ```IO```.

```show.yaml```:
```yaml
```
