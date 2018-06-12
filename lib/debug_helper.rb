require 'debug_helper/version'

class DebugHelper

  # def self.puts(obj, label = obj.class)
  #   case
  #     when obj.kind_of?(Array)
  #     when obj.kind_of?(Hash)
  #     when obj.kind_of?(Range)
  #     when obj.kind_of?(Set)
  #     when obj.kind_of?(Struct)
  #     else
  #
  #   end
  # end

  def self.puts_hash(hash, label = hash.class.name)
    self.kind_of!(hash, Hash)
    lines = [
        "Label:  #{label}",
        "Count:  #{hash.size}",
    ]
    hash.to_a.each_with_index do |pair, i|
      key, value = *pair
      lines.push("  Pair #{i}:")
      lines.push("    Key (#{key.class.name}): #{key.inspect}")
      lines.push("    Value (#{value.class.name}): #{value.inspect}")
    end
    lines.push('')
    lines.join("\n")
    puts lines
    lines
  end

  def self.respond_to!(obj, method)
    unless obj.respond_to?(method)
      message = "Instance of #{obj.class.name} does not respond to :#{method}"
      raise ArgumentError.new(message)
    end
  end

  def self.kind_of!(obj, klass)
    unless obj.kind_of?(klass)
      message = "Instance of #{obj.class.name} is not a kind of #{klass}"
      raise ArgumentError.new(message)
    end
  end

end
