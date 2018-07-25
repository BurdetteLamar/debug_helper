require 'debug_helper'

io = IO.new(IO.sysopen(__FILE__, 'r'), 'r')
DebugHelper.show(io, 'My simple io')
