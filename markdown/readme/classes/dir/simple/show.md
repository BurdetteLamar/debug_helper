#### Simple Dir

This example shows a simple ```Dir```.

```show.rb```:
```ruby
require 'debug_helper'

dir = Dir.new(File.dirname(__FILE__))
DebugHelper.show(dir, 'My simple dir')
```

The output shows details of the ```Dir```.

```show.yaml```:
```yaml
---
Dir (message='My simple dir'):
  Dir#path: "."
  Dir.entries("."):
  - "."
  - ".."
  - show.md
  - show.rb
  - show.yaml
  - template.md
  Dir.exist?("."): true
```
