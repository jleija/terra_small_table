# small_table

This is a small [Terra](http://terralang.org/) dictionary/map library, with a very limited scope and a simple interface. The lookup is linear, and not optimized in any way. I expect to use if for small number of keys no greater than 32, for example. The key comparitor is the equality operator (==), so small_table is only suited for integral/simple types that respond to the == operator (no strings).

Consider this project a work in progress.

The [busted](https://olivinelabs.com/busted/) unit tests in the spec directory describe its intended use.

License: MIT.
