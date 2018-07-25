class DebugHelper

  class ExceptionHandler < Handler

    def calls_for_instance
      [
          [:message],
          [:cause],
          [:backtrace],
      ]
    end
  end

end