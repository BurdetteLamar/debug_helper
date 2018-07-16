class DebugHelper

  class SymbolHandler < Handler

    def show
      [
          :to_s,
          :encoding,
      ].each do |method|
        self.content.store(method.to_s, obj.send(method))
      end
      self.attrs = {
          :size => obj.send(:size),
          :message => message,
      }
      show_item(obj.class.name)
    end

  end

end