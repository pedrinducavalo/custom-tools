# API Reference

This reference documents the public helpers currently in `tools/`. The version 0.2.0 package layout is organized by purpose:

| Helper | Module | `tools.Tools` typedef |
| --- | --- | --- |
| `BoolTools` | `tools.basic.BoolTools` | `tools.Tools.BoolTools` |
| `FloatTools` | `tools.basic.FloatTools` | `tools.Tools.FloatTools` |
| `IntTools` | `tools.basic.IntTools` | `tools.Tools.IntTools` |
| `ArrayTools` | `tools.iterables.ArrayTools` | `tools.Tools.ArrayTools` |
| `MapTools` | `tools.iterables.MapTools` | `tools.Tools.MapTools` |
| `EasingTools` | `tools.math.EasingTools` | `tools.Tools.EasingTools` |
| `GeomTools` | `tools.math.GeomTools` | `tools.Tools.GeomTools` |
| `TimeTools` | `tools.math.TimeTools` | `tools.Tools.TimeTools` |
| `ColorTools` | `tools.special.ColorTools` | `tools.Tools.ColorTools` |
| `EnumTools` | `tools.special.EnumTools` | `tools.Tools.EnumTools` |
| `StringTools` | `tools.special.StringTools` | `tools.Tools.StringTools` |
| `FPSUtil` | `tools.utils.FPSUtil` | — |

The extension methods can be enabled with `using`, for example `using tools.basic.FloatTools;`. The `tools.Tools` module also declares typedef aliases for the public helper classes; direct subpackage imports are shown here to make the package locations explicit.

## `tools.basic.BoolTools`

Boolean conversion and transformation helpers.

| Method | Description |
| --- | --- |
| `int(bool):Int` | Converts `true` to `1` and `false` to `0`. |
| `toggle(bool):Bool` | Returns the opposite boolean value. |
| `string(bool, ?yes, ?no):String` | Returns the supplied custom text when both `yes` and `no` are given; otherwise returns the standard boolean string. |

## `tools.basic.FloatTools`

Floating-point comparison, range, rounding, interpolation, and sign helpers.

| Method | Description |
| --- | --- |
| `nearEquals(a, b, epsilon = 0.00001):Bool` | Checks whether the absolute difference is at most `epsilon`. |
| `clamp(float, min, max):Float` | Restricts the value to the inclusive interval `[min, max]`. |
| `roundToDecimal(float, decimals):Float` | Rounds to the requested number of decimal places. |
| `floorToDecimal(float, decimals):Float` | Rounds down to the requested number of decimal places. |
| `ceilToDecimal(float, decimals):Float` | Rounds up to the requested number of decimal places. |
| `lerp(a, b, t):Float` | Linearly interpolates from `a` to `b`, clamping `t` to `[0, 1]`. |
| `fixedLerp(a, b, t):Float` | Interpolates using a frame-time-adjusted ratio based on a 60 FPS reference. |
| `easeLerp(a, b, t, ?ease):Float` | Interpolates using a clamped progress value and an optional `EaseFunc`. |
| `fixedEaseLerp(a, b, t, ?ease):Float` | Interpolates using frame-time-adjusted progress and an optional `EaseFunc`. |
| `sign(float):Int` | Returns `1`, `-1`, or `0` according to the value's sign. |
| `min(float, other):Float` | Returns the smaller value. |
| `max(float, other):Float` | Returns the larger value. |
| `randomSign():Int` | Randomly returns `-1`, `0`, or `1`. |

`EaseFunc` is a `Float->Float` function, declared in `tools.math.EasingTools`.

## `tools.basic.IntTools`

Integer range, comparison, sign, formatting, and random helpers.

