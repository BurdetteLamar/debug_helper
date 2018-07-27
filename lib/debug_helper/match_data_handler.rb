class DebugHelper

  class MatchDataHandler < Handler

    def calls_for_instance
      [
          [:size],
          [:regexp],
          [:captures],
          [:names],
      ]
    end
  end

end