# custom-tools

Haxe utility extensions for arrays, maps, enums, floating-point values, and colors. The library provides `ArrayTools`, `MapTools`, `EnumTools`, `FloatTools`, and `ColorTools` in the `tools` package, plus frame-time helpers in `tools.utils.FPSUtil`.

## Lambda compatibility notice

`ArrayTools.find()`, `ArrayTools.flatten()`, and `MapTools.filter()` were removed in version 0.1.0 because their names conflict with methods from Haxe's standard `Lambda` class when using extensions. For those operations, use `using Lambda;` and call the corresponding `Lambda` methods instead.

This notice applies to version 0.1.0 and all future versions: these methods will remain removed through the end of the project.

## Installation

Install the published haxelib:

```bash
haxelib install custom-tools
```

To use a local checkout during development:

```bash
haxelib dev custom-tools .
```

## Usage

Import each tool class as a Haxe extension using `using`:

```haxe
using tools.ArrayTools;
using tools.ColorTools;
using tools.EnumTools;
using tools.FloatTools;
using tools.MapTools;

enum Color {
    Red;
    Green;
    Blue;
}

class Main {
    static function main() {
        var numbers = [1, 2, 3];
        trace(numbers.first()); // 1
        trace(numbers.unique()); // [1, 2, 3]

        var scores = ["Ada" => 37, "Linus" => 54];
        trace(scores.getOrElse("Ada", 0)); // 37

        trace(Color.getNames()); // ["Red", "Green", "Blue"]
        trace(Color.fromIndex(1)); // Green

        trace(3.14159.roundToDecimal(2)); // 3.14
        var color = ColorTools.fromRgb(255, 64, 32);
        trace(color.getRed()); // 255
    }
}
```

You can import only the helpers you need. For example:

```haxe
using tools.ArrayTools;

var first = [10, 20, 30].first(); // 10
```

## API reference

All methods below are static extension methods. For example, after `using tools.ArrayTools;`, call `array.first()` rather than `ArrayTools.first(array)`.

### `tools.ArrayTools`

Array retrieval, transformation, numeric, and cleanup helpers.

| Method | Description |
| --- | --- |
| `first<T>(array):Null<T>` | Returns the first element, or `null` for an empty array. |
| `last<T>(array):Null<T>` | Returns the last element, or `null` for an empty array. |
| `clear<T>(array):Void` | Removes all elements from the array. With the `flixel` define, pops and destroys each element as a `FlxBasic`. |
| `clone<T>(array):Array<T>` | Returns a shallow copy of the array. |
| `sum<T>(array):Null<Dynamic>` | Returns the sum for an all-numeric array, or the array length for a non-numeric array. Returns `null` for an empty array. |
| `sub<T>(array):Null<Dynamic>` | For numeric arrays, subtracts every element (including the first) from the first element. For non-numeric arrays, returns the negative length. Returns `null` for an empty array. |
| `nextItem<T>(array, curItem = 0, wrap = false):Null<T>` | Returns `null` for an empty array. In the current implementation, returns the first element when `curItem` is not the last index and `wrap` is `true`; otherwise returns `null`. |
| `previousItem<T>(array, curItem = 0, wrap = false):Null<T>` | Returns `null` for an empty array. In the current implementation, returns the last element when `curItem` is not the last index and `wrap` is `true`; at the last index, returns the element before it. |
| `isArrayOf<T>(array, type):Null<Bool>` | Returns whether every element is an instance of `type`; returns `null` for an empty array. |
| `removeArrayDead<T:FlxBasic>(array):Void` | *(With `flixel`)* Removes and destroys elements whose `alive` or `exists` flag is false. |
| `sample<T>(array, n):Array<T>` | Returns up to `n` randomly selected elements without replacement; the source array is not modified. |
| `pluck<T, V>(array, key):Array<V>` | Returns the value of the named reflected field from each element. |
| `unique<T>(array):Array<T>` | Returns an array containing each distinct value once, preserving its first occurrence. |
| `without<T>(array, values):Array<T>` | Removes the specified values from the original array and returns that same array. |
| `hasItems<T>(array):Bool` | Returns whether the array contains at least one element. |

The `sub()` behavior above reflects the current implementation, including subtracting the first value from itself. The `nextItem()` and `previousItem()` methods also have the index behavior described in the table; verify that behavior before relying on them for navigation.

### `tools.MapTools`

Lookup, copying, transformation, and inspection helpers for `haxe.Constraints.IMap`.

| Method | Description |
| --- | --- |
| `getOrElse<K, V>(map, key, defaultValue):Null<V>` | Returns the value for `key`, or `defaultValue` if the key does not exist. |
| `getOrSet<K, V>(map, key, defaultFactory):Null<V>` | Returns the existing value, or calls the factory, stores its result, and returns it. |
| `merge<K, V>(map, otherMap):Map<K, V>` | Returns a copy containing entries from both maps; values from `otherMap` replace matching keys. |
| `clone<K, V>(map):Map<K, V>` | Returns a shallow copy of the map. |
| `invert<K, V>(map):Map<V, K>` | Swaps keys and values. If multiple keys have the same value, the last one iterated is retained. |
| `hasItems<K, V>(map):Bool` | Returns whether the map has at least one key. |
| `toArray<K, V, T>(map, f):Array<T>` | Converts entries to an array by calling `f(key, value)` for each non-null value; null-valued entries are skipped. |
| `keysArray<K, V>(map):Array<K>` | Returns the map keys as an array. |
| `valuesArray<K, V>(map):Array<V>` | Returns the map values as an array. |
| `removeMapDead<K, V>(map):Map<K, V>` | *(With `flixel`)* If all values are `FlxBasic` instances, removes every entry and destroys its value. |
| `mapValues<K, V, R>(map, f):Map<K, R>` | Returns a new map with each non-null value transformed by `f`; keys are preserved. |
| `isMapKeysOf<K, V>(map, type):Null<Bool>` | Checks whether all keys are instances of `type`; returns `null` for an empty map. |
| `isMapValuesOf<K, V>(map, type):Null<Bool>` | Checks whether all values are instances of `type`; returns `null` for an empty map. |

