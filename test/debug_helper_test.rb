require 'diff-lcs'

require "test_helper"

TEST_DIR_PATH = File.dirname(__FILE__)

class DebugHelperTest < Minitest::Test

  def test_version
    refute_nil ::DebugHelper::VERSION
  end

  MyStruct = Struct.new(:other_struct)

  def test_show

    method = :show

    struct_0 = MyStruct.new(nil)
    struct_1 = MyStruct.new(nil)
    struct_2 = MyStruct.new(struct_0)
    # struct_0.other_struct = struct_1
    # struct_1.other_struct = struct_0

    {
        :test_hash => {:a => 14, :b => 22},
        :test_array => [14, 22],
        :test_string => 'Lorem ipsum',
        :test_symbol => :lorem_ipsum,
        :test_struct => struct_2,
    }.each_pair do |name, obj|
    actual_file_path = File.join(
        TEST_DIR_PATH,
        method.to_s,
        'actual',
        "#{name.to_s}.txt",
    )
    DebugHelperTest.write_stdout(actual_file_path) do
      DebugHelper.send(method, obj, name.to_s)
    end
    expected_file_path = File.join(
        TEST_DIR_PATH,
        method.to_s,
        'expected',
        "#{name.to_s}.txt",
    )
    diffs = DebugHelperTest.diff_files(expected_file_path, actual_file_path)
    message = "Test for :show with item '#{name}' failed"
    assert_empty(diffs, message)

    end
  end

  def zzz_test_show_hash

    method = :show
    test_dir_name = 'show_hash'
    {
        :empty => {},
        :string_values => {:a => 'a', :b => 'b'},
        :symbol_values => {:a => :a, :b => :b},
        :nil_values => {:a => nil, :b => nil},
        :int_keys => {0 => 'a', 1 => 'b'},
    }.each_pair do |name, hash|
      actual_file_path = File.join(
          TEST_DIR_PATH,
          test_dir_name,
          'actual',
          "#{name.to_s}.txt",
      )
      DebugHelperTest.write_stdout(actual_file_path) do
        DebugHelper.send(method, hash, label = name.to_s)
      end
      expected_file_path = File.join(
          TEST_DIR_PATH,
          test_dir_name,
          'expected',
          "#{name.to_s}.txt",
      )
      diffs = DebugHelperTest.diff_files(expected_file_path, actual_file_path)
      assert_empty(diffs)

    end

    # Test invalid objects.
    [
        'foo',
        nil,
        true,
        Object.new,
    ].each do |obj|
      e = assert_raises(ArgumentError) do
        DebugHelper.show_hash(obj, obj.class.name)
      end
      assert_equal("Instance of #{obj.class.name} is not a kind of Hash", e.message)
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
