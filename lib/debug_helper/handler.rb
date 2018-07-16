class DebugHelper

  class Handler

    attr_accessor :debug_helper, :obj, :message, :info

    def initialize(debug_helper, obj, message, info)
      self.debug_helper = debug_helper
      self.obj = obj
      self.message = message
      self.info = info
    end

  end

end