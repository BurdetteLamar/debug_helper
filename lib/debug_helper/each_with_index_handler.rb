class DebugHelper

  class EachWithIndexHandler < Handler

    def show
      content = {}
      obj.each_with_index do |item, i|
        content.store("Element #{i}", debug_helper._show(item, nil, {}))
      end
      attrs = {
          :size => obj.size,
          :message => message,
      }
      show_item(obj.class.name, content, attrs, info)
    end

  end

end