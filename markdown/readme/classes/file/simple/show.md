#### Simple File

This example shows a simple file.

```show.rb```:
```ruby
require 'debug_helper'

file = File.new(__FILE__)
DebugHelper.show(file, 'My simple file')
```

The output shows details of the file.

```show.yaml```:
```yaml
---
File (message='My simple file'):
  path: show.rb
  atime: 2018-07-13 11:44:18.000000000 -05:00
  ctime: 2018-07-13 11:41:01.000000000 -05:00
  mtime: 2018-07-13 11:44:18.000000000 -05:00
  size: 95
```
