require 'set'
require 'yaml'

require 'debug_helper/version'
require 'debug_helper/handler'
require 'debug_helper/each_pair_handler'
require 'debug_helper/each_with_index_handler'
require 'debug_helper/file_handler'
require 'debug_helper/hash_handler'
require 'debug_helper/object_handler'
require 'debug_helper/string_handler'
require 'debug_helper/struct_handler'
require 'debug_helper/symbol_handler'

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
    x = debug_helper.send(:_show, obj, message, info = {})
    puts x.to_yaml
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

  def _show(obj, message, info)
    if object_seen?(obj) || depth_reached?
      handler = ObjectHandler.new(self, obj, message, info)
      s = handler.show
    else
      object_ids.push(obj.object_id)
      handler_class = case
                        when obj.kind_of?(Array)
                          EachWithIndexHandler
                        when obj.kind_of?(File)
                          FileHandler
                        when obj.kind_of?(Hash)
                          HashHandler
                        when obj.kind_of?(Set)
                          EachWithIndexHandler
                        when obj.kind_of?(String)
                          StringHandler
                        when obj.kind_of?(Struct)
                          StructHandler
                        when obj.kind_of?(Symbol)
                          SymbolHandler
                        else
                          ObjectHandler
                      end
      handler = Object.const_get(handler_class.name).new(self, obj, message, info)
      s = handler.show
      object_ids.pop
    end
    s
  end

  def _show_item(class_name, content, attrs, info)
    message = attrs[:message]
    unless message.nil?
      attrs[:message] = "'#{message}'"
    end
    label = label(class_name, attrs)
    info.store(label, content)
    info
  end

  def label(class_name, attrs)
    a = []
    attrs.each_pair do |key, value|
      a.push("#{key}=#{value}") unless value.nil?
    end
    return class_name if a.empty?
    attrs_s = a.join(' ')
    "#{class_name} (#{attrs_s})"
  end

end
