require 'debug_helper'

s = <<EOT
Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
EOT
DebugHelper.show(s, 'My multiline string')
