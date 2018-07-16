class DebugHelper

  class StringHandler < Handler

    def show
      content = {}
      [
          :to_s,
          :encoding,
          :ascii_only?,
          :bytesize,
      ].each do |method|
        content.store(method.to_s, obj.send(method))
      end
      self.attrs = {
          :size => obj.send(:size),
          :message => message,
      }
      show_item(obj.class.name, content, info)
    end
  end

end