| Method | Description |
| --- | --- |
| `clamp(int, min, max):Int` | Restricts the value to the inclusive interval `[min, max]`. |
| `min(int, other):Int` | Returns the smaller integer. |
| `max(int, other):Int` | Returns the larger integer. |
| `sign(int):Int` | Returns `1`, `-1`, or `0` according to the value's sign. |
| `randomSign():Int` | Randomly returns `-1` or `1`. |
| `isEven(int):Bool` | Checks whether the integer is divisible by two. |
| `isOdd(int):Bool` | Checks whether the integer is not divisible by two. |
| `wrap(int, min, max):Int` | Wraps values below `min` to `max` and values above `max` to `min`; in-range values are unchanged. |
| `loop(int, max):Int` | Advances a zero-based index by one and wraps within a sequence of `max` items. Requires `max > 0`. |
| `between(int, min, max, inclusive = true):Bool` | Checks whether the value falls within the bounds, optionally excluding them. |
| `abs(int):Int` | Returns the absolute value. |
| `digits(int):Int` | Counts decimal digits, excluding the sign; returns `1` for zero. |
| `padLeft(int, length, char = "0"):String` | Converts the integer to text padded on the left to at least `length`. |
| `random(min, max):Int` | Returns a random integer in the inclusive range; requires `min <= max`. |

## `tools.iterables.ArrayTools`

Array retrieval, transformation, numeric, and cleanup extensions. Examples use `using tools.iterables.ArrayTools;`.

| Method | Description |
| --- | --- |
| `first<T>(array):Null<T>` | Returns the first element (or `null` for an empty array). |
| `last<T>(array):Null<T>` | Returns the last element (or `null` for an empty array). |
| `clear<T>(array):Void` | Removes all elements. With `flixel`, pops and destroys each element as a `FlxBasic`. |
| `clone<T>(array):Array<T>` | Returns a shallow copy. |
| `sum<T>(array):Null<Dynamic>` | Adds numeric elements; for a non-numeric array returns its length. Returns `null` when empty. |
| `sub<T>(array):Null<Dynamic>` | Subtracts each numeric element after the first from the first value. For a non-numeric array returns the negative length. Returns `null` when empty. |
| `nextItem<T>(array, curItem = 0, wrap = false):Null<T>` | In the current implementation, returns the first element for an index other than the last when `wrap` is true; otherwise returns `null`. At the last index it attempts to read the next index, which is out of bounds. |
| `previousItem<T>(array, curItem = 0, wrap = false):Null<T>` | At the last index, returns the preceding element. For other indexes, returns the last element only when `wrap` is true; otherwise returns `null`. |
| `isArrayOf<T>(array, type):Null<Bool>` | Checks whether all elements are instances of `type`; returns `null` when empty. |
| `removeArrayDead<T:FlxBasic>(array):Void` | With `flixel`, removes and destroys elements whose `alive` or `exists` flag is false. |
| `sample<T>(array, n):Array<T>` | Selects up to `n` random elements without replacement and leaves the source unchanged. |
| `pluck<T, V>(array, key):Array<V>` | Reads the named reflected field from each element. |
| `unique<T>(array):Array<T>` | Returns unique values in the order of their last occurrences. |
| `without<T>(array, values):Array<T>` | Returns a new array excluding values found in `values`; does not modify the source. |
| `hasItems<T>(array):Bool` | Checks whether the array contains at least one element. |
| `chunk<T>(array, size):Array<Array<T>>` | Splits the array into consecutive chunks. `size` must be greater than zero; the implementation does not validate this requirement. |

## `tools.iterables.MapTools`

Lookup, copying, transformation, and inspection extensions for `haxe.Constraints.IMap`. With `using tools.iterables.MapTools;`, call the helpers on the map.

| Method | Description |
| --- | --- |
| `getOrElse<K, V>(map, key, defaultValue):Null<V>` | Returns the mapped value, or `defaultValue` if the key is absent. |
| `getOrSet<K, V>(map, key, ?defaultFactory):Null<V>` | Returns the mapped value, or calls the optional factory for a missing key. A non-null factory result is stored; absent factory or null result is returned without insertion. |
| `merge<K, V>(map, otherMap):Map<K, V>` | Returns a copy of the entries with `otherMap` taking precedence. |
| `clone<K, V>(map):Map<K, V>` | Returns a shallow copy. |
| `invert<K, V>(map):Map<V, K>` | Swaps keys and values; duplicate values overwrite earlier entries. |
| `hasItems<K, V>(map):Bool` | Checks whether the map has at least one key. |
| `toArray<K, V, T>(map, f):Array<T>` | Converts entries with `f(key, value)`; entries with null values are skipped. |
| `keysArray<K, V>(map):Array<K>` | Returns the map keys as an array. |
| `valuesArray<K, V>(map):Array<V>` | Returns the map values as an array. |
| `removeMapDead<K, V>(map):Void` | With `flixel`, removes entries and destroys their values if all values are `FlxBasic` instances. |
| `mapValues<K, V, R>(map, f):Map<K, R>` | Returns a new map with each non-null value transformed by `f`, preserving keys. |
| `isMapKeysOf<K, V>(map, type):Null<Bool>` | Checks whether every key is an instance of `type`; returns `null` when empty. |
| `isMapValuesOf<K, V>(map, type):Null<Bool>` | Checks whether every value is an instance of `type`; returns `null` when empty. |

