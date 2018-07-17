class DebugHelper

  class EachWithIndexHandler < Handler

    def show
      content = {}
      obj.each_with_index do |item, i|
        content.store("Element #{i}", show_method.call(item, nil, {}))
      end
      attrs = {
          :size => obj.size,
          :message => message,
      }
      show_item(obj.class.name, content, attrs, info)
    end

  end

end