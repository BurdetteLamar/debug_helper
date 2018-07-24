class DebugHelper

  class EachPairHandler < Handler

    attr_accessor :pair_names

    def calls_for_instance
      [
          [:size],
      ]
    end

    def each_pair?
      true
    end

  end

end