require 'debug_helper'
require_relative 'foo'
require_relative 'foo_handler'

DebugHelper.show(Foo.new, 'My class Foo')
