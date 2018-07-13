require 'set'

require 'debug_helper'

set_0 = Set.new([])
set_1 = Set.new([])
set_0.add(set_1)
set_1.add(set_0)
DebugHelper.show(set_0, 'My circular sets')
