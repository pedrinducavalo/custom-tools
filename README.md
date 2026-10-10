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
haxelib dev custom-tools.
```

## Usage
```haxe
import ArrayTools;

var values = [1, 2, 3, 4];

trace(ArrayTools.firstItem(values)); // 1
trace(ArrayTools.lastItem(values)); // 4
trace(ArrayTools.hasItems(values)); // true
trace(ArrayTools.unique([1, 2, 1, 3])); // [1, 2, 3]
trace(ArrayTools.sample([10, 20, 30, 40], 2)); // 2 random items
trace(ArrayTools.sum([1, 2, 3])); // 6
```

## Flixel support
Some methods are compatible with Flixel when the flixel define is enabled:
```bash
haxe --define flixel build.hxml
```
This enables behavior such as removeDead() and uses Flixel random helpers when available.

## License
This project is licensed under the MIT License.

## Status
This is a minimal haxelib project and is currently focused on utility helpers for arrays. It is a good foundation for future additions as the library grows.

## Contributing
Contributions are welcome. If you want to expand this library, keep the API consistent, simple, and lightweight so it remains easy to use in Haxe projects.
