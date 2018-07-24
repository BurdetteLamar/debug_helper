#### Simple Symbol

This example shows a simple symbol.

```show.rb```:
```ruby
require 'debug_helper'

DebugHelper.show(:lorem_ipsum, 'My symbol')
```

The output shows details of the symbol.

```show.yaml```:
```yaml
---
Symbol (message='My symbol'):
  to_s: lorem_ipsum
  size: 11
  encoding: !ruby/encoding US-ASCII
```
