class DebugHelper

  class HashHandler < EachPairHandler

    def calls_for_instance
      [
          [:size],
          [:default],
          [:default_proc],
      ]
    end
    def show
      self.pair_names = %w/Pair Key Value/
      super
    end

  end

end