## `tools.math.EasingTools`

Easing functions map progress `t` to eased progress. Inputs are not automatically clamped. Families that provide a dispatcher accept `type:EasingType = InOut`; direct variants are also available.

| Dispatcher | Direct variants |
| --- | --- |
| `linear(t):Float` | Returns `t` unchanged. |
| `quad(t, type = InOut):Float` | `quadIn(t):Float`, `quadOut(t):Float`, `quadInOut(t):Float`, `quadOutIn(t):Float` |
| `cube(t, type = InOut):Float` | `cubeIn(t):Float`, `cubeOut(t):Float`, `cubeInOut(t):Float`, `cubeOutIn(t):Float` |
| `quart(t, type = InOut):Float` | `quartIn(t):Float`, `quartOut(t):Float`, `quartInOut(t):Float`, `quartOutIn(t):Float` |
| `quint(t, type = InOut):Float` | `quintIn(t):Float`, `quintOut(t):Float`, `quintInOut(t):Float`, `quintOutIn(t):Float` |
| `smoothStep(t, type = InOut):Float` | `smoothStepIn(t):Float`, `smoothStepOut(t):Float`, `smoothStepInOut(t):Float`, `smoothStepOutIn(t):Float` |
| `smootherStep(t, type = InOut):Float` | `smootherStepIn(t):Float`, `smootherStepOut(t):Float`, `smootherStepInOut(t):Float`, `smootherStepOutIn(t):Float` |
| `sine(t, type = InOut):Float` | `sineIn(t):Float`, `sineOut(t):Float`, `sineInOut(t):Float`, `sineOutIn(t):Float` |
| `bounce(t, type = InOut):Float` | `bounceIn(t):Float`, `bounceOut(t):Float`, `bounceInOut(t):Float`, `bounceOutIn(t):Float` |
| `circ(t, type = InOut):Float` | `circIn(t):Float`, `circOut(t):Float`, `circInOut(t):Float`, `circOutIn(t):Float` |
| `expo(t, type = InOut):Float` | `expoIn(t):Float`, `expoOut(t):Float`, `expoInOut(t):Float`, `expoOutIn(t):Float` |
| `back(t, type = InOut):Float` | `backIn(t):Float`, `backOut(t):Float`, `backInOut(t):Float`, `backOutIn(t):Float` |
| `elastic(t, type = InOut):Float` | `elasticIn(t):Float`, `elasticOut(t):Float`, `elasticInOut(t):Float`, `elasticOutIn(t):Float` |

`fromString(ease, ?type):Null<EaseFunc>` looks up a function by family name and optional direction, ignoring case and surrounding whitespace. It returns `null` for unknown names. `EaseFunc` is `Float->Float`; `EaseFuncWithType` is `(Float, EasingType)->Float`. `EasingType` is an abstract string enum with `In`, `Out`, `InOut`, and `OutIn`.

## `tools.math.GeomTools`

Basic two-dimensional geometry helpers.

| Method | Description |
| --- | --- |
| `distance(x1, y1, x2, y2):Float` | Euclidean distance between two points. |
| `distanceSq(x1, y1, x2, y2):Float` | Squared Euclidean distance, without a square root. |
| `angleBetween(x1, y1, x2, y2):Float` | Angle from the first point to the second, in radians. |
| `pointInRect(px, py, rx, ry, rw, rh):Bool` | Checks whether a point is inside or on the boundary of an axis-aligned rectangle. |
| `circleOverlap(x1, y1, r1, x2, y2, r2):Bool` | Checks whether two circles overlap or touch. |

## `tools.math.TimeTools`

Time formatting and unit conversions.

