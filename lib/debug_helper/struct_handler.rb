class DebugHelper

  class StructHandler < EachPairHandler

    def show
      self.pair_names = %w/Member Name Value/
      self.attrs = {
          :size => obj.size,
          :message => message,
      }
      super
    end

  end

end