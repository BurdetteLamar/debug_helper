require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(:a => 0, :b => 1, :c => 2)
DebugHelper.show(ostruct, 'My simple struct')
