#### Nested Hashes

This example shows nested hashes.

```show.rb```:
```ruby
require 'debug_helper'

hasn = {
    :a => {
        :b => 0,
        :c => 1,
    }
}
DebugHelper.show(hash, 'My nested hash')
```

The output shows details of the hashes.

```show.yaml```:
```yaml
--- "-181461328 (Fixnum)"
```
