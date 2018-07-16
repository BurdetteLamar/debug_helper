### Option ```depth```

This example shows how option ```depth``` affects output.

```show.rb```:
```ruby
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
```

The output shows output for various depths.

```show.yaml```:
```yaml
---
Array (size=2 message='Show depth 1'):
  Element 0: Fixnum 0
  Element 1: Array [1, [2, [3, [4]]]]
---
Array (size=2 message='Show depth 2'):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1: Array [2, [3, [4]]]
---
Array (size=2 message='Show depth 3'):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1:
        Array (size=2):
          Element 0: Fixnum 2
          Element 1: Array [3, [4]]
---
Array (size=2 message='Show depth 4'):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1:
        Array (size=2):
          Element 0: Fixnum 2
          Element 1:
            Array (size=2):
              Element 0: Fixnum 3
              Element 1: Array [4]
---
Array (size=2 message='Show depth 5'):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1:
        Array (size=2):
          Element 0: Fixnum 2
          Element 1:
            Array (size=2):
              Element 0: Fixnum 3
              Element 1:
                Array (size=1):
                  Element 0: Fixnum 4
```
