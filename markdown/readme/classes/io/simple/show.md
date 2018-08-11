#### Simple IO

This example shows a simple ```IO```.

```show.rb```:
```ruby
require 'debug_helper'

io = IO.new(IO.sysopen(__FILE__, 'r'), 'r')
DebugHelper.show(io, 'My simple io')
```

The output shows details of the ```IO```.

```show.yaml```:
```yaml
---
IO (message='My simple io'):
  IO#autoclose?: true
  IO#binmode?: false
  IO#closed?: false
  IO#tty?: false
```
