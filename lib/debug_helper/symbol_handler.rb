class DebugHelper

  class SymbolHandler < Handler

    def calls_for_instance
      [
          [:to_s],
          [:size],
          [:encoding],
      ]
    end

  end

end