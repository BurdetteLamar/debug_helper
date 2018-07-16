require 'set'
require 'yaml'

require 'debug_helper/version'

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

  class Handler

    attr_accessor :debug_helper, :obj, :message, :info

    def initialize(debug_helper, obj, message, info)
      self.debug_helper = debug_helper
      self.obj = obj
      self.message = message
      self.info = info
    end

  end

  class EachWithIndexHandler < Handler

    def show
      content = {}
      obj.each_with_index do |item, i|
        content.store("Element #{i}", debug_helper._show(item, nil, {}))
      end
      attrs = {
          :size => obj.size,
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end

  end

  class EachPairHandler < Handler

    attr_accessor :pair_names, :attrs

    def show
      pair_name, key_name, value_name = *pair_names
      content = {}
      i = 0
      obj.each_pair do |key, value|
        pair = {key_name => debug_helper._show(key, nil, {}), value_name => debug_helper._show(value, nil, {})}
        content.store("#{pair_name} #{i}", pair)
        i += 1
      end
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end

  end

  class FileHandler < Handler

    def show
      content = {}
      {
          :absolute_path => [obj.path],
          :atime => [obj.path],
          :ctime => [obj.path],
          :executable? => [obj.path],
          :exist? => [obj.path],
          :ftype => [obj.path],
          :mtime => [obj.path],
          :path => [obj.path],
          :pipe? => [obj.path],
          :readable? => [obj.path],
          :realpath => [obj.path],
          :setgid? => [obj.path],
          :setuid? => [obj.path],
          :size => [obj.path],
          :socket? => [obj.path],
          :symlink? => [obj.path],
          :writable? => [obj.path],
      }.each_pair do |method, args|
        content.store(method.to_s, File.send(method, *args))
      end
      attrs = {
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end
  end

  class HashHandler < EachPairHandler

    def show
      self.pair_names = %w/Pair Key Value/
      self.attrs = {
          :size => obj.size,
          :default => obj.default,
          :default_proc => obj.default_proc,
          :message => message,
      }
      super
    end

  end

  class ObjectHandler < Handler

    def show
      message_info = message.nil? ? '' : " (message='#{message}')"
      "#{obj.class.name}#{message_info} #{obj.inspect}"
    end

  end

  class StringHandler < Handler

    def show
      content = {}
      [
          :to_s,
          :encoding,
          :ascii_only?,
          :bytesize,
      ].each do |method|
        content.store(method.to_s, obj.send(method))
      end
      attrs = {
          :size => obj.send(:size),
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end
  end

  class StructHandler < EachPairHandler

    def show
      self.pair_names = %w/Member Name Value/
      self.attrs = {
          :size => obj.size,
          :message => message,
      }
      super
    end

  end

  class SymbolHandler < Handler

    def show
      content = {}
      [
          :to_s,
          :encoding,
      ].each do |method|
        content.store(method.to_s, obj.send(method))
      end
      attrs = {
          :size => obj.send(:size),
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end

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
