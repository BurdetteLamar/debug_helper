class DebugHelper

  class FileHandler < Handler

    def calls_for_class
      path = obj.path
      [
          [:absolute_path, path],
          [:atime, path],
          [:ctime, path],
          [:executable?, path],
          [:exist?, path],
          [:ftype, path],
          [:mtime, path],
          [:path, path],
          [:pipe?, path],
          [:readable?, path],
          [:realpath, path],
          [:setgid?, path],
          [:setuid?, path],
          [:size, path],
          [:socket?, path],
          [:symlink?, path],
          [:writable?, path],
      ]
    end
  end

end