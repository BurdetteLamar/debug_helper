#### Multiple Captures

This example shows a ```MatchData``` with multiple captures.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /(.)(.)(\d+)(\d)/.match('THX1138.')
DebugHelper.show(match_data, 'My MatchData with named captures')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My MatchData with named captures'):
  size: 5
  regexp: !ruby/regexp /(.)(.)(\d+)(\d)/
  to_a:
  - HX1138
  - H
  - X
  - '113'
  - '8'
  captures:
  - H
  - X
  - '113'
  - '8'
  names: []
```
