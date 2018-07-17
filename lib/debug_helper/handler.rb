class DebugHelper

  class Handler

    attr_accessor :show_method, :obj, :message, :info, :attrs, :content

    def initialize(show_method, obj, message, info)
      self.show_method = show_method
      self.obj = obj
      self.message = message
      self.info = info
      self.attrs = {}
      self.content = {}
    end

    def show_item
      message = attrs[:message]
      unless message.nil?
        attrs[:message] = "'#{message}'"
      end
      self.info.store(label, content)
      info
    end

    def label
      a = []
      attrs.each_pair do |key, value|
        a.push("#{key}=#{value}") unless value.nil?
      end
      return self.obj.class.name if a.empty?
      attrs_s = a.join(' ')
      "#{self.obj.class.name} (#{attrs_s})"
    end

  end

end