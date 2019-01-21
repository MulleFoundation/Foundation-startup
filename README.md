# Foundation

💍 Convenient wrapper for the MulleFoundation

It's raison d´etre is to support `#import <Foundation/Foundation.h>`
statements in Objective-C code. It also adds
[objc-compat](//github.com/MulleFoundation/objc-compat) to the list of
available dependencies.

In content **Foundation** is identical to *MulleFoundation*. See the
[MulleFoundation](//github.com/MulleFoundation/MulleFoundation)
for more information.


Build Status | Release Version
-------------|-----------------------------------
[![Build Status](https://travis-ci.org/MulleFoundation/Foundation.svg)](https://travis-ci.org/MulleFoundation/Foundation) | ![Community tag](https://img.shields.io/github/tag/MulleFoundation/Foundation.svg)


## Install Foundation

The recommended way to develop with the MulleFoundation is to use [mulle-sde](//github.com/mulle-sde) with the development kit [foundation-developer](//github.com/mulle-objc/foundation-developer).
Then you don't install **Foundation** yourself, but let *mulle-sde* do this for
you.

See [foundation-developer](//github.com/mulle-objc/foundation-developer)
for installation instructions. It will install everything you need.


## Legacy Workflow Support

### Install Foundation as a shared library

To support development outside of the *mulle-sde* workflow, you can
build a "whole-archive" shared library of the MulleFoundation with all its
 dependencies such as [mulle-core](//github.com/mulle-core) and
 [mulle-objc-runtime](//github.com/mulle-objc-runtime) included.

You will need to install [mulle-clang](//github.com/mulle-objc/foundation-developer).
You will also have to install [mulle-sde](//github.com/mulle-objc/foundation-developer)
for the initial compilation of the *Foundation* library, but afterwards you can uninstall it.

The following example builds a `libFoundation.so` on Linux and installs it and the required headers
into your `~/usr` directory:

```
$ mulle-sde install --standalone --prefix "${HOME}/usr" "https://github.com/MulleFoundation/Foundation/archive/latest.zip"
```

> #### Homebrew support
>
> On MacOS there is a brew formula, which will install a
 `libFoundation.dylib` and all required headers into `/usr/local`:
>
> ```
> brew install mulle-kybernetik/software/Foundation
> ```


### Use Foundation as a shared library

It's assumed you used `mulle-sde install` on Linux and `brew install` on MacOS.

#### Linux:

```
$ mulle-clang -isystem "${HOME}/include" -L"${HOME}/lib" -Wl,-rpath -Wl,"${HOME}/lib" -lFoundation
```

The executable learns where to find the shared library with `-Wl,-rpath -Wl,"${HOME}/lib"`.


#### MacOS:

```
$ XCODE_SDK_DIR="`xcrun --show-sdk-path`"
$ mulle-clang -isystem "/usr/local/include" -isystem "${XCODE_SDK_DIR}/include" -L"/usr/local/lib" -Wl,-rpath -Wl,"/usr/local/lib" -lFoundation
```

mulle-clang needs the standard C headers from the Xcode SDK. So tell mulle-clang where they are with
`-isystem "${XCODE_SDK_DIR}/include"`.
The executable learns where to find the shared library with `-Wl,-rpath -Wl,"/usr/local/lib"`.


## Author

[Nat!](//www.mulle-kybernetik.com/weblog) for
[Mulle kybernetiK](//www.mulle-kybernetik.com) and
[Codeon GmbH](//www.codeon.de)
