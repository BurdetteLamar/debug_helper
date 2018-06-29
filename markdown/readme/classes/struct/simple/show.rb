require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct = MyStruct.new(0, 1, 2)
DebugHelper.show(struct, 'My simple struct')
