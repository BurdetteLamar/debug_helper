# Debug Helper

This helper assists in [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques), by printing (to ```stdout```) an analysis of a given object.

Classes closely supported:

- [Array](#array)
- [Hash](#hash)
- [Struct](#struct)
- [String](#string)
- [Symbol](#symbol)

Others:

- [Object](#object)

### Array

#### Simple Array

This example shows a simple array of integers.

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
Array (name='My simple array' size=3):
  Element 0: Fixnum 5
  Element 1: Fixnum 10
  Element 2: Fixnum 15
```

#### Mixed Array

This example shows an array of mixed values.

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
Array (name='My mixed array' size=3):
  Element 0: Fixnum 0
  Element 1:
    String (size=3 encoding=UTF-8 ascii_only=true bytesize=3):
    - one
  Element 2:
    Symbol (size=3 encoding=US-ASCII): :two
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
Array (name='My nested arrays' size=3):
  Element 0: Fixnum 0
  Element 1:
    Array (size=2):
      Element 0: Fixnum 1
      Element 1: Fixnum 2
  Element 2:
    Array (size=2):
      Element 0: Fixnum 3
      Element 1: Fixnum 4
```

#### Circular Arrays

This example shows arrays that make a circular reference.

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
Array (name='My circular arrays' size=1):
  Element 0:
    Array (size=1):
      Element 0: Array [[[...]]]
```
### Hash

#### Simple Hash

This example shows a simple hash.

```show.rb```:
```ruby
require 'debug_helper'

hash = {:a => 0, :b => 1, :c => 2}
DebugHelper.show(hash, 'My simple hash')
```

The output shows details of the hash.

```show.yaml```:
```yaml
---
Hash (size=3 name='My simple hash'):
  Pair 0:
    Key:
      Symbol (size=1 encoding=US-ASCII): :a
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1 encoding=US-ASCII): :b
    Value: Fixnum 1
  Pair 2:
    Key:
      Symbol (size=1 encoding=US-ASCII): :c
    Value: Fixnum 2
```

#### Mixed Hash

This example shows a hash of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

hash = {
    :a => 0,
    :b => 'one',
    :c => :two,
}
DebugHelper.show(hash, 'My mixed hash')
```

The output shows details of the hash.

```show.yaml```:
```yaml
---
Hash (size=3 name='My mixed hash'):
  Pair 0:
    Key:
      Symbol (size=1 encoding=US-ASCII): :a
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1 encoding=US-ASCII): :b
    Value:
      String (size=3 encoding=UTF-8 ascii_only=true bytesize=3):
      - one
  Pair 2:
    Key:
      Symbol (size=1 encoding=US-ASCII): :c
    Value:
      Symbol (size=3 encoding=US-ASCII): :two
```

#### Nested Hashes

This example shows nested hashes.

```show.rb```:
```ruby
require 'debug_helper'

hash = {
    :a => {
        :b => 0,
        :c => 1,
    }
}
DebugHelper.show(hash, 'My nested hash')
```

The output shows details of the hashes.

```show.yaml```:
```yaml
---
Hash (size=1 name='My nested hash'):
  Pair 0:
    Key:
      Symbol (size=1 encoding=US-ASCII): :a
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1 encoding=US-ASCII): :b
          Value: Fixnum 0
        Pair 1:
          Key:
            Symbol (size=1 encoding=US-ASCII): :c
          Value: Fixnum 1
```

#### Circular Hashes

This example shows hashes that make a circular reference.

```show.rb```:
```ruby
require 'debug_helper'

hash_0 = {}
hash_1 = {}
hash_0.store(:foo, hash_1)
hash_1.store(:bar, hash_0)
DebugHelper.show(hash_0, 'My circular hashes')
```

The output shows details of the hashes.

The circular reference is not followed.

```show.yaml```:
```yaml
---
Hash (size=1 name='My circular hashes'):
  Pair 0:
    Key:
      Symbol (size=3 encoding=US-ASCII): :foo
    Value:
      Hash (size=1):
        Pair 0:
          Key:
            Symbol (size=3 encoding=US-ASCII): :bar
          Value: Hash {:foo=>{:bar=>{...}}}
```
### Struct

#### Simple Struct

This example shows a simple struct.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct = MyStruct.new(0, 1, 2)
DebugHelper.show(struct, 'My simple struct')
```

The output shows details of the struct.

```show.yaml```:
```yaml
---
MyStruct (name='My simple struct' size=3):
  Member 0:
    Name: :a
    Value: Fixnum 0
  Member 1:
    Name: :b
    Value: Fixnum 1
  Member 2:
    Name: :c
    Value: Fixnum 2
```

#### Mixed Struct

This example shows a struct of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct = MyStruct.new(0, 'one', :two)
DebugHelper.show(struct, 'My mixed struct')
```

The output shows details of the struct.

```show.yaml```:
```yaml
---
MyStruct (name='My mixed struct' size=3):
  Member 0:
    Name: :a
    Value: Fixnum 0
  Member 1:
    Name: :b
    Value:
      String (size=3 encoding=UTF-8 ascii_only=true bytesize=3):
      - one
  Member 2:
    Name: :c
    Value:
      Symbol (size=3 encoding=US-ASCII): :two
```

#### Nested Structs

This example shows nested structs.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct_0 = MyStruct.new(0, 1, 2)
struct_1 = MyStruct.new(3, 4, 5)
struct_0.a = struct_1
DebugHelper.show(struct_0, 'My nested struct')
```

The output shows details of the structs.

```show.yaml```:
```yaml
---
MyStruct (name='My nested struct' size=3):
  Member 0:
    Name: :a
    Value:
      MyStruct (size=3):
        Member 0:
          Name: :a
          Value: Fixnum 3
        Member 1:
          Name: :b
          Value: Fixnum 4
        Member 2:
          Name: :c
          Value: Fixnum 5
  Member 1:
    Name: :b
    Value: Fixnum 1
  Member 2:
    Name: :c
    Value: Fixnum 2
```

#### Circular Structs

This example shows structs that make a circular reference.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct = Struct.new(:a, :b, :c)
struct_0 = MyStruct.new(0, 1, 2)
struct_1 = MyStruct.new(3, 4, 5)
struct_0.a = struct_1
struct_1.a = struct_0
DebugHelper.show(struct_0, 'My circular struct')
```

The output shows details of the structs.

The circular reference is not followed.

```show.yaml```:
```yaml
---
MyStruct (name='My circular struct' size=3):
  Member 0:
    Name: :a
    Value:
      MyStruct (size=3):
        Member 0:
          Name: :a
          Value: 'MyStruct #<struct MyStruct a=#<struct MyStruct a=#<struct MyStruct:...>,
            b=4, c=5>, b=1, c=2>'
        Member 1:
          Name: :b
          Value: Fixnum 4
        Member 2:
          Name: :c
          Value: Fixnum 5
  Member 1:
    Name: :b
    Value: Fixnum 1
  Member 2:
    Name: :c
    Value: Fixnum 2
```
### String

#### Simple String

This example shows a simple string.

```show.rb```:
```ruby
require 'debug_helper'

s = 'Lorem ipsum'
DebugHelper.show(s, 'My simple string')
```

The output shows details of the string.

```show.yaml```:
```yaml
---
String (name='My simple string' size=11 encoding=UTF-8 ascii_only=true bytesize=11):
- Lorem ipsum
```

#### Multiline String

This example shows a multiline string.

```show.rb```:
```ruby
require 'debug_helper'

s = <<EOT
Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
EOT
DebugHelper.show(s, 'My multiline string')
```

The output shows details of the string.

```show.yaml```:
```yaml
---
String (name='My multiline string' size=122 encoding=UTF-8 ascii_only=true bytesize=122):
- |
  Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
  sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
```
### Symbol

#### Simple Symbol

This example shows a simple symbol.

```show.rb```:
```ruby
require 'debug_helper'

DebugHelper.show(:lorem_ipsum, 'My symbol')
```

The output shows details of the symbol.

```show.yaml```:
```yaml
---
Symbol (name='My symbol' size=11 encoding=US-ASCII): :lorem_ipsum
```
### Object

#### DateTime

This example shows a datetime.

```show.rb```:
```ruby
require 'debug_helper'

datetime = DateTime.now
DebugHelper.show(datetime, 'My datetime')
```

The output shows details of the datetime.

```show.yaml```:
```yaml
--- DateTime (name='My datetime') 2018-06-28T09:46:21-05:00
...
```

#### Range

This example shows a range.

```show.rb```:
```ruby
require 'debug_helper'

range = Range.new(0, 9)
DebugHelper.show(range, 'My range')
```

The output shows details of the range.

```show.yaml```:
```yaml
--- Range (name='My range') 0..9
...
```

#### Regexp

This example shows a regexp.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new('foo')
DebugHelper.show(regexp, 'My regexp')
```

The output shows details of the regexp.

```show.yaml```:
```yaml
--- Regexp (name='My regexp') (?-mix:foo)
...
```
