require 'debug_helper'

class Foo

  def my_array
    %w/foo bar baz/
  end

  def my_hash
    {:a => 0, :b => 1}
  end

  def self.my_array
    %w/bat bam bad/
  end

  def self.my_hash
    {:c => 2, :d => 3}
  end

end
