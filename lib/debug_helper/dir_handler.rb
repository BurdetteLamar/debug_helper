class DebugHelper

  class DirHandler < Handler

    def show
      # Instance methods.
      [
          :path,
      ].each do |method|
        self.content.store(method.to_s, obj.send(method))
      end
      # Class methods.
      {
          :entries => [obj.path],
          :exist? => [obj.path],
      }.each_pair do |method, args|
        self.content.store(method.to_s, Dir.send(method, *args))
      end
      self.attrs = {
          :message => message,
      }
      show_item
    end

  end
end