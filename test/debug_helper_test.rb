require 'diff-lcs'

require "test_helper"

TEST_DIR_PATH = File.dirname(__FILE__)

class DebugHelperTest < Minitest::Test

  def test_version
    refute_nil ::DebugHelper::VERSION
  end

  MyStruct = Struct.new(:foo, :bar, :baz)

  def test_show

    method = :show

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

        # :test_potpourri => popourri,

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
    []
  end

end
