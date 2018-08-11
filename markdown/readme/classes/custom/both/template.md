#### Instance and Singleton Methods

This example shows a custom handler that explicates via both kinds of methods.

Here's a class ```Foo``` that has instance methods and singleton methods:
 
@[ruby](foo.rb)

Here's its custom debug handler class ```FooHandler```.

@[ruby](foo_handler.rb)

Here's a program that uses the custom handler.

@[ruby](show.rb)

The output shows details of the object.

@[yaml](show.yaml)
