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
String (name='My multiline string' size=122 encoding=UTF-8 ascii_only=true bytesize=122):
- |
  Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
  sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
```
