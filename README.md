# Debug Helper

## New in Version 1.7

Classes analyzed:

- [File](#file)
- [Set](#set)

Options:

- [```depth```](#option-depth)

## About Debug Helper

If (like me), your debugging style is [printf debugging](https://en.wikipedia.org/wiki/Debugging#Techniques), you will have shoved this into your code many times:

```show_hash.rb```:
```ruby
hash.each_pair do |key, value|
  p [key, value]
end
```

And this:

```show_array.rb```:
```ruby
array.each_with_index do |item, i|
  p [i, item]
end
```

This helper assists in debugging by printing an analysis of a given object.  The analysis is a ```yaml``` structure, and is written to ```stdout```.

For certain classes (see below), the analysis is very detailed.

For the collection classes ```Array```, ```Hash```, ```Struct```, ```Set```, and ```OpenStruct```, the analysis is also recursive;  that is, the collection's values are themselves analyzed.

You can control the depth of recursion using option ```depth```.  See [Options](#options).

Classes treated in detail:

- [Array](#array)
- [Hash](#hash)
- [Struct](#struct)
- [String](#string)
- [Symbol](#symbol)
- [File](#file)
- [Dir](#dir)
- [Range](#range)
- [Set](#set)
- [OpenStruct](#openstruct)

Others are treated as:

- [Object](#object)

## Class Method or Module Method?

Most examples in this documentation show use of the class method:

```ruby
require 'debug_helper'
DebugHelper.show(obj, message)
```

You can also choose to use the module method, ```putd``` (Thanks, [palkan](https://www.reddit.com/user/palkan)!), which looks a lot like ```puts```.

```ruby
require 'debug_helper'
include DebugHelper::Putd
putd obj, message
```

Just be sure to ```include DebugHelper::Putd```.

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
Array (size=3 message='My simple array'):
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
Array (size=3 message='My mixed array'):
  Element 0: Fixnum 0
  Element 1:
    String (size=3):
      to_s: one
      encoding: !ruby/encoding UTF-8
      ascii_only?: true
      bytesize: 3
  Element 2:
    Symbol (size=3):
      to_s: two
      encoding: !ruby/encoding US-ASCII
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
Array (size=3 message='My nested arrays'):
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
Array (size=1 message='My circular arrays'):
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
Hash (size=3 message='My simple hash'):
  Pair 0:
    Key:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Pair 2:
    Key:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
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
Hash (size=3 message='My mixed hash'):
  Pair 0:
    Key:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Pair 1:
    Key:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      String (size=3):
        to_s: one
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Pair 2:
    Key:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol (size=3):
        to_s: two
        encoding: !ruby/encoding US-ASCII
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
    },
    :d => {
        :e => 2,
        :f => 3,
    }
}
DebugHelper.show(hash, 'My nested hash')
```

The output shows details of the hashes.

```show.yaml```:
```yaml
---
Hash (size=2 message='My nested hash'):
  Pair 0:
    Key:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1):
              to_s: b
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Pair 1:
          Key:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Pair 1:
    Key:
      Symbol (size=1):
        to_s: d
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash (size=2):
        Pair 0:
          Key:
            Symbol (size=1):
              to_s: e
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Pair 1:
          Key:
            Symbol (size=1):
              to_s: f
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
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
Hash (size=1 message='My circular hashes'):
  Pair 0:
    Key:
      Symbol (size=3):
        to_s: foo
        encoding: !ruby/encoding US-ASCII
    Value:
      Hash (size=1):
        Pair 0:
          Key:
            Symbol (size=3):
              to_s: bar
              encoding: !ruby/encoding US-ASCII
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
MyStruct (size=3 message='My simple struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
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
MyStruct (size=3 message='My mixed struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      String (size=3):
        to_s: one
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol (size=3):
        to_s: two
        encoding: !ruby/encoding US-ASCII
```

#### Nested Structs

This example shows nested structs.

```show.rb```:
```ruby
require 'debug_helper'

MyStruct_0 = Struct.new(:a, :b)
MyStruct_1 = Struct.new(:c, :d)
struct_1a = MyStruct_1.new(2, 3)
struct_1b = MyStruct_1.new(4, 5)
struct_0 = MyStruct_0.new(struct_1a, struct_1b)
DebugHelper.show(struct_0, 'My nested struct')
```

The output shows details of the structs.

```show.yaml```:
```yaml
---
MyStruct_0 (size=2 message='My nested struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1 (size=2):
        Member 0:
          Name:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Member 1:
          Name:
            Symbol (size=1):
              to_s: d
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1 (size=2):
        Member 0:
          Name:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 4
        Member 1:
          Name:
            Symbol (size=1):
              to_s: d
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 5
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
MyStruct (size=3 message='My circular struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct (size=3):
        Member 0:
          Name:
            Symbol (size=1):
              to_s: a
              encoding: !ruby/encoding US-ASCII
          Value: 'MyStruct #<struct MyStruct a=#<struct MyStruct a=#<struct MyStruct:...>,
            b=4, c=5>, b=1, c=2>'
        Member 1:
          Name:
            Symbol (size=1):
              to_s: b
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 4
        Member 2:
          Name:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 5
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
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
String (size=11 message='My simple string'):
  to_s: Lorem ipsum
  encoding: !ruby/encoding UTF-8
  ascii_only?: true
  bytesize: 11
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
String (size=122 message='My multiline string'):
  to_s: |
    Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
    sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
  encoding: !ruby/encoding UTF-8
  ascii_only?: true
  bytesize: 122
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
Symbol (size=11 message='My symbol'):
  to_s: lorem_ipsum
  encoding: !ruby/encoding US-ASCII
```
### File

#### Simple File

This example shows a simple file.

```show.rb```:
```ruby
require 'debug_helper'

file = File.new(__FILE__)
DebugHelper.show(file, 'My simple file')
```

The output shows details of the file.

```show.yaml```:
```yaml
---
File (message='My simple file'):
  absolute_path: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  atime: 2018-07-14 12:45:32.000000000 -05:00
  ctime: 2018-07-14 12:45:32.000000000 -05:00
  executable?: false
  exist?: true
  ftype: file
  mtime: 2018-07-14 12:45:32.000000000 -05:00
  path: show.rb
  pipe?: false
  readable?: true
  realpath: C:/Users/Burdette/Documents/GitHub/debug_helper/markdown/readme/classes/file/simple/show.rb
  setgid?: false
  setuid?: false
  size: 95
  socket?: false
  symlink?: false
  writable?: true
```
### Dir

#### Simple Dir

This example shows a simple ```Dir  ``.

```show.rb```:
```ruby
require 'debug_helper'

dir = Dir.new(File.dirname(__FILE__))
DebugHelper.show(dir, 'My simple dir')
```

The output shows details of the ```Dir```.

```show.yaml```:
```yaml
---
Dir (message='My simple dir'):
  path: "."
  entries:
  - "."
  - ".."
  - show.md
  - show.rb
  - show.yaml
  - template.md
  exist?: true
```
### Range

#### Simple Array

This example shows a ```Range``` that includes its end value.

```show.rb```:
```ruby
require 'debug_helper'

range = (0..4)
DebugHelper.show(range, 'My inclusive range')
```

The output shows details of the ```Range```.

```show.yaml```:
```yaml
---
Range (message='My inclusive range'):
  first: 0
  last: 4
  exclude_end?: false
```

#### Simple Array

This example shows a ```Range``` that excludes its end value.

```show.rb```:
```ruby
require 'debug_helper'

range = (0...4)
DebugHelper.show(range, 'My exclusive range')
```

The output shows details of the ```Range```.

```show.yaml```:
```yaml
---
Range (message='My exclusive range'):
  first: 0
  last: 4
  exclude_end?: true
```
### Set

#### Simple Set

This example shows a simple set of integers.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set = Set.new([5, 10, 15])
DebugHelper.show(set, 'My simple set')
```

The output shows details of the set.

```show.yaml```:
```yaml
---
Set (size=3 message='My simple set'):
  Element 0: Fixnum 5
  Element 1: Fixnum 10
  Element 2: Fixnum 15
```

#### Mixed Set

This example shows a set of mixed values.

```show.rb```:
```ruby
require 'debug_helper'

require 'set'

set = Set.new([0, 'one', :two])
DebugHelper.show(set, 'My mixed set')
```

The output shows details of the set.

```show.yaml```:
```yaml
---
Set (size=3 message='My mixed set'):
  Element 0: Fixnum 0
  Element 1:
    String (size=3):
      to_s: one
      encoding: !ruby/encoding UTF-8
      ascii_only?: true
      bytesize: 3
  Element 2:
    Symbol (size=3):
      to_s: two
      encoding: !ruby/encoding US-ASCII
```

#### Nested Sets

This example shows nested sets.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set = Set.new(
    [0,
     Set.new([1, 2]),
     Set.new([3, 4]),
     ])
DebugHelper.show(set, 'My nested sets')
```

The output shows details of the sets.

```show.yaml```:
```yaml
---
Set (size=3 message='My nested sets'):
  Element 0: Fixnum 0
  Element 1:
    Set (size=2):
      Element 0: Fixnum 1
      Element 1: Fixnum 2
  Element 2:
    Set (size=2):
      Element 0: Fixnum 3
      Element 1: Fixnum 4
```

#### Circular Sets

This example shows sets that make a circular reference.

```show.rb```:
```ruby
require 'set'

require 'debug_helper'

set_0 = Set.new([])
set_1 = Set.new([])
set_0.add(set_1)
set_1.add(set_0)
DebugHelper.show(set_0, 'My circular sets')
```

The output shows details of the sets.

The circular reference is not followed.

```show.yaml```:
```yaml
---
Set (size=1 message='My circular sets'):
  Element 0:
    Set (size=1):
      Element 0: 'Set #<Set: {#<Set: {#<Set: {...}>}>}>'
```
### OpenStruct

#### Simple OpenStruct

This example shows a simple open struct.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(:a => 0, :b => 1, :c => 2)
DebugHelper.show(ostruct, 'My simple struct')
```

The output shows details of the open struct.

```show.yaml```:
```yaml
---
OpenStruct (message='My simple struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 1
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 2
```

#### Mixed OpenStruct

This example shows an open struct of mixed values.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(:a => 0, :b => 'one', :c => :two)
DebugHelper.show(ostruct, 'My mixed open struct')
```

The output shows details of the open struct.

```show.yaml```:
```yaml
---
OpenStruct (message='My mixed open struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value: Fixnum 0
  Member 1:
    Name:
      Symbol (size=1):
        to_s: b
        encoding: !ruby/encoding US-ASCII
    Value:
      String (size=3):
        to_s: one
        encoding: !ruby/encoding UTF-8
        ascii_only?: true
        bytesize: 3
  Member 2:
    Name:
      Symbol (size=1):
        to_s: c
        encoding: !ruby/encoding US-ASCII
    Value:
      Symbol (size=3):
        to_s: two
        encoding: !ruby/encoding US-ASCII
```

#### Nested OpenStructs

This example shows nested open structs.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(
                        :a => OpenStruct.new(
                                            :b => 0,
                                            :c => 1,
                        ),
                        :d => OpenStruct.new(
                                            :e => 2,
                                            :f => 3,
                        )
)
DebugHelper.show(ostruct, 'My nested struct')
```

The output shows details of the open structs.

```show.yaml```:
```yaml
---
OpenStruct (message='My nested struct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol (size=1):
              to_s: b
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 0
        Member 1:
          Name:
            Symbol (size=1):
              to_s: c
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 1
  Member 1:
    Name:
      Symbol (size=1):
        to_s: d
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol (size=1):
              to_s: e
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 2
        Member 1:
          Name:
            Symbol (size=1):
              to_s: f
              encoding: !ruby/encoding US-ASCII
          Value: Fixnum 3
```

#### Circular OpenStructs

This example shows open structs that make a circular reference.

```show.rb```:
```ruby
require 'ostruct'
require 'debug_helper'

ostruct_0 = OpenStruct.new
ostruct_1 = OpenStruct.new
ostruct_0.a = ostruct_1
ostruct_1.a = ostruct_0
DebugHelper.show(ostruct_0, 'My circular ostruct')
```

The output shows details of the open structs.

The circular reference is not followed.

```show.yaml```:
```yaml
---
OpenStruct (message='My circular ostruct'):
  Member 0:
    Name:
      Symbol (size=1):
        to_s: a
        encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol (size=1):
              to_s: a
              encoding: !ruby/encoding US-ASCII
          Value: 'OpenStruct #<OpenStruct a=#<OpenStruct a=#<OpenStruct ...>>>'
```
### Object

Classes not mentioned above are not analyzed, but are treated more simply.

A few examples are shown below.

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
--- 'DateTime (message=''My datetime'') #<DateTime: 2018-07-17T15:21:53-05:00 ((2458317j,73313s,357758000n),-18000s,2299161j)>'
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
---
Range (message='My range'):
  first: 0
  last: 9
  exclude_end?: false
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
--- Regexp (message='My regexp') /foo/
...
```

## Options

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
