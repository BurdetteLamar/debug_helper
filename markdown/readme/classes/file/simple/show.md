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
  absolute_path: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  atime: 2018-07-14 12:45:32.000000000 -05:00
  ctime: 2018-07-14 12:45:32.000000000 -05:00
  executable?: false
  exist?: true
  ftype: file
  mtime: 2018-07-14 12:45:32.000000000 -05:00
  path: show.rb
  pipe?: false
  readable?: true
  realpath: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  setgid?: false
  setuid?: false
  size: 95
  socket?: false
  symlink?: false
  writable?: true
```
