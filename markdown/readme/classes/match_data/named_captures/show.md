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
  MatchData#size: 3
  MatchData#regexp: !ruby/regexp /(?<x>.)(?<y>.)?/
  MatchData#to_a:
  - a
  - a
  - 
  MatchData#captures:
  - a
  - 
  MatchData#names:
  - x
  - y
```
