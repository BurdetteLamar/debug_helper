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
  self.absolute_path: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  self.atime: 2018-07-14 12:45:32.000000000 -05:00
  self.ctime: 2018-07-14 12:45:32.000000000 -05:00
  self.executable?: false
  self.exist?: true
  self.ftype: file
  self.mtime: 2018-07-14 12:45:32.000000000 -05:00
  self.path: show.rb
  self.pipe?: false
  self.readable?: true
  self.realpath: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  self.setgid?: false
  self.setuid?: false
  self.size: 95
  self.socket?: false
  self.symlink?: false
  self.writable?: true
```
