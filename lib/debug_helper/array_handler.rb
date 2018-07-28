class DebugHelper

  class ArrayHandler < EachWithIndexHandler

    def calls_for_instance
      [
          [:size],
      ]
    end

  end
end