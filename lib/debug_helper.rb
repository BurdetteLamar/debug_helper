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

  def show(obj, message, info)
    if object_seen?(obj) || depth_reached?
      handler = GenericHandler.new(self, obj, message, info)
      s = handler.show
    else
      object_ids.push(obj.object_id)
      handler_class = case
                        when obj.kind_of?(Array)
                          EachWithIndexHandler
                        when obj.kind_of?(Dir)
                          DirHandler
                        when obj.kind_of?(Exception)
                          ExceptionHandler
                        when obj.kind_of?(File)
                          FileHandler
                        when obj.kind_of?(IO)
                          IOHandler
                        when obj.kind_of?(Hash)
                          HashHandler
                        when obj.kind_of?(OpenStruct)
                          StructHandler
                        when obj.kind_of?(Range)
                          RangeHandler
                        when obj.kind_of?(Set)
                          EachWithIndexHandler
                        when obj.kind_of?(String)
                          StringHandler
                        when obj.kind_of?(Struct)
                          StructHandler
                        when obj.kind_of?(Symbol)
                          SymbolHandler
                        when obj.instance_of?(Object)
                          ObjectHandler
                        else
                          GenericHandler
                      end
      handler = Object.const_get(handler_class.name).new(method(__method__), obj, message, info)
      s = handler.show
      object_ids.pop
    end
    s
  end

end
