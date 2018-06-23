# Debug Helper

This helper assists in [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques), by printing (to ```stdout```) an analysis of a given object.

Classes closely supported:

- [array](#array)
- [hash](#hash)
- [string](#string)
- [struct](#struct)
- [symbol](#symbol)

### Array

#### Simple Array

This example shows a simple array of integers.

This Ruby code passes a simple array and a name to the helper.

```show.rb```:
```ruby
require 'debug_helper'

ary = [5, 10, 15]
DebugHelper.show(ary, 'My simple array')
```

The output shows details of the array.

```show.yaml```:
```yaml
---
Array (size=3 name=My simple array):
  Element 0: 5 (Fixnum)
  Element 1: 10 (Fixnum)
  Element 2: 15 (Fixnum)
```

#### Mixed Array

This example shows an array of mixed values.

This Ruby code passes a simple array and a name to the helper.

```show.rb```:
```ruby
require 'debug_helper'

ary = [0, 'one', :two]
DebugHelper.show(ary, 'My mixed array')
```

The output shows details of the array.

```show.yaml```:
```yaml
---
Array (size=3 name=My mixed array):
  Element 0: 0 (Fixnum)
  Element 1:
    String (size=3 encoding=UTF-8):
    - one
  Element 2:
    Symbol (size=3): :two
```

#### Nested Arrays

This example shows nested arrays.

```show.rb```:
```ruby
require 'debug_helper'

ary = [0, [1, 2], [3, 4]]
DebugHelper.show(ary, 'My nested arrays')
```

The output shows details of the arrays.

```show.yaml```:
```yaml
---
Array (size=3 name=My nested arrays):
  Element 0: 0 (Fixnum)
  Element 1:
    Array (size=2):
      Element 0: 1 (Fixnum)
      Element 1: 2 (Fixnum)
  Element 2:
    Array (size=2):
      Element 0: 3 (Fixnum)
      Element 1: 4 (Fixnum)
```

#### Circular Arrays

This example shows arrays that make circular references.

```show.rb```:
```ruby
require 'debug_helper'

ary_0 = []
ary_1 = []
ary_0.push(ary_1)
ary_1.push(ary_0)
DebugHelper.show(ary_0, 'My circular arrays')
```

The output shows details of the arrays.

The circular reference is not followed.

```show.yaml```:
```yaml
---
Array (size=1 name=My circular arrays):
  Element 0:
    Array (size=1):
      Element 0: "[[[...]]] (Array)"
```
### Hash
### String
### Struct
### Symbol
