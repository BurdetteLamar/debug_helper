class DebugHelper

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
      show_item(obj.class.name, content, attrs, info)
    end

  end

end