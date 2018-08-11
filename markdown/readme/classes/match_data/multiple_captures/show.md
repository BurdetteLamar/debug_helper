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
  MatchData#size: 5
  MatchData#regexp: !ruby/regexp /(.)(.)(\d+)(\d)/
  MatchData#to_a:
  - HX1138
  - H
  - X
  - '113'
  - '8'
  MatchData#captures:
  - H
  - X
  - '113'
  - '8'
  MatchData#names: []
```
