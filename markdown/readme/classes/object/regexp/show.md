#### Regexp

This example shows a regexp.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new('foo')
DebugHelper.show(regexp, 'My regexp')
```

The output shows details of the regexp.

```show.yaml```:
```yaml
--- Regexp (name='My regexp') (?-mix:foo)
...
```
