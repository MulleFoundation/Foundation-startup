# Foundation-startup Library Documentation for AI

## 1. Introduction & Purpose

**Foundation-startup** is a minimal wrapper that provides automatic initialization of Foundation when linked into an application. It ensures all Foundation components are properly initialized before `main()` is called.

This library exists to:
- Automatically invoke Foundation startup code via constructor functions
- Ensure proper initialization order of all Foundation subsystems
- Provide a single link target that handles all Foundation initialization
- Support the standard Objective-C pattern of implicit framework initialization

Most applications should link Foundation-startup automatically via their build system. It does not export any public API; it's purely for side effects (initialization).

## 2. Key Concepts & Design Philosophy

### Automatic Initialization
This library uses constructor functions (code executed before `main()`) to initialize Foundation. This happens transparently without requiring explicit initialization calls in application code.

### Initialization Ordering
Foundation has a strict initialization order:
1. ObjC runtime (MulleObjC) initializes first
2. Component libraries initialize in dependency order
3. Application code can then safely call any Foundation methods

Foundation-startup enforces this order automatically.

### Zero Public API
This library provides no classes, functions, or types for public use. It exists purely for its initialization side effects. Linking against it is the only interaction needed.

## 3. Core API & Data Structures

### No Public API
Foundation-startup exports no public functions or classes. Its entire purpose is executed via constructor functions at program startup.

### Usage Pattern

**At Build Time:**
- Link applications against Foundation-startup instead of MulleFoundation directly
- Build system should link: `mulle-objc ... foundation-startup ...`

**At Runtime:**
- Before `main()` is called, all Foundation initialization happens automatically
- By the time `main()` executes, all Foundation classes are ready to use

**Typical Application Code:**
```objc
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
    @autoreleasepool {
        // Foundation is fully initialized at this point
        NSLog(@"Foundation ready!");
        return 0;
    }
}
```

## 4. Performance Characteristics

### Startup Time
- Adds initialization overhead (~50-100ms) before `main()` starts
- Includes loading and initialization of all Foundation components
- Should only be measured in startup-critical applications

### Memory
- No additional memory overhead beyond MulleFoundation itself
- Initialization structures discarded after startup completes

---

## 5. AI Usage Recommendations & Patterns

### Best Practices
- Always link applications against Foundation-startup (not MulleFoundation directly)
- Let the build system handle linking; don't override startup libraries
- Don't manually call Foundation initialization functions

### Common Pitfalls
- Linking only MulleFoundation without Foundation-startup may leave Foundation uninitialized
- Don't attempt to call startup functions manually; they're meant to run automatically
- Don't link Foundation-startup into libraries; only applications should use it

---

## 6. Integration Examples

### Example: Build Configuration

Modern mulle-sde build systems handle this automatically. For manual builds:

```bash
# When building an executable
cc -o myapp main.m -lmulle-foundation-startup -lMulleFoundation

# The -lmulle-foundation-startup ensures initialization happens
```

### Example: Application Code (No Changes Needed)

```objc
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
    @autoreleasepool {
        // All Foundation classes automatically available
        NSArray *arr = @[@1, @2, @3];
        NSLog(@"Ready: %@", arr);
        return 0;
    }
}
```

---

## 7. Dependencies

**Foundation-startup** depends on:
- **MulleFoundation** - Provides all Foundation functionality to initialize
- **Foundation** - May depend on Foundation wrapper for compatibility

This library's sole purpose is to ensure all dependencies are properly initialized before application code runs.
