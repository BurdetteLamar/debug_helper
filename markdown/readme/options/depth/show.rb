require 'debug_helper'

ary = [0,
       [1,
        [2,
         [3,
          [4]
         ]
        ]
       ]
]
(1..5).each do |depth|
  message = "Show depth #{depth}"
  DebugHelper.show(ary, message, {:depth => depth})
end
