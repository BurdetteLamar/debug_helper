#### Singleton Methods

This example shows a custom handler that explicates via singleton methods.

Here's a class ```Foo``` that has some singleton methods:
 
```foo.rb```:
```ruby
require 'debug_helper'

class Foo

  def self.my_array
    %w/bat bam bad/
  end

  def self.my_hash
    {:c => 2, :d => 3}
  end

end
```

Here's its custom debug handler class ```FooHandler```.  The array returned in method ```calls_for_class``` tells the base class ```Handler``` which methods to call for the explication.

```foo_handler.rb```:
```ruby
require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_class
      [
          [:my_array],
          [:my_hash],
      ]
    end

  end

end
```

Here's a program that uses the custom handler.

```show.rb```:
```ruby
require 'debug_helper'
require_relative 'foo'
require_relative 'foo_handler'

DebugHelper.show(Foo.new, 'My class Foo')
```

The output shows details of the object.

```show.yaml```:
```yaml
---
Foo (message='My class Foo'):
  my_array:
  - bat
  - bam
  - bad
  my_hash:
    :c: 2
    :d: 3
```
