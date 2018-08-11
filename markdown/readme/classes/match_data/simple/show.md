#### Simple MatchData

This example shows a simple ```MatchData```.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /[a-z]/.match('abc')
DebugHelper.show(match_data, 'My simple MatchData')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My simple MatchData'):
  MatchData#size: 1
  MatchData#regexp: !ruby/regexp /[a-z]/
  MatchData#to_a:
  - a
  MatchData#captures: []
  MatchData#names: []
```
