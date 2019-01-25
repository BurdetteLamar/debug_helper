#### Simple Method

This example shows a simple ```Method```.

```show.rb```:
```ruby
require 'debug_helper'

m = method(:puts)
DebugHelper.show(m, 'My simple Method')
```

The output shows details of the ```Method```.

```show.yaml```:
```yaml
---
Method (message='My simple Method'):
  Method#arity: -1
  Method#inspect: "#<Method: main.puts>"
  Method#name: :puts
  Method#original_name: :puts
  Method#owner: !ruby/module 'Kernel'
  Method#parameters:
  - - :rest
  Method#source_location: 
  Method#super_method: 
```
