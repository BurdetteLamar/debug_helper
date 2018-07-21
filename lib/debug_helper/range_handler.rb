class DebugHelper

  class RangeHandler < Handler

    def show
      # Instance methods.
      [
          :first,
          :last,
          :exclude_end?,
      ].each do |method|
        self.content.store(method.to_s, obj.send(method))
      end
      self.attrs = {
          :message => message,
      }
      show_item
    end

  end
end