require 'yaml'

require 'debug_helper/version'

class DebugHelper

  def self.show(obj, name = obj.class)
    @@object_ids = []
    x = self._show(obj, name, info = {})
    puts x.to_yaml
  end

  private

  def self._show(obj, name, info)
    if @@object_ids.include?(obj.object_id)
      return self.show_object(obj, name, info)
    end
    @@object_ids.push(obj.object_id)
    s = case
          when obj.kind_of?(Array)
            self.show_array(obj, name, info)
          when obj.kind_of?(Hash)
            self.show_hash(obj, name, info)
          when obj.kind_of?(String)
            self.show_string(obj, name, info)
          when obj.kind_of?(Struct)
            self.show_struct(obj, name, info)
          when obj.kind_of?(Symbol)
            self.show_symbol(obj, name, info)
          # when obj.kind_of?(Range)
          # when obj.kind_of?(Set)
          # when obj.kind_of?(Struct)
          else
            self.show_object(obj, name, info)
        end
    @@object_ids.pop
    s
  end

  def self.label(class_name, attrs)
    a = []
    attrs.each_pair do |key, value|
      a.push("#{key}=#{value}") unless value.nil?
    end
    attrs_s = a.join(' ')
    "#{class_name} (#{attrs_s})"
  end

  def self.show_array(obj, name, info)
    content = {}
    obj.each_with_index do |item, i|
      content.store("Element #{i}", self._show(item, nil, {}))
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    label = self.label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def self.show_hash(obj, name, info)
    content = {}
    obj.each_with_index do |pair, i|
      key, value = *pair
      pair = {'Key' => self._show(key, nil, {}), 'Value' => self._show(value, nil, {})}
      content.store("Pair #{i}", pair)
    end
    default = obj.default.nil? ? 'nil' : obj.default
    attrs = {
        :size => obj.size,
        :default => obj.default,
        :name => name,
    }
    label = self.label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def self.show_object(obj, name, info)
    "#{obj} (#{obj.class.name})"
  end

  def self.show_string(obj, name, info)
    attrs = {
        :size => obj.size,
        :encoding => obj.encoding,
        :name => name,
    }
    label = self.label(obj.class.name, attrs)
    info.store(label, [obj])
    info
  end

  def self.show_struct(obj, name, info)
    content = {}
    i = 0
    obj.each_pair do |member|
      member_name, value = *member
      pair = {'Name' => member_name, 'Value' => self._show(value, nil, {})}
      content.store("Member #{i}", pair)
      i += 1
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    label = self.label(obj.class.name, attrs)
    info.store(label, content)
    info
  end

  def self.show_symbol(obj, name, info)
    label = "#{obj.class.name} (size=#{obj.size})"
    info.store(label, obj)
    info
  end

  def self.respond_to!(obj, method)
    unless obj.respond_to?(method)
      message = "Instance of #{obj.class.name} does not respond to :#{method}"
      raise ArgumentError.new(message)
    end
  end

  def self.kind_of!(obj, klass)
    unless obj.kind_of?(klass)
      message = "Instance of #{obj.class.name} is not a kind of #{klass}"
      raise ArgumentError.new(message)
    end
  end

end
