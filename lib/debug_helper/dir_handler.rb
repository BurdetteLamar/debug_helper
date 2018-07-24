class DebugHelper

  class DirHandler < Handler

    def calls_for_instance
      [
          [:path],
      ]
    end

    def calls_for_class
      [
          [:entries, obj.path],
          [:exist?, obj.path],
      ]
    end

  end
end