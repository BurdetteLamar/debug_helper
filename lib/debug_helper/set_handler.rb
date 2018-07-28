class DebugHelper

  class SetHandler < EachWithIndexHandler

    def calls_for_instance
      [
          [:size],
      ]
    end

  end
end