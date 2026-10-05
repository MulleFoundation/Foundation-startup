### 0.21.1

Various small improvements

## 0.21.0


feature: register mulle-stacktrace callback during Foundation startup

* Foundation startup now installs a stacktrace callback so crashes report a backtrace
* new `mulle-core/mulle-stacktrace` runtime dependency, added to `clib.json`
* ``mulle_objc_universe_set_stacktrace_callback`` is hooked into the runtime bang configuration


### 0.20.9

Various small improvements
