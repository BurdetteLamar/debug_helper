#### Simple String

This example shows a simple string.

```show.rb```:
```ruby
require 'debug_helper'

s = 'Lorem ipsum'
DebugHelper.show(s, 'My simple string')
```

The output shows details of the string.

```show.yaml```:
```yaml
---
String (size=11 message='My simple string'):
  to_s: Lorem ipsum
  encoding: !ruby/encoding UTF-8
  ascii_only?: true
  bytesize: 11
```
