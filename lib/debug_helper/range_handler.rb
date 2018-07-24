class DebugHelper

  class RangeHandler < Handler

    def calls_for_instance
      [
          [:first],
          [:last],
          [:exclude_end?],
      ]
    end

  end
end