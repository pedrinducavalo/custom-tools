# custom-tools

A small Haxe utility library with helpers for working with arrays, maps, and enums. It provides `ArrayTools`, `MapTools`, and `EnumTools`, along with a `CustomTools` module that re-exports all three.

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

### Import all tools

`CustomTools` re-exports the three utility classes in one module. Import its module types, then enable the extensions you want to use:

```haxe
import CustomTools.*;

using CustomTools.ArrayTools;
using CustomTools.MapTools;
using CustomTools.EnumTools;

enum Color {
    Red;
    Green;
    Blue;
}

class Main {
    static function main() {
        var numbers = [1, 2, 3, 4];
        trace(numbers.firstItem()); // 1
        trace(numbers.sum());       // 10

        var scores = ["Ada" => 37, "Linus" => 54];
        trace(scores.getOrElse("Ada", 0)); // 37
        trace(scores.keysArray());         // ["Ada", "Linus"]

        trace(Color.getNames());       // ["Red", "Green", "Blue"]
        trace(Color.fromString("Red")); // Red
    }
}
```

You can also import and use only the individual tools you need:

```haxe
using CustomTools.ArrayTools;

var first = [10, 20, 30].firstItem(); // 10
```

### ArrayTools

`ArrayTools` provides helpers for retrieving items, checking and shuffling arrays, random selection, numeric operations, finding and transforming items, flattening nested arrays, and removing values. For example:

```haxe
using CustomTools.ArrayTools;

var values = [1, 2, 3, 2];
trace(values.unique()); // [1, 2, 3]
trace(values.sum());    // 8
trace(values.sample(2)); // 2 randomly selected items
```

### MapTools

`MapTools` provides helpers for default lookups and insertion, merging and cloning maps, inverting keys and values, filtering and transforming entries, converting map contents to arrays, and checking key and value types.

```haxe
using CustomTools.MapTools;

var ages = ["Ada" => 37, "Linus" => 54];
var adults = ages.filter(function(name, age) return age >= 18);
var labels = ages.mapValues(function(age) return "Age: " + age);
```

### EnumTools

`EnumTools` provides helpers for listing enum constructors, creating values from constructor names or indices, and retrieving a value's constructor name or index.

```haxe
using CustomTools.EnumTools;

enum Color {
    Red;
    Green;
    Blue;
}

var names = Color.getNames();         // ["Red", "Green", "Blue"]
var color = Color.fromIndex(1);       // Green
var index = Color.Green.toIndex();   // 1
```

Enum constructors that require arguments cannot be created by `fromString()` or `fromIndex()`. `getAllValues()` skips constructors that cannot be created without arguments.

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

`custom-tools` is a simple haxelib project focused on common array, map, and enum operations.

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
