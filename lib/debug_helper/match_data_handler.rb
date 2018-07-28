class DebugHelper

  class MatchDataHandler < Handler

    def calls_for_instance
      [
          [:size],
          [:regexp],
          [:to_a],
          [:captures],
          [:names],
      ]
    end

  end

end