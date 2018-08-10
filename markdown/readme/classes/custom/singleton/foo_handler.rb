require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_class
      [
          [:my_array],
          [:my_hash],
      ]
    end

  end

end
