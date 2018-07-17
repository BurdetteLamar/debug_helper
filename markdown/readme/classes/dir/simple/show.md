#### Simple Dir

This example shows a simple ```Dir  ``.

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
  path: "."
  entries:
  - "."
  - ".."
  - show.md
  - show.rb
  - show.yaml
  - template.md
  exist?: true
```
