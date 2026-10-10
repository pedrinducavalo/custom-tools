# custom-tools

A lightweight Haxe utility library focused on common array operations.

This project is intentionally small and simple, designed as a straightforward haxelib package for reusable array helpers. It currently provides a static utility class, `ArrayTools`, with helpers for reading, mutating, filtering, and sampling arrays in a clean and concise way.

## Features

- `firstItem()` / `lastItem()`
- `hasItems()`
- `shuffle()`
- `randomItem()`
- `sum()` / `sub()`
- `nextItem()` / `previousItem()`
- `isArrayOf()`
- `clear()`
- `find()`
- `sample()`
- `pluck()`
- `unique()`
- `flatten()`
- `without()`
- Optional Flixel-aware helpers such as `removeDead()` when `flixel` is enabled

## Installation

If you want to install it as a haxelib package:

```bash
haxelib git custom-tools https://github.com/pedrinducavalo/custom-tools
```

If you are working from a local checkout:
```bash
haxelib dev custom-tools .
```

## Usage

You can use `ArrayTools` as a standard static class or extend Haxe arrays natively using the `using` keyword.

### Using Static Extensions (Recommended)
```haxe
using ArrayTools;

class Main {
    static function main() {
        var values = [1, 2, 3, 4, 3, 4];

        trace(values.firstItem()); // 1
        trace(values.lastItem());  // 4
        trace(values.hasItems());  // true
        trace(values.unique());    // [1, 2, 3, 4]
        trace(values.sum());       // 17
        trace(values.sample(2));   // 2 random items
    }
}
```

### Traditional Static Calls
```haxe
import ArrayTools;

class Main {
    static function main() {
        var values = [1, 2, 3, 4];

        trace(ArrayTools.firstItem(values));           // 1
        trace(ArrayTools.lastItem(values));            // 4
        trace(ArrayTools.hasItems(values));            // true
        trace(ArrayTools.unique([1, 2, 1, 3]));        // [1, 2, 3]
        trace(ArrayTools.sample([10, 20, 30, 40], 2)); // 2 random items
        trace(ArrayTools.sum([1, 2, 3]));              // 6
    }
}
```

## Flixel Support

Some methods are compatible with Flixel when the `flixel` flag is enabled (automatic in HaxeFlixel projects or via `Project.xml`):

```bash
haxe --define flixel build.hxml
```

This enables specific behaviors, such as cleaning up dead or inactive `FlxBasic` objects from memory:

```haxe
using ArrayTools;

// Removes and destroys inactive objects, sprites, or group members automatically
myFlixelArray.removeDead(); 
```

It also safely redirects `randomItem()` to use Flixel's internal random number generator (`FlxG.random.getObject`).

## License

This project is licensed under the MIT License.

## Status

This is a minimal haxelib project and is currently focused on utility helpers for arrays. It is a good foundation for future additions as the library grows.

## Contributing

Contributions are welcome. If you want to expand this library, keep the API consistent, simple, and lightweight so it remains easy to use in Haxe projects.
