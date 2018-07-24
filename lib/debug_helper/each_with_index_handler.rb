class DebugHelper

  class EachWithIndexHandler < Handler

    def calls_for_instance
      [
          [:size],
      ]
    end

    def each_with_index?
      true
    end

  end

end