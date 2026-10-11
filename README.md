# custom-tools

A small Haxe utility library with helpers for working with arrays and maps. The project is available as a haxelib and currently provides two utility classes: `ArrayTools` and `MapTools`.

## Installation

Install the library directly from GitHub:

```bash
haxelib git custom-tools https://github.com/pedrinducavalo/custom-tools
```

To use a local checkout during development:

```bash
haxelib dev custom-tools .
```

## Usage

Both utility classes can be used as extension methods with Haxe's `using` keyword, or called as regular static methods.

### ArrayTools

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
        trace(values.sample(2));   // 2 randomly selected items
    }
}
```

Static calls are also supported:

```haxe
import ArrayTools;

var first = ArrayTools.firstItem([10, 20, 30]); // 10
```

`ArrayTools` includes helpers for retrieving items, checking and shuffling arrays, random selection, numeric operations, finding and transforming items, flattening nested arrays, and removing values.

### MapTools

```haxe
using MapTools;

class Main {
    static function main() {
        var ages = ["Ada" => 37, "Linus" => 54];

        trace(ages.getOrElse("Ada", 0)); // 37
        trace(ages.hasItems());          // true

        var adults = ages.filter(function(name, age) return age >= 18);
        var labels = ages.mapValues(function(age) return "Age: " + age);
        var names = ages.keysArray();    // ["Ada", "Linus"]
        var values = ages.valuesArray(); // [37, 54]
    }
}
```

`MapTools` includes helpers for default lookups and insertion, merging and cloning maps, inverting keys and values, filtering and transforming entries, converting map contents to arrays, and checking key and value types.

## Flixel support

When compiled with the `flixel` define, the library enables Flixel-specific behavior:

- `ArrayTools.randomItem()` uses Flixel's random number generator.
- `ArrayTools.clear()` destroys `FlxBasic` items before clearing the array.
- `ArrayTools.removeDead()` removes and destroys inactive or nonexistent `FlxBasic` items.
- `MapTools.removeDead()` removes and destroys map values when all values are `FlxBasic` instances.

In HaxeFlixel projects, the `flixel` define is typically provided by the project configuration. It can also be enabled explicitly:

```bash
haxe --define flixel build.hxml
```

## License

This project is licensed under the MIT License.

## Status

`custom-tools` is a simple haxelib project. Its current utilities focus on common array and map operations.

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
