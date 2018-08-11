require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_instance
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

    def calls_for_class
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

  end

end
