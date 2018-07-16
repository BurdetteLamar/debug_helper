class DebugHelper

  class HashHandler < EachPairHandler

    def show
      self.pair_names = %w/Pair Key Value/
      self.attrs = {
          :size => obj.size,
          :default => obj.default,
          :default_proc => obj.default_proc,
          :message => message,
      }
      super
    end

  end

end