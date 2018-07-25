#### Simple Exception

This example shows a simple ```Exception```.

```show.rb```:
```ruby
require 'debug_helper'

def foo
  exception = nil
  begin
    raise Exception.new('Boo!')
  rescue Exception => exception
    # Already saved.
  end
  DebugHelper.show(exception, 'My simple exception')
end

def bar
  foo
end

def baz
  bar
end

baz

```

The output shows details of the ```Exception```.

```show.yaml```:
```yaml
---
Exception (message='My simple exception'):
  message: Boo!
  cause: 
  backtrace:
  - show.rb:6:in `foo'
  - show.rb:14:in `bar'
  - show.rb:18:in `baz'
  - show.rb:21:in `<main>'
```
