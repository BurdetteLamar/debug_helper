require 'diff-lcs'
require 'tempfile'
require 'yaml'

require "test_helper"

TEST_DIR_PATH = File.dirname(__FILE__)

class DebugHelperTest < Minitest::Test

  include DebugHelper::Putd

  def test_version
    refute_nil ::DebugHelper::VERSION
  end

  MyStruct = Struct.new(:foo, :bar, :baz)

  def test_show_object

    array_self_referencing = []
    array_self_referencing.push(array_self_referencing)

    array_circular_0 = []
    array_circular_1 = []
    array_circular_0.push(array_circular_1)
    array_circular_1.push(array_circular_0)

    hash_self_referencing_key = {}
    hash_self_referencing_key.store(hash_self_referencing_key, 0)

    hash_self_referencing_value = {}
    hash_self_referencing_value.store(:a, hash_self_referencing_value)

    hash_circular_key_0 = {}
    hash_circular_key_1 = {}
    hash_circular_key_0.store(hash_circular_key_1, 0)
    hash_circular_key_0.store(hash_circular_key_0, 0)

    hash_circular_value_0 = {}
    hash_circular_value_1 = {}
    hash_circular_value_0.store(:a, hash_circular_key_1)
    hash_circular_value_0.store(:b, hash_circular_key_0)

    string_multiline = <<EOT