### `tools.EnumTools`

Reflection helpers for enum types and values.

| Method | Description |
| --- | --- |
| `getNames<T>(e:Enum<T>):Array<String>` | Returns the enum constructor names, or an empty array if `e` is `null`. |
| `fromString<T>(e, name, ?defaultValue):Null<T>` | Creates the enum value for the constructor named `name`; returns `defaultValue` when the enum or name is invalid. |
| `fromIndex<T>(e, index, ?defaultValue):Null<T>` | Creates the enum value at the given constructor index; returns `defaultValue` for an invalid index. |
| `toIndex(enumValue):Int` | Returns the constructor index, or `-1` if the value is `null`. |
| `toString(enumValue):String` | Returns the constructor name, or an empty string if the value is `null`. |
| `getAllValues<T>(e:Enum<T>):Array<T>` | Attempts to create and return every enum constructor without arguments. Constructors requiring arguments cannot be represented this way. |

Example:

```haxe
using tools.EnumTools;

enum Direction {
    North;
    South;
    East;
    West;
}

var names = Direction.getNames(); // ["North", "South", "East", "West"]
var direction = Direction.fromIndex(1); // South
var index = Direction.East.toIndex(); // 2
```

### `tools.FloatTools`

Floating-point comparison, range, rounding, interpolation, and sign helpers.

| Method | Description |
| --- | --- |
| `nearEquals(a, b, epsilon = 0.00001):Bool` | Returns whether the absolute difference between `a` and `b` is at most `epsilon`. |
| `clamp(float, min, max):Float` | Restricts the value to the inclusive `[min, max]` range. |
| `roundToDecimal(float, decimals):Float` | Rounds to the requested number of decimal places. |
| `floorToDecimal(float, decimals):Float` | Rounds down to the requested number of decimal places. |
| `ceilToDecimal(float, decimals):Float` | Rounds up to the requested number of decimal places. |
| `lerp(a, b, t):Float` | Interpolates from `a` toward `b` using a clamped, frame-rate-adjusted ratio. |
| `sign(float):Int` | Returns `1` for positive values, `-1` for negative values, and `0` for zero. |
| `min(float, other):Float` | Returns the smaller of the two values. |
| `max(float, other):Float` | Returns the larger of the two values. |
| `randomSign():Int` | Returns `-1`, `0`, or `1`, each with equal probability. |

Example:

```haxe
using tools.FloatTools;

var limited = 12.5.clamp(0, 10); // 10
var close = 1.0.nearEquals(1.000001); // true
var next = 10.0.lerp(20.0, 0.5); // Moves toward 20 using the current frame time
```

`lerp()` adjusts its interpolation ratio using `FPSUtil.getDeltaTime()`, so it is intended for frame-by-frame interpolation rather than calculating a frame-independent midpoint.

### `tools.ColorTools`

ARGB color creation, interpolation, and channel-reading helpers.

| Method | Description |
| --- | --- |
| `lerpColor(color1, color2, ratio):Int` | Interpolates between two ARGB colors using a frame-rate-adjusted ratio clamped to `0-1`. |
| `fromRgb(r, g, b):Int` | Creates an opaque ARGB color; each channel is clamped to `0-255`. |
| `getAlpha(color):Float` | Returns the alpha channel as a value from `0` to `255`. |
| `getRed(color):Float` | Returns the red channel as a value from `0` to `255`. |
| `getGreen(color):Float` | Returns the green channel as a value from `0` to `255`. |
| `getBlue(color):Float` | Returns the blue channel as a value from `0` to `255`. |

Use the channel getters as extensions with `using tools.ColorTools;`. The interpolation ratio uses the frame time provided by `tools.utils.FPSUtil`.

### `tools.utils.FPSUtil`

Frame-time helpers used by frame-rate-adjusted interpolation.

| Method | Description |
| --- | --- |
| `getDeltaTime():Float` | Returns the current frame duration in seconds from Flixel, Ceramic, or Heaps when their compile-time define is enabled; otherwise defaults to `1/60`. |
| `getFPSRatio(ratio, ?delta):Float` | Adjusts a 60-FPS interpolation ratio for the supplied frame duration, or the current frame duration when omitted. |

## HaxeFlixel support

When compiled with the `flixel` define, `ArrayTools.clear()` destroys each popped element, `ArrayTools.removeArrayDead()` removes and destroys inactive or nonexistent `FlxBasic` values, and `MapTools.removeMapDead()` removes and destroys all values when they are all `FlxBasic` instances.

In HaxeFlixel projects, the `flixel` define is typically supplied by the project configuration. It can also be enabled explicitly:

```bash
haxe --define flixel build.hxml
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
