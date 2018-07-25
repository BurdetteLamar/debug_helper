#### Simple Exception

This example shows a simple ```Exception```.

```show.rb```:
```ruby
require 'debug_helper'

exception = nil
begin
  raise Exception.new('Boo!')
rescue Exception => exception
  # Already saved.
end
DebugHelper.show(exception, 'My simple exception')
```

The output shows details of the ```Exception```.

```show.yaml```:
```yaml
---
Exception (message='My simple exception'):
  message: Boo!
  cause: 
  backtrace:
  - show.rb:5:in `<main>'
```
