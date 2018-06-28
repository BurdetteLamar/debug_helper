require 'debug_helper'

MyStruct_0 = Struct.new(:a, :b)
MyStruct_1 = Struct.new(:c, :d)
struct_1a = MyStruct_0.new(2, 3)
struct_1b = MyStruct_0.new(4, 5)
struct_0 = MyStruct_0.new(struct_1a, struct_1b)
DebugHelper.show(struct_0, 'My nested struct')