| Method | Description |
| --- | --- |
| `formatTime(seconds, showMs = false):String` | Formats a duration as `MM:SS`, `H:MM:SS` when at least an hour, and optionally appends milliseconds. Negative durations are treated as zero. |
| `toMs(seconds):Float` | Converts seconds to milliseconds. |
| `toSeconds(minutes):Float` | Converts minutes to seconds. |
| `toMinutes(time, isHours = false):Float` | Converts seconds to minutes when `isHours` is false, or hours to minutes when true. |

## `tools.special.ColorTools`

Color values use packed ARGB integers: alpha in bits 24-31, then red, green, and blue channels.

| Method | Description |
| --- | --- |
| `lerpColor(color1, color2, ratio):Int` | Interpolates channels with the supplied ratio directly; each output channel is clamped to `0-255`. |
| `fixedLerpColor(color1, color2, ratio):Int` | Interpolates with a frame-time-adjusted ratio clamped to `[0, 1]`. |
| `easeLerpColor(color1, color2, ratio, ?ease):Int` | Interpolates with an optional easing function applied to the ratio. |
| `fixedEaseLerpColor(color1, color2, ratio, ?ease):Int` | Uses frame-time-adjusted progress and an optional easing function. |
| `fromRgb(r, g, b):Int` | Packs clamped channels into an opaque ARGB color. |
| `getAlpha(color):Float` | Reads the alpha channel (`0-255`). |
| `getRed(color):Float` | Reads the red channel (`0-255`). |
| `getGreen(color):Float` | Reads the green channel (`0-255`). |
| `getBlue(color):Float` | Reads the blue channel (`0-255`). |
| `toString(color):String` | Returns the decimal string representation of the integer. |

The two `fixed*` methods use `tools.utils.FPSUtil`. `EaseFunc` is declared in `tools.math.EasingTools`.

## `tools.special.EnumTools`

Reflection helpers for enum types and values.

| Method | Description |
| --- | --- |
| `getNames<T>(e:Enum<T>):Array<String>` | Returns constructor names, or an empty array for a null enum. |
| `fromString<T>(e, name, ?defaultValue):Null<T>` | Creates the named constructor, or returns `defaultValue` when it is invalid. |
| `fromIndex<T>(e, index, ?defaultValue):Null<T>` | Creates the constructor at the zero-based index, or returns the default for an invalid index. |
| `toIndex(enumValue):Int` | Returns the constructor index, or `-1` for a null value. |
| `toString(enumValue):String` | Returns the constructor name, or an empty string for a null value. |
| `getAllValues<T>(e:Enum<T>):Array<T>` | Creates constructors that take no arguments; constructors requiring arguments are skipped. |

## `tools.special.StringTools`

String checking, transformation, and case formatting. `CaseType` is an enum with `Lower` and `Upper`.

| Method | Description |
| --- | --- |
| `isBlank(str):Bool` | Checks whether the string is null, empty, or whitespace-only. |
| `truncate(str, maxLength, suffix = "..."):String` | Returns the original if it fits, empty for non-positive `maxLength`, or the first `maxLength - 1` characters followed by `suffix`. |
| `reverse(str):String` | Returns the characters in reverse order. |
| `stripPrefix(str, prefix):String` | Removes the prefix if the string starts with it. |
| `stripSuffix(str, suffix):String` | Removes the suffix if the string ends with it. |
| `toTitleCase(str):String` | Converts whitespace-, hyphen-, and underscore-separated words to title case. |
| `toCamelCase(str, type = Lower):String` | Converts separated words to camel case; `type` controls the first word's case. |
| `toKebabCase(str, type = Lower):String` | Joins normalized words with hyphens and applies lower or upper case. |
| `toSnakeCase(str, type = Lower):String` | Joins normalized words with underscores and applies lower or upper case. |

## `tools.utils.FPSUtil`

Frame time and frame-rate-adjusted interpolation helpers.

| Method | Description |
| --- | --- |
| `getDeltaTime():Float` | Returns frame duration in seconds from Flixel, HaxePunk, Ceramic, or Heaps when the corresponding define is enabled; defaults to `1/60`. |
| `getFPSRatio(ratio, ?delta):Float` | Adjusts a ratio based on a 60 FPS reference and the supplied delta, or the current frame delta when omitted. |
