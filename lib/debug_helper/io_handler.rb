class DebugHelper

  class IOHandler < Handler

    def calls_for_instance
      [
          [:autoclose?],
          [:binmode?],
          [:closed?],
          [:tty?],
      ]
    end
  end

end