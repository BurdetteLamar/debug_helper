#### Unanalyzed Object

This example shows an object that will not be analyzed.

```show.rb```:
```ruby
require 'debug_helper'

class MyClass
  def inspect
    'My class inspection'
  end
end
DebugHelper.show(MyClass.new, 'My class')
```

The output shows details of the object.

```show.yaml```:
```yaml
--- MyClass (message='My class') My class inspection
...
```
