# ruby-riak-util

### Tiny script to clean up your riak installation

##### Will find (and optionaly delete) non-UTF8 and big keys in riak buckets.

Sometimes you may recieve error like this in riak's console.log:

```
2016-12-20 06:12:13.665 [error] <0.8173.4015> CRASH REPORT Process <0.8173.4015> with 0 neighbours exited with reason: {ucs,{bad_utf8_character_code}} in xmerl_ucs:from_utf8/1 line 185
```

Keys with non-UTF8 names can cause this when requested with HTTP method. 
Also, keys with more than 1-2mb are know to cause significant slowdown of riak cluster, so it is better to list and optimize them.
