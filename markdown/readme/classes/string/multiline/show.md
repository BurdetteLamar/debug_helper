#### Multiline String

This example shows a multiline string.

```show.rb```:
```ruby
require 'debug_helper'

s = <<EOT
Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
EOT
DebugHelper.show(s, 'My multiline string')
```

The output shows details of the string.

```show.yaml```:
```yaml
---
String (message='My multiline string'):
  String#to_s: |
    Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
    sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
  String#size: 122
  String#encoding: !ruby/encoding UTF-8
  String#ascii_only?: true
  String#bytesize: 122
```
