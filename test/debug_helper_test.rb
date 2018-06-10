require "test_helper"

class DebugHelperTest < Minitest::Test

  def test_version
    refute_nil ::DebugHelper::VERSION
  end

end
