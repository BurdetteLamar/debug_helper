#### Simple File

This example shows a simple file.

```show.rb```:
```ruby
require 'debug_helper'

gem_file_path = `gem which debug_helper`.chomp
gem_dir_path = File.dirname(gem_file_path)
gem_file_name = File.basename(gem_file_path)
Dir.chdir(gem_dir_path) do
  file = File.new(gem_file_name)
  DebugHelper.show(file, 'Gem file')
end
```

The output shows details of the file.

```show.yaml```:
```yaml
---
File (message='Gem file'):
  File.absolute_path("debug_helper.rb"): C:/Ruby25-x64/lib/ruby/gems/2.5.0/gems/debug_helper-2.0.0/lib/debug_helper.rb
  File.atime("debug_helper.rb"): 2018-10-20 15:50:22.852189200 -05:00
  File.ctime("debug_helper.rb"): 2018-10-20 15:50:22.852189200 -05:00
  File.executable?("debug_helper.rb"): false
  File.exist?("debug_helper.rb"): true
  File.ftype("debug_helper.rb"): file
  File.mtime("debug_helper.rb"): 2018-10-20 15:50:22.853189000 -05:00
  File.path("debug_helper.rb"): debug_helper.rb
  File.pipe?("debug_helper.rb"): false
  File.readable?("debug_helper.rb"): true
  File.realpath("debug_helper.rb"): C:/Ruby25-x64/lib/ruby/gems/2.5.0/gems/debug_helper-2.0.0/lib/debug_helper.rb
  File.setgid?("debug_helper.rb"): false
  File.setuid?("debug_helper.rb"): false
  File.size("debug_helper.rb"): 3651
  File.socket?("debug_helper.rb"): false
  File.symlink?("debug_helper.rb"): false
  File.writable?("debug_helper.rb"): true
```
