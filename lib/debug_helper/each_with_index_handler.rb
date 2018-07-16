class DebugHelper

  class EachWithIndexHandler < Handler

    def show
      obj.each_with_index do |item, i|
        self.content.store("Element #{i}", show_method.call(item, nil, {}))
      end
      self.attrs = {
          :size => obj.size,
          :message => message,
      }
      show_item(obj.class.name)
    end

  end

end