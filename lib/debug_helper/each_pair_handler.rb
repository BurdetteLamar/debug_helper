class DebugHelper

  class EachPairHandler < Handler

    attr_accessor :pair_names

    def show
      pair_name, key_name, value_name = *pair_names
      i = 0
      obj.each_pair do |key, value|
        pair = {key_name => show_method.call(key, nil, {}), value_name => show_method.call(value, nil, {})}
        self.content.store("#{pair_name} #{i}", pair)
        i += 1
      end
      show_item(obj.class.name, info)
    end

  end

end