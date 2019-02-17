# small_table

The [Terra Programming Language](http://terralang.org/) is awesome but it comes with no batteries at all. It doesn't have a collection library. It is a powerful language with a minimalistic philosophy (like Lua or Scheme) and I really like that. I know I can use any C library for collections/maps/dictionaries; but, many times I just need a simple map/dictionary that is going to have only an handful of keys, and I've found myself implementing a simple C-like array lookup table a couple times already (to avoid introducing 3rd-party dependencies for such a simple problem). 

So I decided to make a small native library, with a very limited scope and a simple interface. The lookup is linear, and not optimized in any way. I expect to use if for small number of keys no greater than 32, for example.

The key comparitor is the equality operator (==), so small_table is only suited for integral/simple types that respond to the == operator (no strings).

The [busted](https://olivinelabs.com/busted/) unit tests in the spec directory describe its intended use.

License: MIT.
