#### Simple Regexp

This example shows a simple ```Regexp```.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new(/\w+/)
DebugHelper.show(regexp, 'My simple regexp')
```

The output shows details of the ```Regexp```.

```show.yaml```:
```yaml
---
Regexp (message='My simple regexp'):
  Regexp#to_s: "(?-mix:\\w+)"
  Regexp#casefold?: false
  Regexp#named_captures: {}
  Regexp#encoding: !ruby/encoding US-ASCII
  Regexp#fixed_encoding?: false
```
