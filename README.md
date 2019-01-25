# Debug Helper

[![Gem](https://img.shields.io/gem/v/debug_helper.svg?style=flat)](http://rubygems.org/gems/debug_helper "View this project in Rubygems")

## New in Version 2.1

- Handling for instances of class ```Method```.  See [Method](#method).

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
- [Dir](#dir)
- [Exception](#exception)
- [File](#file)
- [Hash](#hash)
- [IO](#io)
- [MatchData](#matchdata)
- [Method](#method)
- [OpenStruct](#openstruct)
- [Range](#range)
- [Regexp](#regexp)
- [Set](#set)
- [String](#string)
- [Struct](#struct)
- [Symbol](#symbol)

Others are treated as:

- [Object](#object)

But wait, there's more!  For your own classes, you can create your own handlers:

- [Custom](#custom)

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
Array (message='My simple array'):
  Array#size: 3
  Element 0: Integer 5
  Element 1: Integer 10
  Element 2: Integer 15
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
Array (message='My mixed array'):
  Array#size: 3
  Element 0: Integer 0
  Element 1:
    String:
      String#to_s: one
      String#size: 3
      String#encoding: !ruby/encoding UTF-8
      String#ascii_only?: true
      String#bytesize: 3
  Element 2:
    Symbol:
      Symbol#to_s: two
      Symbol#size: 3
      Symbol#encoding: !ruby/encoding US-ASCII
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
Array (message='My nested arrays'):
  Array#size: 3
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1: Integer 2
  Element 2:
    Array:
      Array#size: 2
      Element 0: Integer 3
      Element 1: Integer 4
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
Array (message='My circular arrays'):
  Array#size: 1
  Element 0:
    Array:
      Array#size: 1
      Element 0: Array [[[...]]]
```
### Dir

#### Simple Dir

This example shows a simple ```Dir```.

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
  Dir#path: "."
  Dir.entries("."):
  - "."
  - ".."
  - show.md
  - show.rb
  - show.yaml
  - template.md
  Dir.exist?("."): true
```
### Exception

#### Simple Exception

This example shows a simple ```Exception```.

```show.rb```:
```ruby
require 'debug_helper'

def foo
  exception = nil
  begin
    raise Exception.new('Boo!')
  rescue Exception => exception
    # Already saved.
  end
  DebugHelper.show(exception, 'My simple exception')
end

def bar
  foo
end

def baz
  bar
end

baz

```

The output shows details of the ```Exception```.

```show.yaml```:
```yaml
---
Exception (message='My simple exception'):
  Exception#message: Boo!
  Exception#cause: 
  Exception#backtrace:
  - show.rb:6:in `foo'
  - show.rb:14:in `bar'
  - show.rb:18:in `baz'
  - show.rb:21:in `<main>'
```
### File

#### Simple File

This example shows a simple file.

```show.rb```:
```ruby
require 'debug_helper'

gem_file_path = `gem which debug_helper`.chomp
gem_dir_path = File.dirname(gem_file_path)
gem_file_name = File.basename(gem_file_path)
Dir.chdir(gem_dir_path) do
  file = File.new(gem_file_name)
  DebugHelper.show(file, 'Gem file')
end
```

The output shows details of the file.

```show.yaml```:
```yaml
---
File (message='Gem file'):
  File.absolute_path("debug_helper.rb"): C:/Ruby25-x64/lib/ruby/gems/2.5.0/gems/debug_helper-2.0.0/lib/debug_helper.rb
  File.atime("debug_helper.rb"): 2019-01-25 15:43:42.740298400 -06:00
  File.ctime("debug_helper.rb"): 2019-01-25 15:43:42.740298400 -06:00
  File.executable?("debug_helper.rb"): false
  File.exist?("debug_helper.rb"): true
  File.ftype("debug_helper.rb"): file
  File.mtime("debug_helper.rb"): 2019-01-25 15:43:42.741296200 -06:00
  File.path("debug_helper.rb"): debug_helper.rb
  File.pipe?("debug_helper.rb"): false
  File.readable?("debug_helper.rb"): true
  File.realpath("debug_helper.rb"): C:/Ruby25-x64/lib/ruby/gems/2.5.0/gems/debug_helper-2.0.0/lib/debug_helper.rb
  File.setgid?("debug_helper.rb"): false
  File.setuid?("debug_helper.rb"): false
  File.size("debug_helper.rb"): 3701
  File.socket?("debug_helper.rb"): false
  File.symlink?("debug_helper.rb"): false
  File.writable?("debug_helper.rb"): true
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
Hash (message='My simple hash'):
  Hash#size: 3
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Pair 1:
    Key:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Pair 2:
    Key:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
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
Hash (message='My mixed hash'):
  Hash#size: 3
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Pair 1:
    Key:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      String:
        String#to_s: one
        String#size: 3
        String#encoding: !ruby/encoding UTF-8
        String#ascii_only?: true
        String#bytesize: 3
  Pair 2:
    Key:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        Symbol#to_s: two
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
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
Hash (message='My nested hash'):
  Hash#size: 2
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        Hash#size: 2
        Hash#default: 
        Hash#default_proc: 
        Pair 0:
          Key:
            Symbol:
              Symbol#to_s: b
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 0
        Pair 1:
          Key:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 1
  Pair 1:
    Key:
      Symbol:
        Symbol#to_s: d
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        Hash#size: 2
        Hash#default: 
        Hash#default_proc: 
        Pair 0:
          Key:
            Symbol:
              Symbol#to_s: e
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 2
        Pair 1:
          Key:
            Symbol:
              Symbol#to_s: f
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 3
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
Hash (message='My circular hashes'):
  Hash#size: 1
  Hash#default: 
  Hash#default_proc: 
  Pair 0:
    Key:
      Symbol:
        Symbol#to_s: foo
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Hash:
        Hash#size: 1
        Hash#default: 
        Hash#default_proc: 
        Pair 0:
          Key:
            Symbol:
              Symbol#to_s: bar
              Symbol#size: 3
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Hash {:foo=>{:bar=>{...}}}
```
### IO

#### Simple IO

This example shows a simple ```IO```.

```show.rb```:
```ruby
require 'debug_helper'

io = IO.new(IO.sysopen(__FILE__, 'r'), 'r')
DebugHelper.show(io, 'My simple io')
```

The output shows details of the ```IO```.

```show.yaml```:
```yaml
---
IO (message='My simple io'):
  IO#autoclose?: true
  IO#binmode?: false
  IO#closed?: false
  IO#tty?: false
```
### MatchData

#### Simple MatchData

This example shows a simple ```MatchData```.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /[a-z]/.match('abc')
DebugHelper.show(match_data, 'My simple MatchData')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My simple MatchData'):
  MatchData#size: 1
  MatchData#regexp: !ruby/regexp /[a-z]/
  MatchData#to_a:
  - a
  MatchData#captures: []
  MatchData#names: []
```

#### Multiple Captures

This example shows a ```MatchData``` with multiple captures.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /(.)(.)(\d+)(\d)/.match('THX1138.')
DebugHelper.show(match_data, 'My MatchData with named captures')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My MatchData with named captures'):
  MatchData#size: 5
  MatchData#regexp: !ruby/regexp /(.)(.)(\d+)(\d)/
  MatchData#to_a:
  - HX1138
  - H
  - X
  - '113'
  - '8'
  MatchData#captures:
  - H
  - X
  - '113'
  - '8'
  MatchData#names: []
```

#### Named Captures

This example shows a ```MatchData``` with named captures.

```show.rb```:
```ruby
require 'debug_helper'

match_data = /(?<x>.)(?<y>.)?/.match("a")
DebugHelper.show(match_data, 'My MatchData with named captures')
```

The output shows details of the ```MatchData```.

```show.yaml```:
```yaml
---
MatchData (message='My MatchData with named captures'):
  MatchData#size: 3
  MatchData#regexp: !ruby/regexp /(?<x>.)(?<y>.)?/
  MatchData#to_a:
  - a
  - a
  - 
  MatchData#captures:
  - a
  - 
  MatchData#names:
  - x
  - y
```
### Method

#### Simple Method

This example shows a simple ```Method```.

```show.rb```:
```ruby
require 'debug_helper'

m = method(:puts)
DebugHelper.show(m, 'My simple Method')
```

The output shows details of the ```Method```.

```show.yaml```:
```yaml
---
Method (message='My simple Method'):
  Method#arity: -1
  Method#inspect: "#<Method: main.puts>"
  Method#name: :puts
  Method#original_name: :puts
  Method#owner: !ruby/module 'Kernel'
  Method#parameters:
  - - :rest
  Method#source_location: 
  Method#super_method: 
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
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
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
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      String:
        String#to_s: one
        String#size: 3
        String#encoding: !ruby/encoding UTF-8
        String#ascii_only?: true
        String#bytesize: 3
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        Symbol#to_s: two
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
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
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: b
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 0
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 1
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: d
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: e
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 2
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: f
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 3
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
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      OpenStruct:
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: a
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: 'OpenStruct #<OpenStruct a=#<OpenStruct a=#<OpenStruct ...>>>'
```
### Range

#### Inclusive Range

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
  Range#first: 0
  Range#last: 4
  Range#exclude_end?: false
```

#### Exclusive Range

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
  Range#first: 0
  Range#last: 4
  Range#exclude_end?: true
```
### Regexp

#### Simple Regexp

This example shows a simple ```Regexp```.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new(/\w+/)
DebugHelper.show(regexp, 'My simple regexp')
```

The output shows details of the ```Regexp```.

```show.yaml```:
```yaml
---
Regexp (message='My simple regexp'):
  Regexp#to_s: "(?-mix:\\w+)"
  Regexp#casefold?: false
  Regexp#named_captures: {}
  Regexp#encoding: !ruby/encoding US-ASCII
  Regexp#fixed_encoding?: false
```

#### Named Captures

This example shows a ```Regexp``` with named captures.

```show.rb```:
```ruby
require 'debug_helper'

regexp = Regexp.new(/(?<a>.)(?<b>.)/)
DebugHelper.show(regexp, 'My regexp with named captures')
```

The output shows details of the ```Regexp```.

```show.yaml```:
```yaml
---
Regexp (message='My regexp with named captures'):
  Regexp#to_s: "(?-mix:(?<a>.)(?<b>.))"
  Regexp#casefold?: false
  Regexp#named_captures:
    a:
    - 1
    b:
    - 2
  Regexp#encoding: !ruby/encoding US-ASCII
  Regexp#fixed_encoding?: false
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
Set (message='My simple set'):
  Set#size: 3
  Element 0: Integer 5
  Element 1: Integer 10
  Element 2: Integer 15
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
Set (message='My mixed set'):
  Set#size: 3
  Element 0: Integer 0
  Element 1:
    String:
      String#to_s: one
      String#size: 3
      String#encoding: !ruby/encoding UTF-8
      String#ascii_only?: true
      String#bytesize: 3
  Element 2:
    Symbol:
      Symbol#to_s: two
      Symbol#size: 3
      Symbol#encoding: !ruby/encoding US-ASCII
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
Set (message='My nested sets'):
  Set#size: 3
  Element 0: Integer 0
  Element 1:
    Set:
      Set#size: 2
      Element 0: Integer 1
      Element 1: Integer 2
  Element 2:
    Set:
      Set#size: 2
      Element 0: Integer 3
      Element 1: Integer 4
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
Set (message='My circular sets'):
  Set#size: 1
  Element 0:
    Set:
      Set#size: 1
      Element 0: 'Set #<Set: {#<Set: {#<Set: {...}>}>}>'
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
String (message='My simple string'):
  String#to_s: Lorem ipsum
  String#size: 11
  String#encoding: !ruby/encoding UTF-8
  String#ascii_only?: true
  String#bytesize: 11
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
String (message='My multiline string'):
  String#to_s: |
    Lorem Ipsum dolor sit amet,consectetur adipisicing elit,
    sed doeiusmod tempor incididunt ut laboreet dolore magna aliqua.
  String#size: 122
  String#encoding: !ruby/encoding UTF-8
  String#ascii_only?: true
  String#bytesize: 122
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
MyStruct (message='My simple struct'):
  MyStruct#size: 3
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
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
MyStruct (message='My mixed struct'):
  MyStruct#size: 3
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 0
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      String:
        String#to_s: one
        String#size: 3
        String#encoding: !ruby/encoding UTF-8
        String#ascii_only?: true
        String#bytesize: 3
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      Symbol:
        Symbol#to_s: two
        Symbol#size: 3
        Symbol#encoding: !ruby/encoding US-ASCII
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
MyStruct_0 (message='My nested struct'):
  MyStruct_0#size: 2
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1:
        MyStruct_1#size: 2
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 2
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: d
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 3
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct_1:
        MyStruct_1#size: 2
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 4
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: d
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 5
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
MyStruct (message='My circular struct'):
  MyStruct#size: 3
  Member 0:
    Name:
      Symbol:
        Symbol#to_s: a
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value:
      MyStruct:
        MyStruct#size: 3
        Member 0:
          Name:
            Symbol:
              Symbol#to_s: a
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: 'MyStruct #<struct MyStruct a=#<struct MyStruct a=#<struct MyStruct:...>,
            b=4, c=5>, b=1, c=2>'
        Member 1:
          Name:
            Symbol:
              Symbol#to_s: b
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 4
        Member 2:
          Name:
            Symbol:
              Symbol#to_s: c
              Symbol#size: 1
              Symbol#encoding: !ruby/encoding US-ASCII
          Value: Integer 5
  Member 1:
    Name:
      Symbol:
        Symbol#to_s: b
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 1
  Member 2:
    Name:
      Symbol:
        Symbol#to_s: c
        Symbol#size: 1
        Symbol#encoding: !ruby/encoding US-ASCII
    Value: Integer 2
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
Symbol (message='My symbol'):
  Symbol#to_s: lorem_ipsum
  Symbol#size: 11
  Symbol#encoding: !ruby/encoding US-ASCII
```
### Object

Classes not mentioned above are not analyzed, but are treated more simply.

#### Unanalyzed Object

This example shows an object that will not be analyzed.

```show.rb```:
```ruby
require 'debug_helper'

class MyClass
  def inspect
    'My class inspection'
  end
end
DebugHelper.show(MyClass.new, 'My class')
```

The output shows details of the object.

```show.yaml```:
```yaml
--- MyClass (message='My class') My class inspection
```
### Custom

You can create custom handlers for your own classes.

#### Instance Methods

This example shows a custom handler that explicates via instance methods.

Here's a class ```Foo``` that has some instance methods:
 
```foo.rb```:
```ruby
require 'debug_helper'

class Foo

  def my_array
    %w/foo bar baz/
  end

  def my_hash
    {:a => 0, :b => 1}
  end

end
```

Here's its custom debug handler class ```FooHandler```.  The array returned by method ```calls_for_instance``` tells the base class ```Handler``` which methods to call for the explication, and what arguments to pass, if any.

```foo_handler.rb```:
```ruby
require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_instance
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

  end

end
```

Here's a program that uses the custom handler.

```show.rb```:
```ruby
require 'debug_helper'
require_relative 'foo'
require_relative 'foo_handler'

DebugHelper.show(Foo.new, 'My class Foo')
```

The output shows details of the object.

```show.yaml```:
```yaml
---
Foo (message='My class Foo'):
  Foo#my_array:
  - foo
  - bar
  - baz
  Foo#my_hash:
    :a: 0
    :b: 1
  Foo#respond_to?(:your_array): false
  Foo#respond_to?(:your_hash): false
```

#### Singleton Methods

This example shows a custom handler that explicates via singleton methods.

Here's a class ```Foo``` that has some singleton methods:
 
```foo.rb```:
```ruby
require 'debug_helper'

class Foo

  def self.my_array
    %w/bat bam bad/
  end

  def self.my_hash
    {:c => 2, :d => 3}
  end

end
```

Here's its custom debug handler class ```FooHandler```.  The array returned in method ```calls_for_class``` tells the base class ```Handler``` which methods to call for the explication.

```foo_handler.rb```:
```ruby
require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_class
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

  end

end
```

Here's a program that uses the custom handler.

```show.rb```:
```ruby
require 'debug_helper'
require_relative 'foo'
require_relative 'foo_handler'

DebugHelper.show(Foo.new, 'My class Foo')
```

The output shows details of the object.

```show.yaml```:
```yaml
---
Foo (message='My class Foo'):
  Foo.my_array:
  - bat
  - bam
  - bad
  Foo.my_hash:
    :c: 2
    :d: 3
  Foo.respond_to?(:your_array): false
  Foo.respond_to?(:your_hash): false
```

#### Instance and Singleton Methods

This example shows a custom handler that explicates via both kinds of methods.

Here's a class ```Foo``` that has instance methods and singleton methods:
 
```foo.rb```:
```ruby
require 'debug_helper'

class Foo

  def my_array
    %w/foo bar baz/
  end

  def my_hash
    {:a => 0, :b => 1}
  end

  def self.my_array
    %w/bat bam bad/
  end

  def self.my_hash
    {:c => 2, :d => 3}
  end

end
```

Here's its custom debug handler class ```FooHandler```.

```foo_handler.rb```:
```ruby
require 'debug_helper'

class DebugHelper

  class FooHandler < Handler

    def calls_for_instance
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

    def calls_for_class
      [
          [:my_array],
          [:my_hash],
          [:respond_to?, :your_array],
          [:respond_to?, :your_hash],
      ]
    end

  end

end
```

Here's a program that uses the custom handler.

```show.rb```:
```ruby
require 'debug_helper'
require_relative 'foo'
require_relative 'foo_handler'

DebugHelper.show(Foo.new, 'My class Foo')
```

The output shows details of the object.

```show.yaml```:
```yaml
---
Foo (message='My class Foo'):
  Foo#my_array:
  - foo
  - bar
  - baz
  Foo#my_hash:
    :a: 0
    :b: 1
  Foo#respond_to?(:your_array): false
  Foo#respond_to?(:your_hash): false
  Foo.my_array:
  - bat
  - bam
  - bad
  Foo.my_hash:
    :c: 2
    :d: 3
  Foo.respond_to?(:your_array): false
  Foo.respond_to?(:your_hash): false
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
Array (message='Show depth 1'):
  Array#size: 2
  Element 0: Integer 0
  Element 1: Array [1, [2, [3, [4]]]]
---
Array (message='Show depth 2'):
  Array#size: 2
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1: Array [2, [3, [4]]]
---
Array (message='Show depth 3'):
  Array#size: 2
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1:
        Array:
          Array#size: 2
          Element 0: Integer 2
          Element 1: Array [3, [4]]
---
Array (message='Show depth 4'):
  Array#size: 2
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1:
        Array:
          Array#size: 2
          Element 0: Integer 2
          Element 1:
            Array:
              Array#size: 2
              Element 0: Integer 3
              Element 1: Array [4]
---
Array (message='Show depth 5'):
  Array#size: 2
  Element 0: Integer 0
  Element 1:
    Array:
      Array#size: 2
      Element 0: Integer 1
      Element 1:
        Array:
          Array#size: 2
          Element 0: Integer 2
          Element 1:
            Array:
              Array#size: 2
              Element 0: Integer 3
              Element 1:
                Array:
                  Array#size: 1
                  Element 0: Integer 4
```
