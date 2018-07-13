#### Depth

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
(0..5).each do |depth|
  message = "Show depth #{depth}"
  DebugHelper.show(ary, message, {:depth => depth})
end
```

The output shows output for various depths.

```show.yaml```:
```yaml
--- Array (message='Show depth 0') [0, [1, [2, [3, [4]]]]]
...
---
Array (message='Show depth 1' size=2):
  Element 0: Fixnum 0
  Element 1: Array [1, [2, [3, [4]]]]
---
Array (message='Show depth 2' size=2):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1: Array [2, [3, [4]]]
---
Array (message='Show depth 3' size=2):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1:
        Array (size=2):
          Element 0: Fixnum 2
          Element 1: Array [3, [4]]
---
Array (message='Show depth 4' size=2):
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
Array (message='Show depth 5' size=2):
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
