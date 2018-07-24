class DebugHelper

  class StringHandler < Handler

    def calls_for_instance
      [
          [:to_s],
          [:size],
          [:encoding],
          [:ascii_only?],
          [:bytesize],
      ]
    end

  end

end