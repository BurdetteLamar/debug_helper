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
  Regexp#to_s: "(?-mix:(?<a>.)(?<b>.))"
  Regexp#casefold?: false
  Regexp#named_captures:
    a:
    - 1
    b:
    - 2
  Regexp#encoding: !ruby/encoding US-ASCII
  Regexp#fixed_encoding?: false
```
