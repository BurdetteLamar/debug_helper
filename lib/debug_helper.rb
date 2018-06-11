require 'debug_helper/version'

class DebugHelper

  def self.respond_to!(obj, method)
    unless obj.respond_to?(method)
      message = "Instance of #{obj.class.name} does not respond to :#{method}"
      raise ArgumentError.new(message)
    end
  end

  def self.puts_each_pair(obj, label = obj.class.name)
    self.respond_to!(obj, :each_pair)
    lines = [
        "Label:  #{label}",
        "Count:  #{obj.size}",
    ]
    # Don't assume that we have :each_with_index.
    i = 0
    obj.each_pair do |key, value|
      lines.push("  Pair #{i}:")
      lines.push("    Key (#{key.class.name}): #{key.inspect}")
      lines.push("    Value (#{value.class.name}): #{value.inspect}")
      i += 1
    end
    lines.push('')
    lines.join("\n")
    puts lines
    lines
  end
end
