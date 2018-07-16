class DebugHelper

  class Handler

    attr_accessor :show_method, :obj, :message, :info, :attrs

    def initialize(show_method, obj, message, info)
      self.show_method = show_method
      self.obj = obj
      self.message = message
      self.info = info
      self.attrs = {}
    end

    def show_item(class_name, content, info)
      message = attrs[:message]
      unless message.nil?
        attrs[:message] = "'#{message}'"
      end
      label = label(class_name)
      info.store(label, content)
      info
    end

    def label(class_name)
      a = []
      attrs.each_pair do |key, value|
        a.push("#{key}=#{value}") unless value.nil?
      end
      return class_name if a.empty?
      attrs_s = a.join(' ')
      "#{class_name} (#{attrs_s})"
    end

  end

end