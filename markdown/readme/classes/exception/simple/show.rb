require 'debug_helper'

exception = nil
begin
  raise Exception.new('Boo!')
rescue Exception => exception
  # Already saved.
end
DebugHelper.show(exception, 'My simple exception')
