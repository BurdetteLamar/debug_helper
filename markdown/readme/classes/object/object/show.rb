require 'debug_helper'

class MyClass
  attr_accessor :foo, :bar, :baz
end
DebugHelper.show(MyClass.new, 'My class')
