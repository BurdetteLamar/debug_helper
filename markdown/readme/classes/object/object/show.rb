require 'debug_helper'

class MyClass
  def inspect
    'My class inspection'
  end
end
DebugHelper.show(MyClass.new, 'My class')
