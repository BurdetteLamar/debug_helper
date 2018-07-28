class DebugHelper

  class StructHandler < EachPairHandler

    def calls_for_instance
      [
          [:size],
      ]
    end

    def show
      self.pair_names = %w/Member Name Value/
      super
    end

  end

end