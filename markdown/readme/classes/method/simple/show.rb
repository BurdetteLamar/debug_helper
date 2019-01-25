require 'debug_helper'

m = method(:puts)
DebugHelper.show(m, 'My simple Method')
