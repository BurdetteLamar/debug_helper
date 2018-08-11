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
      gather
      finish
    end

    def gather
      calls_for_instance.each do |call_info|
        method = call_info.shift
        unless obj.respond_to?(method)
          message = "Instance of #{obj.class} does not respond to method #{method}"
          raise NoMethodError.new(message, method)
        end
        args = call_info
        if args.empty?
          value = obj.send(method)
          key = method.to_s
        else
          value = obj.send(method, *args)
          key = "#{method.to_s}(#{args.inspect})"
        end
        content.store(key, value)
      end
      calls_for_class.each do |call_info|
        klass = Object.const_get(obj.class.name)
        method = call_info.shift
        unless klass.respond_to?(method)
          message = "#{obj.class} does not respond to method #{method}"
          raise NoMethodError.new(message, method)
        end
        args = call_info
        if args.empty?
          value = klass.send(method)
          key = method.to_s
        else
          value = klass.send(method, *args)
          key = "#{method.to_s}(#{args.inspect})"
        end
        content.store(key, value)
      end
      if each_with_index?
        obj.each_with_index do |item, i|
          self.content.store("Element #{i}", show_method.call(item, nil, {}))
        end
      end
      if each_pair?
        pair_name, key_name, value_name = *pair_names
        i = 0
        obj.each_pair do |key, value|
          pair = {key_name => show_method.call(key, nil, {}), value_name => show_method.call(value, nil, {})}
          self.content.store("#{pair_name} #{i}", pair)
          i += 1
        end
      end
    end

    def finish
      attrs[:message] = "'#{message}'" unless message.nil?
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

    def calls_for_class
      []
    end

    def each_with_index?
      false
    end

    def each_pair?
      false
    end

  end

end