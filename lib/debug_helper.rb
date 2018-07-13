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

  private

  def initialize(obj, message, options)
    self.obj = obj
    self.message = message
    self.depth = options[:depth] || 3
    self.object_ids = []
  end

  def _show(obj, message, info)
    if object_ids.include?(obj.object_id)
      s = show_object(obj, message, info)
    elsif depth == object_ids.size
      s = show_object(obj, message, info)
    else
      object_ids.push(obj.object_id)
      s = case
            when obj.kind_of?(Array)
              show_array(obj, message, info)
            when obj.kind_of?(Hash)
              show_hash(obj, message, info)
            when obj.kind_of?(Set)
              show_array(obj, message, info)
            when obj.kind_of?(Struct)
              show_struct(obj, message, info)
            # when obj.kind_of?(Range)
            else
              show_object(obj, message, info)
          end
      object_ids.pop
    end
    s
  end

  def show_array(obj, message, info)
    content = {}
    obj.each_with_index do |item, i|
      content.store("Element #{i}", _show(item, nil, {}))
    end
    attrs = {
        :message => message,
        :size => obj.size,
    }
    _show_item(obj.class.name, content, attrs, info)
  end

  def show_hash(obj, message, info)
    content = {}
    obj.each_with_index do |pair, i|
      key, value = *pair
      pair = {'Key' => _show(key, nil, {}), 'Value' => _show(value, nil, {})}
      content.store("Pair #{i}", pair)
    end
    attrs = {
        :size => obj.size,
        :default => obj.default,
        :default_proc => obj.default_proc,
        :message => message,
    }
    _show_item(obj.class.name, content, attrs, info)
  end

  def show_object(obj, message, info)
    methods = methods_for_object(obj)
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
      _show_item(obj.class.name, content, attrs, info)
    end
  end

  def show_struct(obj, message, info)
    content = {}
    i = 0
    obj.each_pair do |member|
      member_name, value = *member
      pair = {'Name' => member_name, 'Value' => _show(value, nil, {})}
      content.store("Member #{i}", pair)
      i += 1
    end
    attrs = {
        :message => message,
        :size => obj.size,
    }
    _show_item(obj.class.name, content, attrs, info)
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
