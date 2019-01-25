class DebugHelper

  class MethodHandler < Handler

    def calls_for_instance
      [
          [:arity],
          [:inspect],
          [:name],
          [:original_name],
          [:owner],
          [:parameters],
          [:source_location],
          [:super_method],
      ]
    end

  end

end