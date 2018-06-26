require 'yaml'

require 'debug_helper/version'

class DebugHelper

  attr_accessor \
      :obj,
      :name,
      :object_ids

  def self.show(obj, name = obj.class)
    debug_helper = DebugHelper.new(obj, name)
    x = debug_helper.send(:_show, obj, name, info = {})
    puts x.to_yaml
  end

  private

  def initialize(obj, name)
    self.obj = obj
    self.name = name
    self.object_ids = []
  end

  def _show(obj, name, info)
    if object_ids.include?(obj.object_id)
      s = show_object(obj, name, info)
    else
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
    end
    object_ids.pop
    s
  end

  def show_array(obj, name, info)
    content = {}
    obj.each_with_index do |item, i|
      content.store("Element #{i}", _show(item, nil, {}))
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    _show_item(obj.class.name, content, attrs, info)
  end

  def show_hash(obj, name, info)
    content = {}
    obj.each_with_index do |pair, i|
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
    _show_item(obj.class.name, content, attrs, info)
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
    _show_item(obj.class.name, [obj], attrs, info)
  end

  def show_struct(obj, name, info)
    content = {}
    i = 0
    obj.each_pair do |member|
      member_name, value = *member
      pair = {'Name' => member_name, 'Value' => _show(value, nil, {})}
      content.store("Member #{i}", pair)
      i += 1
    end
    attrs = {
        :size => obj.size,
        :name => name,
    }
    _show_item(obj.class.name, content, attrs, info)
  end

  def show_symbol(obj, name, info)
    attrs = {
        :size => obj.size,
        :name => name,
    }
    _show_item(obj.class.name, obj, attrs, info)
  end

  def _show_item(class_name, content, attrs, info)
    label = label(class_name, attrs)
    info.store(label, content)
    info
  end

  def label(class_name, attrs)
    a = []
    attrs.each_pair do |key, value|
      a.push("#{key}=#{value}") unless value.nil?
    end
    attrs_s = a.join(' ')
    "#{class_name} (#{attrs_s})"
  end

  # def respond_to!(obj, method)
  #   unless obj.respond_to?(method)
  #     message = "Instance of #{obj.class.name} does not respond to :#{method}"
  #     raise ArgumentError.new(message)
  #   end
  # end
  #
  # def kind_of!(obj, klass)
  #   unless obj.kind_of?(klass)
  #     message = "Instance of #{obj.class.name} is not a kind of #{klass}"
  #     raise ArgumentError.new(message)
  #   end
  # end

end
