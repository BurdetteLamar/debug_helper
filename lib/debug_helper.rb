require 'yaml'

require 'debug_helper/version'

class DebugHelper

  attr_accessor \
      :obj,
      :name,
      :object_ids,
      :section_indexes

  def self.show(obj, name = obj.class)
    debug_helper = DebugHelper.new(obj, name)
    object_ids = []
    x = debug_helper.send(:_show, obj, name, info = {})
    puts x.to_yaml
  end

  private

  def initialize(obj, name)
    self.obj = obj
    self.name = name
    self.object_ids = []
    self.section_indexes = []
  end

  def _show(obj, name, info)
    section_indexes.push(0)
    if object_ids.include?(obj.object_id)
      s = show_object(obj, name, info)
      section_indexes.pop
      return s
    end
    object_ids.push(obj.object_id)
    s = case
          when obj.kind_of?(Array)
            show_array(obj, name, info)
          when obj.kind_of?(Hash)
            show_hash(obj, name, info)
          when obj.kind_of?(String)
            show_string(obj, name, info)
          when obj.kind_of?(Struct)
            show_struct(obj, name, info)
          when obj.kind_of?(Symbol)
            show_symbol(obj, name, info)
          # when obj.kind_of?(Range)
          # when obj.kind_of?(Set)
          else
            show_object(obj, name, info)
        end
    object_ids.pop
    section_indexes.pop
    s
  end

  def label(class_name, attrs)
    index = section_indexes.collect {|x| x.to_s }.join('.')
    STDOUT.puts index
    a = []
    attrs.each_pair do |key, value|
      a.push("#{key}=#{value}") unless value.nil?
    end
    attrs_s = a.join(' ')
    "#{class_name} (#{attrs_s})"
  end

  def show_array(obj, name, info)
    content = {}
    obj.each_with_index do |item, i|
      section_indexes[-1] = i
      content.store("Element #{i}", _show(item, nil, {}))
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    label = label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def show_hash(obj, name, info)
    content = {}
    obj.each_with_index do |pair, i|
      section_indexes[-1] = i
      key, value = *pair
      pair = {'Key' => _show(key, nil, {}), 'Value' => _show(value, nil, {})}
      content.store("Pair #{i}", pair)
    end
    default = obj.default.nil? ? 'nil' : obj.default
    attrs = {
        :size => obj.size,
        :default => obj.default,
        :name => name,
    }
    label = label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def show_object(obj, name, info)
    "#{obj} (#{obj.class.name})"
  end

  def show_string(obj, name, info)
    attrs = {
        :size => obj.size,
        :encoding => obj.encoding,
        :name => name,
    }
    label = label(obj.class.name, attrs)
    info.store(label, [obj])
    info
  end

  def show_struct(obj, name, info)
    content = {}
    i = 0
    obj.each_pair do |member|
      section_indexes[-1] = i
      member_name, value = *member
      pair = {'Name' => member_name, 'Value' => _show(value, nil, {})}
      content.store("Member #{i}", pair)
      i += 1
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    label = label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def show_symbol(obj, name, info)
    attrs = {
        :size => obj.size,
        :name => name,
    }
    label = label(obj.class.name, attrs)
    info.store(label, obj)
    info
  end

  def respond_to!(obj, method)
    unless obj.respond_to?(method)
      message = "Instance of #{obj.class.name} does not respond to :#{method}"
      raise ArgumentError.new(message)
    end
  end

  def kind_of!(obj, klass)
    unless obj.kind_of?(klass)
      message = "Instance of #{obj.class.name} is not a kind of #{klass}"
      raise ArgumentError.new(message)
    end
  end

end
