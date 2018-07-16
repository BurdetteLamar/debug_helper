class DebugHelper

  class FileHandler < Handler

    def show
      content = {}
      # These are class methods.
      # Some of the corresponding instance methods
      # require that the file be open, so best to use the class method.
      {
          :absolute_path => [obj.path],
          :atime => [obj.path],
          :ctime => [obj.path],
          :executable? => [obj.path],
          :exist? => [obj.path],
          :ftype => [obj.path],
          :mtime => [obj.path],
          :path => [obj.path],
          :pipe? => [obj.path],
          :readable? => [obj.path],
          :realpath => [obj.path],
          :setgid? => [obj.path],
          :setuid? => [obj.path],
          :size => [obj.path],
          :socket? => [obj.path],
          :symlink? => [obj.path],
          :writable? => [obj.path],
      }.each_pair do |method, args|
        content.store(method.to_s, File.send(method, *args))
      end
      attrs = {
          :message => message,
      }
      debug_helper._show_item(obj.class.name, content, attrs, info)
    end
  end

end