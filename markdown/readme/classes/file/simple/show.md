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
  File.absolute_path("show.rb"): C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  File.atime("show.rb"): 2018-07-14 12:45:32.000000000 -05:00
  File.ctime("show.rb"): 2018-07-14 12:45:32.000000000 -05:00
  File.executable?("show.rb"): false
  File.exist?("show.rb"): true
  File.ftype("show.rb"): file
  File.mtime("show.rb"): 2018-07-14 12:45:32.000000000 -05:00
  File.path("show.rb"): show.rb
  File.pipe?("show.rb"): false
  File.readable?("show.rb"): true
  File.realpath("show.rb"): C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  File.setgid?("show.rb"): false
  File.setuid?("show.rb"): false
  File.size("show.rb"): 95
  File.socket?("show.rb"): false
  File.symlink?("show.rb"): false
  File.writable?("show.rb"): true
```
