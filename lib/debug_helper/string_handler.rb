class DebugHelper

  class StringHandler < Handler

    def show
      [
          :to_s,
          :encoding,
          :ascii_only?,
          :bytesize,
      ].each do |method|
        self.content.store(method.to_s, obj.send(method))
      end
      self.attrs = {
          :size => obj.send(:size),
          :message => message,
      }
      show_item
    end
  end

end