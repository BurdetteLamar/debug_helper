require 'debug_helper'

match_data = /(.)(.)(\d+)(\d)/.match('THX1138.')
DebugHelper.show(match_data, 'My MatchData with named captures')
