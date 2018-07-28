class DebugHelper

  class OpenStructHandler < EachPairHandler

    def show
      self.pair_names = %w/Member Name Value/
      super
    end

    def each_pair?
      true
    end

  end

end