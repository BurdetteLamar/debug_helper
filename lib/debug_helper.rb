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
                  when obj.kind_of?(Hash)
                    HashHandler
                  when obj.kind_of?(Set)
                    EachWithIndexHandler
                  when obj.kind_of?(Struct)
                    StructHandler
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
          :message => message,
          :size => obj.size,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end

  end

  class HashHandler < Handler

    def show
      content = {}
      obj.each_with_index do |pair, i|
        key, value = *pair
        pair = {'Key' => debug_helper._show(key, nil, {}), 'Value' => debug_helper._show(value, nil, {})}
        content.store("Pair #{i}", pair)
      end
      attrs = {
          :size => obj.size,
          :default => obj.default,
          :default_proc => obj.default_proc,
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end

  end

  class ObjectHandler < Handler

    def show
      methods = debug_helper.methods_for_object(obj)
      if methods.nil?
        message_info = message.nil? ? '' : " (message='#{message}')"
        "#{obj.class.name}#{message_info} #{obj.inspect}"
      else
        content = {}
        attrs = {:message => message}
        methods[:instance].each do |instance_method|
          value = obj.send(instance_method)
          if instance_method == :size
            attrs.store(:size, value)
          else
            content.store(instance_method.to_s, value)
          end
        end
        methods[:class].each do |pair|
          class_method, arguments = *pair
          value = Object.const_get(obj.class.to_s).send(class_method, *arguments)
          content.store(class_method.to_s, value)
        end
        debug_helper._show_item(obj.class.name, content, attrs, info)
      end
    end

  end

  class StructHandler < Handler

    def show
      content = {}
      i = 0
      obj.each_pair do |member|
        member_name, value = *member
        pair = {'Name' => member_name, 'Value' => debug_helper._show(value, nil, {})}
        content.store("Member #{i}", pair)
        i += 1
      end
      attrs = {
          :message => message,
          :size => obj.size,
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

  def methods_for_object(obj)
    methods = case
                when obj.kind_of?(File)
                  {
                      # The instance forms of some of these require the file to be open.
                      :class => {
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
                      },
                      :instance => [],
                  }
                when obj.kind_of?(String)
                  {
                      :class => {},
                      :instance => [
                          :to_s,
                          :size,
                          :encoding,
                          :ascii_only?,
                          :bytesize,
                      ]
                  }
                when obj.kind_of?(Symbol)
                  {
                      :class => {},
                      :instance => [
                          :to_s,
                          :size,
                          :encoding,
                      ]
                  }
                else
                  nil
              end
    methods
  end

end
