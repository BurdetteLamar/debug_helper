require 'debug_helper'

match_data = /(?<x>.)(?<y>.)?/.match("a")
DebugHelper.show(match_data, 'My MatchData with named captures')
