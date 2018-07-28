#### Named Captures

This example shows a ```MatchData``` with named captures.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /(?<x>.)(?<y>.)?/.match("a")
DebugHelper.show(match_data, 'My MatchData with named captures')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My MatchData with named captures'):
  size: 3
  regexp: !ruby/regexp /(?<x>.)(?<y>.)?/
  to_a:
  - a
  - a
  - 
  captures:
  - a
  - 
  names:
  - x
  - y
```
