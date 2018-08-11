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
String (message='My simple string'):
  String#to_s: Lorem ipsum
  String#size: 11
  String#encoding: !ruby/encoding UTF-8
  String#ascii_only?: true
  String#bytesize: 11
```
