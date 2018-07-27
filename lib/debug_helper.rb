require 'ostruct'
require 'set'
require 'yaml'

require_relative 'debug_helper/version'

require_relative 'debug_helper/handler'

  require_relative 'debug_helper/each_with_index_handler'

  require_relative 'debug_helper/each_pair_handler'
    require_relative 'debug_helper/hash_handler'
    require_relative 'debug_helper/struct_handler'

  require_relative 'debug_helper/dir_handler'
  require_relative 'debug_helper/exception_handler'
  require_relative 'debug_helper/file_handler'
  require_relative 'debug_helper/generic_handler'
  require_relative 'debug_helper/io_handler'
  require_relative 'debug_helper/object_handler'
  require_relative 'debug_helper/string_handler'
  require_relative 'debug_helper/symbol_handler'
  require_relative 'debug_helper/range_handler'

class DebugHelper

  module Putd

    def putd(obj, message, options = {})
      DebugHelper.show(obj, message, options)
    end

  end

  attr_accessor \
      :obj,
      :message,
      :object_ids,
      :depth

  def self.show(obj, message = obj.class, options = {})
    debug_helper = DebugHelper.new(obj, message, options)
    s = debug_helper.show(obj, message, info = {})
    puts s.to_yaml
  end

  def initialize(obj, message, options)
    self.obj = obj
    self.message = message
    self.depth = options[:depth] || 3
    self.object_ids = []
  end

  def object_seen?(obj)
    object_ids.include?(obj.object_id)
  end

  def depth_reached?
    depth == object_ids.size
  end

  ArrayHandler = EachWithIndexHandler
  SetHandler = EachWithIndexHandler
  OpenStructHandler = StructHandler

  def show(obj, message, info)
    handler = nil
    if object_seen?(obj) || depth_reached?
      handler = GenericHandler.new(self, obj, message, info)
      s = handler.show
    else
      object_ids.push(obj.object_id)
      begin
        # If there's a handler for the class, use it.
        # Note that the class may be a custom class, not defined here,
        # but instead defined outside this project.
        # So if the user of this library has defined DebugHelper::FooHandler
        # and the object is a Foo, that handler will be selected and called.
        handler_class_name = "DebugHelper::#{obj.class.name}Handler"
        handler_class = Object.const_get(handler_class_name)
        handler = handler_class.new(method(__method__), obj, message, info)
      rescue
        # If there's not a handler for the class, try using :kind_of?.
        [
            Array,
            Dir,
            Exception,
            File,
            IO,
            Hash,
            OpenStruct,
            Range,
            Set,
            String,
            Struct,
            # There's no method Symbol.new, so cannot instantiate a subclass.
            # Symbol,
        ].each do |klass|
          if obj.kind_of?(klass)
            handler_class_name = "DebugHelper::#{klass.name}Handler"
            handler_class = Object.const_get(handler_class_name)
            handler = handler_class.new(method(__method__), obj, message, info)
            break
          end
        end
      end
      if handler.nil?
        if obj.instance_of?(Object)
          handler_class= ObjectHandler
        else
          handler_class = GenericHandler
        end
        handler = handler_class.new(self, obj, message, info)
      end
      s = handler.show
      object_ids.pop
    end
    s
  end

end
