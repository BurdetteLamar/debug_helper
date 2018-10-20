require 'debug_helper'

gem_file_path = `gem which debug_helper`.chomp
gem_dir_path = File.dirname(gem_file_path)
gem_file_name = File.basename(gem_file_path)
Dir.chdir(gem_dir_path) do
  file = File.new(gem_file_name)
  DebugHelper.show(file, 'Gem file')
end
