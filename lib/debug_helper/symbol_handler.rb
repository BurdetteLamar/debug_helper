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
          :size => obj.size,
          :message => message,
      }
      show_item
    end

  end

end