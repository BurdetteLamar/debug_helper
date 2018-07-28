#### Named Captures

This example shows a ```Regexp``` with named captures.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new(/(?<a>.)(?<b>.)/)
DebugHelper.show(regexp, 'My regexp with named captures')
```

The output shows details of the ```Regexp```.

```show.yaml```:
```yaml
---
Regexp (message='My regexp with named captures'):
  to_s: "(?-mix:(?<a>.)(?<b>.))"
  casefold?: false
  named_captures:
    a:
    - 1
    b:
    - 2
  encoding: !ruby/encoding US-ASCII
  fixed_encoding?: false
```
