#### Instance Methods

This example shows a custom handler that explicates via instance methods.

Here's a class ```Foo``` that has some instance methods:
 
@[ruby](foo.rb)

Here's its custom debug handler class ```FooHandler```.  The array returned by method ```calls_for_instance``` tells the base class ```Handler``` which methods to call for the explication, and what arguments to pass, if any.

@[ruby](foo_handler.rb)

Here's a program that uses the custom handler.

@[ruby](show.rb)

The output shows details of the object.

@[yaml](show.yaml)
