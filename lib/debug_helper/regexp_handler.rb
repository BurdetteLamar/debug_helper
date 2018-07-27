class DebugHelper

  class RegexpHandler < Handler

    def calls_for_instance
      [
          [:to_s],
          [:casefold?],
          [:named_captures],
          [:encoding],
          [:fixed_encoding?],
      ]
    end

  end
end