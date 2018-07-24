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
      show
    end

    def show
      calls_for_instance.each do |call_info|
        method = call_info.shift
        args = call_info
        if args.empty?
          value = obj.send(method)
        else
          value = obj.send(method, *args)
        end
        content.store(method.to_s, value)
      end
      attrs[:message] = "'#{message}'"
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

    def calls_for_instance
      []
    end

  end

end