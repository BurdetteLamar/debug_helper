require 'debug_helper'

regexp = Regexp.new(/(?<a>.)(?<b>.)/)
DebugHelper.show(regexp, 'My regexp with named captures')
