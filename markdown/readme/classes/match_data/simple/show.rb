require 'debug_helper'

match_data = /[a-z]/.match('abc')
DebugHelper.show(match_data, 'My simple MatchData')
