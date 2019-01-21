# -- Formula Info --
# If you don't have this file, there will be no homebrew
# formula operations.
#
PROJECT="Foundation"      # your project/repository name
DESC="💍 Convenient wrapper for the MulleFoundation"
LANGUAGE="objc"             # c,cpp, objc, bash ...

# LANGUAGE="c"             # c,cpp, objc, bash ...
# NAME="${PROJECT}"        # formula filename without .rb extension

#
# Specify needed homebrew packages by name as you would when saying
# `brew install`.
#
# Use the ${DEPENDENCY_TAP} prefix for non-official dependencies.
# DEPENDENCIES and BUILD_DEPENDENCIES will be evaled later!
# So keep them single quoted.
#
BUILD_DEPENDENCIES='mulle-kybernetik/software/mulle-sde
mulle-kybernetik/software/mulle-craft
mulle-kybernetik/software/mulle-dispense
mulle-kybernetik/software/mulle-fetch
mulle-kybernetik/software/mulle-make
mulle-kybernetik/software/mulle-platform
mulle-kybernetik/software/mulle-sourcetree
mulle-kybernetik/software/mulle-bashfunctions
cmake
ninja'

DEPENDENCIES="codeon-gmbh/software/mulle-clang"

