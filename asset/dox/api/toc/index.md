# Foundation-startup Library Documentation for AI
<!-- Keywords: startup, universe, initialization, Objective-C, runtime, stacktrace, Foundation -->
## 1. Introduction & Purpose

**Foundation-startup** is a static-only Objective-C (mulle-objc) library that
supplies the startup code an executable requires in order to link against and
use the [Foundation](https://github.com/MulleFoundation/Foundation) framework.

It exists to solve one problem: the mulle-objc runtime expects the symbol
`__register_mulle_objc_universe` to be present in every executable, and it must
be defined *somewhere* when the executable is linked. Foundation-startup
provides this definition (via the aggregated private startup include), wires up
the Foundation-specific universe "bang" callback, and bequeaths all additional
link-time dependencies needed by an executable that uses Foundation.

Key features at a high level:

- Provides the required link-time `__register_mulle_objc_universe`
- Performs Foundation universe configuration with default settings before
  application code runs
- Registers a stacktrace callback (since 0.21.0) so crashes report a backtrace
- Glue library: pulls in all required dependencies for the executable link
- Enforced static-only: the build aborts if `BUILD_SHARED_LIBS` is set

It is the link-time companion of the Foundation library; an executable is
expected to link `Foundation-startup` rather than to re-implement universe
startup itself.

## 2. Key Concepts & Design Philosophy

### The "bang" mechanism
The mulle-objc runtime initializes its `struct _mulle_objc_universe` lazily.
The actual initialization work is done by a "bang" callback of the form
`void bang( struct _mulle_objc_universe *, struct mulle_allocator *, void *)`,
invoked internally through `_mulle_objc_universe_bang`. Foundation-startup
implements exactly this Foundation-flavored `bang` callback in its single
source file.

### Aggregation through private startup includes
The `.m` file imports two headers:

- `<MulleFoundation/MulleFoundation.h>` – the Foundation umbrella header
- `<MulleFoundation/mulle-foundation-startup-private.inc>` – private startup
  glue which in turn pulls in the mulle-objc runtime's
  `mulle-objc-startup-private.inc`. That runtime include defines
  `__register_mulle_objc_universe` and forwards to the `bang` function that this
  library implements (behind a `MulleFoundationBang` indirection).

This "one include pulls in everything needed" design is what makes the library
work as a pure link target.

### Side-effect library
Foundation-startup exports no public data structures, no public functions and
no classes. Its entire effect happens at program startup. There is nothing to
call from application code; linking is the only interaction.

### Version coupling
The source defines `FOUNDATION__STARTUP_VERSION`; `mulle-sde` derives the
library version from it (see `.mulle/etc/project/version-info.sh`). It is the
version anchor used to check compatibility with the linked Foundation.

## 3. Core API & Data Structures

There are **no public header files** in this project (`cmake/reflect/_Headers.cmake`
lists "no headers"). The entire public surface is the single source file
`src/Foundation-startup.m`. Everything below is copied verbatim from it.

### 3.1. `src/Foundation-startup.m`

#### Version macro

- **Purpose:** packed version of the library (major << 20, minor << 8, patch).

```c
#define FOUNDATION__STARTUP_VERSION  ((0UL << 20) | (21 << 8) | 1)
```

This evaluates to 0.21.1.

#### The `bang` callback (universe initialization)

- **Purpose:** the Foundation universe "bang". Called by the runtime once per
  process when the universe is first initialized. It fills a configuration
  struct with Foundation defaults, lets Foundation run its own bang, and then
  installs the stacktrace callback.
- It is referenced (indirectly) by the `__register_mulle_objc_universe`
  definition that comes in via the private startup include.
- **Verbatim signature and body:**

```c
static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
{
   struct _mulle_objc_universeconfiguration   config;

   mulle_foundation_universeconfiguration_set_defaults( &config);
   MulleFoundationBang( universe, allocator, &config);
   mulle_objc_universe_set_stacktrace_callback( universe,
                                                 mulle_stacktrace_once);
}
```

Behavior step by step:

1. A stack-local `struct _mulle_objc_universeconfiguration config` is declared
   and filled with Foundation's default settings via
   `mulle_foundation_universeconfiguration_set_defaults( &config)`.
2. `MulleFoundationBang( universe, allocator, &config)` hands the configured
   universe to Foundation so it can complete initialization.
3. `mulle_objc_universe_set_stacktrace_callback( universe, mulle_stacktrace_once)`
   installs `mulle_stacktrace_once` as the runtime's crash-stacktrace callback;
   subsequent fatal errors print a backtrace.

#### Imports and local declaration

- `#import <MulleFoundation/MulleFoundation.h>` – Foundation umbrella header.
- `#import <MulleFoundation/mulle-foundation-startup-private.inc>` – private
  startup glue; provides `MulleFoundationBang` and the implicit
  `__register_mulle_objc_universe` definition.
- `#include <mulle-stacktrace/mulle-stacktrace.h>` – provides
  `mulle_stacktrace_once`.
- The runtime function used by `bang` is declared locally (verbatim) rather
  than imported:

```c
MULLE_OBJC_RUNTIME_GLOBAL
void
   mulle_objc_universe_set_stacktrace_callback(
      struct _mulle_objc_universe *universe,
      void (*callback)( FILE *fp));
```

#### Referenced dependency symbols (context only)

These are provided by dependencies and referenced by the startup code.
Signatures copied verbatim from the dependency headers:

- From `mulle-objc-runtime` (`mulle-objc-universe.h`):

```c
struct _mulle_objc_universe  *
   __register_mulle_objc_universe( mulle_objc_universeid_t universeid,
                                   char *universename);
```

```c
void   _mulle_objc_universe_bang( struct _mulle_objc_universe  *universe,
                                  void (*bang)( struct _mulle_objc_universe  *universe,
                                                struct mulle_allocator *allocator,
                                                void *userinfo),
                                  struct mulle_allocator *allocator,
                                  void *userinfo);
```

- From `mulle-stacktrace` (`mulle-stacktrace.h`):

```c
static inline void   mulle_stacktrace_once( FILE *fp)
{
   _mulle_stacktrace( NULL, 1, mulle_stacktrace_trimmed, fp);
}
```

- From `MulleFoundation` (`mulle-foundation-universeconfiguration-private.h`):

```c
void  mulle_foundation_universeconfiguration_set_defaults( struct _mulle_objc_universeconfiguration *setup);
```

## 4. Performance Characteristics

- **Execution cost:** the `bang` callback runs exactly once per process, during
  lazy universe initialization. Cost is a single stack-sized config struct, one
  defaults-fill call, one configure call and one callback registration. There is
  no steady-state cost after startup.
- **Memory:** no heap allocations are made by this library at startup; the
  allocator is passed in by the runtime.
- **Thread-safety:** startup runs under the control of the mulle-objc runtime's
  single-shot universe initialization; no reentrancy concerns for application
  code. Stacktrace callback registration happens once, before the application's
  code runs.
- **Trade-off:** as a static-only library it cannot be built shared (the build
  is intentionally aborted for `BUILD_SHARED_LIBS`), which is what guarantees
  `__register_mulle_objc_universe` is present in the final executable link.

## 5. AI Usage Recommendations & Patterns

- **Best Practices**
  - Treat Foundation-startup as a link-time dependency for *executables* only;
    it is not a runtime API to call.
  - If an executable link fails with an undefined reference to
    `__register_mulle_objc_universe`, link Foundation-startup into it.
  - Add it to an executable project with
    `mulle-sde add github:MulleFoundation/Foundation-startup`.
  - Remember that the version is read from the `FOUNDATION__STARTUP_VERSION`
    macro in the source file; keep it in sync when changing CMake `project()`
    version.

- **Common Pitfalls**
  - Do not call `bang` manually; it is internally registered.
  - Do not look for a `.h` API to include — there are no public headers.
  - Do not replace the local declaration of
    `mulle_objc_universe_set_stacktrace_callback`: it must be declared with the
    `MULLE_OBJC_RUNTIME_GLOBAL` visibility, otherwise the runtime symbol is not
    resolved at link time.
  - Do not build shared (`BUILD_SHARED_LIBS` is rejected on purpose).

- **Idiomatic Usage**
  - Executables simply `#import <Foundation/Foundation.h>` in their sources and
    link `Foundation-startup`; the universe is configured and "banged" before
    application code runs, and crash backtraces are installed automatically.

## 6. Integration Examples

### Example 1: The startup implementation (this library's core)

This is the complete functional content of `src/Foundation-startup.m`,
presented in the code style of the project.

```c
#define _GNU_SOURCE

#import <MulleFoundation/MulleFoundation.h>

#import <MulleFoundation/mulle-foundation-startup-private.inc>

#include <mulle-stacktrace/mulle-stacktrace.h>

MULLE_OBJC_RUNTIME_GLOBAL
void
   mulle_objc_universe_set_stacktrace_callback(
      struct _mulle_objc_universe *universe,
      void (*callback)( FILE *fp));


#define FOUNDATION__STARTUP_VERSION  ((0UL << 20) | (21 << 8) | 1)


static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
{
   struct _mulle_objc_universeconfiguration   config;

   mulle_foundation_universeconfiguration_set_defaults( &config);
   MulleFoundationBang( universe, allocator, &config);
   mulle_objc_universe_set_stacktrace_callback( universe,
                                                 mulle_stacktrace_once);
}
```

### Example 2: Executable that relies on Foundation-startup

Application code only needs to import Foundation; the startup library (linked
into the executable) guarantees the universe is ready and crash backtraces are
installed before `main` runs.

```c
#import <Foundation/Foundation.h>
#include <stdio.h>


int   main( int argc, char **argv)
{
   printf( "Foundation version %u.%u.%u\n",
           Foundation_get_version_major(),
           Foundation_get_version_minor(),
           Foundation_get_version_patch());
   return( 0);
}
```

## 7. Dependencies

Direct mulle-sde dependencies, taken verbatim from `clib.json`
(authoritative) and `.mulle/etc/sourcetree/config`:

- `MulleFoundation/Foundation` – the Foundation framework itself; in the
  sourcetree this node carries the flags
  `no-bequeath,no-header,no-link,no-singlephase`. The `.m` file imports
  `<MulleFoundation/MulleFoundation.h>` and
  `<MulleFoundation/mulle-foundation-startup-private.inc>` from it.
- `mulle-core/mulle-stacktrace` – provides `mulle_stacktrace_once`, used to
  install the crash backtrace callback (added in 0.21.0).

Note: an older release of the README also mentioned `mulle-atinit` and
`mulle-atexit` as link-time requirements; current metadata (`clib.json`)
lists only the two dependencies above.