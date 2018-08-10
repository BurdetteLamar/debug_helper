#### Singleton Methods

This example shows a custom handler that explicates via singleton methods.

Here's a class ```Foo``` that has some singleton methods:
 
@[ruby](foo.rb)

Here's its custom debug handler class ```FooHandler```.  The array returned in method ```calls_for_class``` tells the base class ```Handler``` which methods to call for the explication.

@[ruby](foo_handler.rb)

Here's a program that uses the custom handler.

@[ruby](show.rb)

The output shows details of the object.

@[yaml](show.yaml)
