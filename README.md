# small_table

The [Terra Programming Language](http://terralang.org/) is awesome but it comes with no batteries at all. Its ecosystem is still too small. It doesn't have a decent collection library yet. It is a minimalistic language and I understand that I can use any C library for collections/maps/dictionaries. But, sometimes, I just need a simple map/dictionary that is going to have only an handful of keys, and I've found myself implementing a simple C-like array lookup table a couple times. 

Well, I just decided to make it a small library, with a very limited scope and a simple interface. The lookup is linear, and not optimized on any way. I expect to use if for small number of keys no greater than 32, for example.

The unit tests in the spec directory describe its intended use.

License: MIT.