foobar
snafu
janfu
EOT

    struct = MyStruct.new(0, 1, 2)

    struct_self_referencing = MyStruct.new(0, 1, 2)
    struct_self_referencing.foo = struct_self_referencing

    struct_circular_0 = MyStruct.new(0, 1, 2)
    struct_circular_1 = MyStruct.new(0, 1, 2)
    struct_circular_0.foo = struct_circular_1
    struct_circular_1.bar = struct_circular_0

    {
        :test_array => [14, 22],
        :test_array_empty => [],
        :test_array_mixed_values => [14, 'foo', [0, 1], {:a => 1, :b => 1}, true, nil],
        :test_array_self_referencing => array_self_referencing,
        :test_array_circular => array_circular_0,

        :test_hash => {:a => 14, :b => 22},
        :test_hash_empty => {},
        :test_hash_mixed_keys => {14 => 0, :a => 1, 'foobar' => 2},
        :test_hash_mixed_values => {:a => 0, :b => '0', :c => nil},
        :test_hash_self_referencing_key => hash_self_referencing_key,
        :test_hash_self_referencing_value => hash_self_referencing_value,
        :test_hash_circular_key => hash_circular_key_0,
        :test_hash_circular_value => hash_circular_value_0,

        :test_string => 'Lorem ipsum',
        :test_string_empty => '',
        :test_string_multiline => string_multiline,
        :test_string_iso_8859 => 'Lorem ipsum'.encode(Encoding::ISO_8859_1),

        :test_struct => struct,
        :test_struct_self_referencing => struct_self_referencing,
        :test_struct_circular => struct_circular_0,

        :test_symbol => :lorem_ipsum,

    }.each_pair do |name, obj|
      _test_show_object(self, obj, name)
    end

  end

  def test_depth
    {
        :test_depth_default => {
            :options => {},
            :obj => {
                :a => {
                    :b => {
                        :c => 'ok',
                    }
                }
            }
        },
        :test_depth_prune => {
            :options => {},
            :obj => {
                :a => {
                    :b => {
                        :c => {
                            :d => 'not ok'
                        }
                    }
                }
            }
        },
        :test_depth_1 => {
            :options => {:depth => 1},
            :obj => {
                :a => {
                    :b => {
                        :c => 'not ok',
                    }
                }
            }
        }
    }.each_pair do |name, h|
      options = h[:options]
      obj = h[:obj]
      _test_show_object(self, obj, name, options)
    end
  end

  def _test_show(test, method, obj, name, options = {})
    expected_file_path = File.join(
        TEST_DIR_PATH,
        'show',
        'expected',
        "#{name.to_s}.txt",
    )
    actual_file_path = File.join(
        TEST_DIR_PATH,
        'show',
        'actual',
        "#{name.to_s}.txt",
    )
    yield expected_file_path, actual_file_path
    diffs = DebugHelperTest.diff_files(expected_file_path, actual_file_path)
    message = "Test for #{method} with item '#{name}' failed"
    test.assert_empty(diffs, message)
  end

  def _test_show_object(test, obj, name, options = {})
    _test_show(test, :show, obj, name, options) do |expected_file_path, actual_file_path|
      DebugHelperTest.write_stdout(actual_file_path) do
        DebugHelper.send(:show, obj, name, options)
      end
    end
    _test_show(test, :putd, obj, name, options) do |expected_file_path, actual_file_path|
      DebugHelperTest.write_stdout(actual_file_path) do
        putd(obj, name, options)
      end
    end
  end

  def test_show_file_closed
    def clean_file(actual_file_path, temp_file_path)
      yaml = YAML.load_file(actual_file_path)
      top_key = yaml.keys.first
      values = yaml.fetch(top_key)
      # Path is volatile.
      path = values.delete('path')
      assert_equal(temp_file_path, path)
      # Times are volatile.
      %w/
          atime
          ctime
          mtime
        /.each do |key|
        value = values.delete(key)
        assert_instance_of(Time, value)
      end
      yaml.store(top_key, values)
      File.write(actual_file_path, YAML.dump(yaml))
    end
    name = 'test_file_closed'
    Dir.mktmpdir do |temp_dir|
      temp_file_name = 't.tmp'
      temp_file_path = File.join(temp_dir, temp_file_name)
      temp_file = File.open(temp_file_path, 'w')
      temp_file.write('This is file content.')
      temp_file.close
      _test_show(self, :show, temp_file, name) do |expected_file_path,
          actual_file_path|
        DebugHelperTest.write_stdout(actual_file_path) do
          DebugHelper.send(:show, temp_file, name)
        end
        clean_file(actual_file_path, temp_file_path)
      end
      _test_show(self, :putd, temp_file, name) do |expected_file_path, actual_file_path|
        DebugHelperTest.write_stdout(actual_file_path) do
          putd(temp_file, name)
        end
        clean_file(actual_file_path, temp_file_path)
      end
      File.delete(temp_file_path)
    end
  end

  def zzz_test_show_file_open_r
    name = 'test_file_open_r'
    Dir.mktmpdir do |dir|
      file_path = File.join(dir, 't.tmp')
      file = File.open(file_path, 'w')
      file.write('This is file content.')
      file.close
      File.open(file_path, 'r') do |file|
        _test_show(self, :show, file, name) do |expected_file_path,
            actual_file_path|
          DebugHelperTest.write_stdout(actual_file_path) do
            DebugHelper.send(:show, file, name)
          end
        end
        _test_show(test, :putd, file, name) do |expected_file_path, actual_file_path|
          DebugHelperTest.write_stdout(actual_file_path) do
            putd(file, name)
          end
        end
      end
      file.unlink
      File.delete(file_path)
    end
  end

  def zzz_test_show_file_open_w
    name = 'test_file_open_w'
    Dir.mktmpdir do |dir|
      file_path = File.join(dir, 't.tmp')
      file = File.open(file_path, 'w')
      file.write('This is file content.')
      _test_show(self, :show, file, name) do |expected_file_path,
          actual_file_path|
        DebugHelperTest.write_stdout(actual_file_path) do
          DebugHelper.send(:show, file, name)
        end
      end
      _test_show(test, :putd, file, name) do |expected_file_path, actual_file_path|
        DebugHelperTest.write_stdout(actual_file_path) do
          putd(file, name)
        end
      end
      file.close
      file.unlink
      File.delete(file_path)
    end
  end

  def self.write_stdout(file_path)
    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    File.write(file_path, $stdout.string)
  ensure
    $stdout = old_stdout
  end

  def self.diff_files(expected_file_path, actual_file_path)
    diffs = nil
    File.open(expected_file_path) do |expected_file|
      expected_lines = expected_file.readlines
      File.open(actual_file_path) do |actual_file|
        actual_lines = actual_file.readlines
        diffs = Diff::LCS.diff(expected_lines, actual_lines)
      end
    end
    diffs
  end

end
