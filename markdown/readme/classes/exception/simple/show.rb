require 'debug_helper'

def foo
  exception = nil
  begin
    raise Exception.new('Boo!')
  rescue Exception => exception
    # Already saved.
  end
  DebugHelper.show(exception, 'My simple exception')
end

def bar
  foo
end

def baz
  bar
end

baz

