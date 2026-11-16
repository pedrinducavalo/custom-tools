# API Reference

This reference covers the public utilities, abstracts, structs, and interfaces currently in `tools/`.

## Modules and aliases

| Type | Module | Category alias |
| --- | --- | --- |
| `BoolTools` | `tools.classes.extensions.basic.BoolTools` | `tools.classes.Extensions.BoolTools` |
| `FloatTools` | `tools.classes.extensions.basic.FloatTools` | `tools.classes.Extensions.FloatTools` |
| `IntTools` | `tools.classes.extensions.basic.IntTools` | `tools.classes.Extensions.IntTools` |
| `ArrayTools` | `tools.classes.extensions.iterables.ArrayTools` | `tools.classes.Extensions.ArrayTools` |
| `MapTools` | `tools.classes.extensions.iterables.MapTools` | `tools.classes.Extensions.MapTools` |
| `MathTools` | `tools.classes.functions.math.MathTools` | `tools.classes.Functions.MathTools` |
| `EasingTools` | `tools.classes.functions.math.EasingTools` | `tools.classes.Functions.EasingTools` |
| `GeomTools` | `tools.classes.functions.math.GeomTools` | `tools.classes.Functions.GeomTools` |
| `TimeTools` | `tools.classes.functions.math.TimeTools` | `tools.classes.Functions.TimeTools` |
| `KinematicsTools` | `tools.classes.functions.physics.KinematicsTools` | `tools.classes.Functions.KinematicsTools` |
| `DynamicsTools` | `tools.classes.functions.physics.DynamicsTools` | `tools.classes.Functions.DynamicsTools` |
| `EnergyTools` | `tools.classes.functions.physics.EnergyTools` | `tools.classes.Functions.EnergyTools` |
| `MemoryTools` | `tools.classes.functions.memory.MemoryTools` | `tools.classes.Functions.MemoryTools` |
| `BytesTools` | `tools.classes.functions.memory.BytesTools` | `tools.classes.Functions.BytesTools` |
| `ObjectPoolTools` | `tools.classes.functions.memory.ObjectPoolTools` | `tools.classes.Functions.ObjectPoolTools` |
| `ColorTools` | `tools.classes.extensions.special.ColorTools` | `tools.classes.Extensions.ColorTools` |
| `EnumTools` | `tools.classes.extensions.special.EnumTools` | `tools.classes.Extensions.EnumTools` |
| `StringTools` | `tools.classes.extensions.special.StringTools` | `tools.classes.Extensions.StringTools` |
| `SpriteTools` | `tools.classes.extensions.backend.SpriteTools` | `tools.classes.Extensions.SpriteTools` (framework define required) |
| `Color` | `tools.abstracts.Color` | `tools.Abstracts.Color` |
| `Easing` | `tools.abstracts.Easing` | `tools.Abstracts.Easing` |
| `IDestroyable` | `tools.interfaces.IDestroyable` | `tools.Interfaces.IDestroyable` |
| `IPositionable` | `tools.interfaces.IPositionable` | `tools.Interfaces.IPositionable` |
| `IResettable` | `tools.interfaces.IResettable` | `tools.Interfaces.IResettable` |
| `IUpdatable` | `tools.interfaces.IUpdatable` | `tools.Interfaces.IUpdatable` |
| `FPSUtil` | `tools.utils.FPSUtil` | `tools.Utils.FPSUtil` |
| `Vector2` | `tools.classes.structs.Vector2` | `tools.classes.Structs.Vector2` |
| `Size2` | `tools.classes.structs.Size2` | `tools.classes.Structs.Size2` |
| `Rect` | `tools.classes.structs.Rect` | `tools.classes.Structs.Rect` |

Use extension methods with `using`, for example `using tools.classes.extensions.basic.FloatTools;`. Call static functions and data types from their module paths, such as `import tools.classes.functions.math.GeomTools;` or `import tools.classes.structs.Vector2;`. Category aliases are exposed by `tools.classes.Extensions`, `tools.classes.Functions`, `tools.classes.Structs`, `tools.Abstracts`, `tools.Interfaces`, and `tools.Utils`. `NativeSprite` and `SpriteTools` are only available with their corresponding framework defines.

## Recommended project `import.hx`

For project-wide imports and extension methods, copy [`tools/import.hx`](tools/import.hx) to an `import.hx` file in your project root, alongside the Haxe build file. The template imports the library's common types and enables its extensions across the project; `SpriteTools` is included only when a supported framework define is active.

## `tools.classes.extensions.basic.BoolTools`

Boolean conversion, logic, selection, and conditional-action helpers. Use with `using tools.classes.extensions.basic.BoolTools;`.

| Method | Description |
| --- | --- |
| `int(bool):Int` | Converts `true` to `1` and `false` to `0`. |
| `toggle(bool):Bool` | Returns the opposite boolean value. |
| `xor(bool, other):Bool` | Returns `true` when the values differ. |
| `xnor(bool, other):Bool` | Returns `true` when the values are equal. |
| `nand(bool, other):Bool` | Returns the negation of the logical AND. |
| `nor(bool, other):Bool` | Returns `true` only when both values are `false`. |
| `implies(bool, other):Bool` | Returns `false` only when the first value is `true` and the second is `false`. |
| `choose<T>(bool, whenTrue, whenFalse):T` | Selects a value based on the boolean. |
| `float(bool):Float` | Converts `true` to `1.0` and `false` to `0.0`. |
| `fromInt(int):Bool` | Converts zero to `false` and any nonzero integer to `true`. |
| `when(bool, action):Void` | Runs `action` only when the boolean is `true`. |
| `unless(bool, action):Void` | Runs `action` only when the boolean is `false`. |
| `string(bool, ?yes, ?no):String` | Uses custom text when both `yes` and `no` are given; otherwise returns the standard boolean string. |

## `tools.classes.extensions.basic.FloatTools`

Floating-point comparison, range, rounding, interpolation, and sign helpers.

| Method | Description |
| --- | --- |
| `clamp(float, min, max):Float` | Restricts the value to the inclusive interval `[min, max]`. |
| `roundToDecimal(float, decimals):Float` | Rounds to the requested number of decimal places. |
| `floorToDecimal(float, decimals):Float` | Rounds down to the requested number of decimal places. |
| `ceilToDecimal(float, decimals):Float` | Rounds up to the requested number of decimal places. |
| `lerp(a, b, t):Float` | Linearly interpolates from `a` to `b`, clamping `t` to `[0, 1]`. |
| `fixedLerp(a, b, t):Float` | Interpolates using a frame-time-adjusted ratio based on a 60 FPS reference. |
| `easeLerp(a, b, t, ?ease):Float` | Interpolates using clamped progress and an optional `EaseFunc`. |
| `fixedEaseLerp(a, b, t, ?ease):Float` | Interpolates using frame-time-adjusted progress and an optional `EaseFunc`. |
| `sign(float):Int` | Returns `1`, `-1`, or `0` according to the value's sign. |
| `randomSign():Int` | Randomly returns `-1`, `0`, or `1`. |

`EaseFunc` is declared in `tools.classes.functions.math.EasingTools`.

## `tools.classes.extensions.basic.IntTools`

Integer range, comparison, sign, formatting, and random helpers.

| Method | Description |
| --- | --- |
| `clamp(int, min, max):Int` | Restricts the value to the inclusive interval `[min, max]`. |
| `sign(int):Int` | Returns `1`, `-1`, or `0` according to the value's sign. |
| `randomSign():Int` | Randomly returns `-1` or `1`. |
| `isEven(int):Bool` | Checks whether the integer is divisible by two. |
| `isOdd(int):Bool` | Checks whether the integer is not divisible by two. |
| `wrap(int, min, max):Int` | Wraps values below `min` to `max` and above `max` to `min`; in-range values are unchanged. |
| `loop(int, max):Int` | Advances a zero-based index by one and wraps within a sequence of `max` items. Requires `max > 0`. |
| `between(int, min, max, inclusive = true):Bool` | Checks whether the value falls within the bounds, optionally excluding them. |
| `abs(int):Int` | Returns the absolute value. |
| `digits(int):Int` | Counts decimal digits, excluding the sign; returns `1` for zero. |
| `padLeft(int, length, char = "0"):String` | Converts the integer to text padded on the left to at least `length`. |
| `random(min, max):Int` | Returns a random integer in the inclusive range; requires `min <= max`. |

## `tools.classes.extensions.iterables.ArrayTools`

Array retrieval, transformation, numeric, and cleanup extensions. Use with `using tools.classes.extensions.iterables.ArrayTools;`.

| Method | Description |
| --- | --- |
| `first<T>(array):Null<T>` | Returns the first element, or `null` for an empty array. |
| `last<T>(array):Null<T>` | Returns the last element, or `null` for an empty array. |
| `clear<T>(array):Void` | Removes all elements. With `flixel`, pops and destroys each element as a `FlxBasic`. |
| `clone<T>(array):Array<T>` | Returns a shallow copy. |
| `sum<T>(array):Null<Dynamic>` | Adds numeric elements; returns the length for a non-numeric array and `null` when empty. |
| `sub<T>(array):Null<Dynamic>` | Subtracts each numeric element after the first from the first value; for a non-numeric array returns its negative length. Returns `null` when empty. |
| `nextItem<T>(array, curItem = 0, wrap = false):Null<T>` | Returns the next item, wraps to the first at the end when requested, or returns `null` for an empty array, invalid index, or non-wrapped end. |
| `previousItem<T>(array, curItem = 0, wrap = false):Null<T>` | Returns the previous item, wraps to the last at the start when requested, or returns `null` for an empty array, invalid index, or non-wrapped start. |
| `isArrayOf<T>(array, type):Null<Bool>` | Checks whether all elements are instances of `type`; returns `null` when empty. |
| `removeArrayDead<T:FlxBasic>(array):Void` | With `flixel`, removes and destroys elements whose `alive` or `exists` flag is false. |
| `sample<T>(array, n):Array<T>` | Selects up to `n` random elements without replacement and leaves the source unchanged. |
| `pluck<T, V>(array, key):Array<V>` | Reads the named reflected field from each element. |
| `unique<T>(array):Array<T>` | Returns unique values in the order of their last occurrences. |
| `without<T>(array, values):Array<T>` | Returns a new array excluding values found in `values`; does not modify the source. |
| `hasItems<T>(array):Bool` | Checks whether the array contains at least one element. |
| `chunk<T>(array, size):Array<Array<T>>` | Splits the array into consecutive chunks; throws an error when `size <= 0`. |

## `tools.classes.extensions.iterables.MapTools`

Lookup, copying, transformation, and inspection extensions for `haxe.Constraints.IMap`.

| Method | Description |
| --- | --- |
| `getOrElse<K, V>(map, key, defaultValue):Null<V>` | Returns the mapped value, or `defaultValue` if the key is absent. |
| `getOrSet<K, V>(map, key, ?defaultFactory):Null<V>` | Returns the mapped value, or invokes the optional factory for a missing key. Only non-null results are stored. |
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

## `tools.classes.functions.math.EasingTools`

Easing functions map progress `t` to eased progress; inputs are not automatically clamped. Direction dispatchers default to `InOut`.

| Family dispatcher | Direct variants |
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

All direct variants accept a single `Float` and return a `Float`. `fromString(ease, ?type):Null<EaseFunc>` looks up a function by family and optional direction, ignoring case and surrounding whitespace; unknown names return `null`. `EaseFunc` is `Float->Float`; `EaseFuncWithType` is `(Float, EasingType)->Float`. `EasingType` is an abstract string enum with `In`, `Out`, `InOut`, and `OutIn`.

## `tools.classes.functions.math.GeomTools`

Basic two-dimensional geometry helpers.

| Method | Description |
| --- | --- |
| `distance(x1, y1, x2, y2):Float` | Euclidean distance between two points. |
| `distanceSq(x1, y1, x2, y2):Float` | Squared Euclidean distance, without a square root. |
| `angleBetween(x1, y1, x2, y2):Float` | Angle from the first point to the second, in radians. |
| `pointInRect(px, py, rx, ry, rw, rh):Bool` | Checks whether a point is inside or on the boundary of an axis-aligned rectangle. |
| `circleOverlap(x1, y1, r1, x2, y2, r2):Bool` | Checks whether two circles overlap or touch. |

## `tools.classes.functions.math.MathTools`

Variadic numeric helpers and compile-time min/max macros.

| Method | Description |
| --- | --- |
| `nearEquals(a, b, epsilon = 0.00001):Bool` | Checks whether the absolute difference between two values is at most `epsilon`. |
| `min(values...):Float` | Returns the smallest supplied value; provide at least one value. |
| `max(values...):Float` | Returns the largest supplied value; provide at least one value. |
| `fastMin(values...):Expr` | Macro that expands to a comparison expression for the smallest supplied value. |
| `fastMax(values...):Expr` | Macro that expands to a comparison expression for the largest supplied value. |

`fastMin` and `fastMax` run at compile time and are not available in runtime-interpreted environments such as HScript or Lua. With no arguments, they expand to positive and negative infinity respectively.

## `tools.classes.functions.math.TimeTools`

Time formatting and unit conversions.

| Method | Description |
| --- | --- |
| `formatTime(seconds, showMs = false):String` | Formats a duration as `MM:SS`, `H:MM:SS` when at least an hour, and optionally appends milliseconds. Negative durations are treated as zero. |
| `formatDate(day, month, year, locale = "en-US"):String` | Formats a numeric date using locale conventions: `en-US` uses month/day/year, Japanese or Chinese locales use year/month/day with slashes, Korean uses year.month.day, German/Russian use dots, and other locales use day/month/year with slashes. |
| `toMs(seconds):Float` | Converts seconds to milliseconds. |
| `toSeconds(time, inMs = false):Float` | Converts minutes to seconds, or milliseconds to seconds when `inMs` is true. |
| `toMinutes(time, isHours = false):Float` | Converts seconds to minutes, or hours to minutes when `isHours` is true. |

## `tools.classes.functions.physics.KinematicsTools`

One-dimensional constant-acceleration calculations.

| Method | Description |
| --- | --- |
| `velocityAfter(initialVelocity, acceleration, time):Float` | Calculates final velocity under constant acceleration. |
| `displacement(initialVelocity, acceleration, time):Float` | Calculates displacement under constant acceleration. |
| `averageVelocity(displacement, time):Float` | Calculates displacement divided by elapsed time; throws if `time == 0`. |

## `tools.classes.functions.physics.DynamicsTools`

Basic force and momentum calculations.

| Method | Description |
| --- | --- |
| `force(mass, acceleration):Float` | Calculates force as mass times acceleration. |
| `acceleration(force, mass):Float` | Calculates acceleration; throws if `mass == 0`. |
| `momentum(mass, velocity):Float` | Calculates linear momentum. |
| `impulse(force, time):Float` | Calculates impulse for a constant force over a time interval. |

## `tools.classes.functions.physics.EnergyTools`

Work, energy, and power calculations.

| Method | Description |
| --- | --- |
| `kineticEnergy(mass, velocity):Float` | Calculates kinetic energy. |
| `potentialEnergy(mass, gravity, height):Float` | Calculates gravitational potential energy relative to a reference height. |
| `work(force, displacement, angleRadians = 0):Float` | Calculates work from force, displacement, and their angle in radians. |
| `power(work, time):Float` | Calculates average power; throws if `time <= 0`. |

## `tools.classes.functions.memory.MemoryTools`

Binary memory-size conversion, formatting, and alignment helpers. Size formatting uses binary units (KiB, MiB, GiB, TiB).

| Method | Description |
| --- | --- |
| `bytesToKilobytes(bytes):Float` | Converts bytes to kibibytes using a 1024-byte base. |
| `kilobytesToBytes(kilobytes):Float` | Converts kibibytes to bytes. |
| `bytesToMegabytes(bytes):Float` | Converts bytes to mebibytes. |
| `megabytesToBytes(megabytes):Float` | Converts mebibytes to bytes. |
| `bytesToGigabytes(bytes):Float` | Converts bytes to gibibytes. |
| `gigabytesToBytes(gigabytes):Float` | Converts gibibytes to bytes. |
| `formatBytes(bytes, decimals = 2):String` | Formats a non-negative size using binary units; decimal places must be 0–10. |
| `alignUp(bytes, alignment):Int` | Rounds a non-negative byte count up to a positive alignment. |
| `alignDown(bytes, alignment):Int` | Rounds a non-negative byte count down to a positive alignment. |
| `isAligned(bytes, alignment):Bool` | Checks whether a non-negative byte count is a multiple of a positive alignment. |

## `tools.classes.functions.memory.BytesTools`

| Method | Description |
| --- | --- |
| `copy(bytes):Bytes` | Returns a copy of a byte sequence. |
| `concat(values):Bytes` | Concatenates byte sequences in order. |
| `fill(bytes, value):Void` | Fills bytes in place with a value from 0 to 255. |
| `equals(a, b):Bool` | Checks whether two byte sequences have identical contents. |
| `indexOf(bytes, pattern, start = 0):Int` | Finds the first occurrence of a byte sequence, or returns `-1`. |
| `toHex(bytes):String` | Encodes bytes as lowercase hexadecimal text. |
| `fromHex(hex):Bytes` | Decodes hexadecimal text into bytes. |

## `tools.classes.functions.memory.ObjectPoolTools`

Array-backed object reuse helpers. A pool is represented by `Array<T>`.

| Method | Description |
| --- | --- |
| `create<T>():Array<T>` | Creates an empty pool. |
| `acquire<T>(pool, factory):T` | Retrieves a pooled object or creates one when empty. |
| `release<T>(pool, item, maxSize = -1):Bool` | Adds an item unless the optional pool capacity is reached. |
| `releaseMany<T>(pool, items, maxSize = -1):Int` | Adds as many items as capacity allows without changing `items`. |
| `trim<T>(pool, maxSize):Int` | Removes excess items until the pool fits the maximum size. |
| `clear<T>(pool):Void` | Removes all pooled items. |
| `size<T>(pool):Int` | Returns the number of stored items. |
| `hasItems<T>(pool):Bool` | Checks whether the pool is non-empty. |

## `tools.classes.extensions.special.ColorTools`

Color utilities use packed ARGB integers: alpha, red, green, then blue.

| Method | Description |
| --- | --- |
| `lerpColor(color1, color2, ratio):Int` | Interpolates channels with the supplied ratio directly; output channels are clamped to `0-255`. |
| `fixedLerpColor(color1, color2, ratio):Int` | Interpolates with a frame-time-adjusted ratio clamped to `[0, 1]`. |
| `easeLerpColor(color1, color2, ratio, ?ease):Int` | Interpolates with an optional easing function applied to the ratio. |
| `fixedEaseLerpColor(color1, color2, ratio, ?ease):Int` | Uses frame-time-adjusted progress and an optional easing function. |
| `fromRgb(r, g, b):Int` | Packs clamped channels into an opaque ARGB color. |
| `getAlpha(color):Float` | Reads the alpha channel (`0-255`). |
| `getRed(color):Float` | Reads the red channel (`0-255`). |
| `getGreen(color):Float` | Reads the green channel (`0-255`). |
| `getBlue(color):Float` | Reads the blue channel (`0-255`). |
| `toString(color):String` | Returns the decimal string representation of the integer. |

Fixed interpolation methods use `tools.utils.FPSUtil`; easing methods use `EaseFunc` from `tools.classes.functions.math.EasingTools`.

## `tools.classes.extensions.special.EnumTools`

Reflection helpers for enum types and values.

| Method | Description |
| --- | --- |
| `getNames<T>(e:Enum<T>):Array<String>` | Returns constructor names, or an empty array for a null enum. |
| `fromString<T>(e, name, ?defaultValue):Null<T>` | Creates the named constructor, or returns `defaultValue` when it is invalid. |
| `fromIndex<T>(e, index, ?defaultValue):Null<T>` | Creates the constructor at the zero-based index, or returns the default for an invalid index. |
| `toIndex(enumValue):Int` | Returns the constructor index, or `-1` for a null value. |
| `toString(enumValue):String` | Returns the constructor name, or an empty string for a null value. |
| `getAllValues<T>(e:Enum<T>):Array<T>` | Creates constructors that take no arguments; constructors requiring arguments are skipped. |

## `tools.classes.extensions.special.StringTools`

String checking, transformation, and case formatting. `CaseType` has `Lower` and `Upper` values.

| Method | Description |
| --- | --- |
| `isBlank(str):Bool` | Checks whether the string is null, empty, or whitespace-only. |
| `truncate(str, maxLength, suffix = "..."):String` | Returns the original if it fits, empty for non-positive `maxLength`, or the first `maxLength - 1` characters followed by `suffix`. The suffix can make the result longer than `maxLength`. |
| `reverse(str):String` | Returns the characters in reverse order. |
| `stripPrefix(str, prefix):String` | Removes the prefix if the string starts with it. |
| `stripSuffix(str, suffix):String` | Removes the suffix if the string ends with it. |
| `toTitleCase(str):String` | Converts whitespace-, hyphen-, and underscore-separated words to title case. |
| `toCamelCase(str, type = Lower):String` | Converts separated words to camel case; `type` controls the first word's case. |
| `toKebabCase(str, type = Lower):String` | Joins normalized words with hyphens and applies lower or upper case. |
| `toSnakeCase(str, type = Lower):String` | Joins normalized words with underscores and applies lower or upper case. |

## `tools.classes.extensions.backend.SpriteTools`

`SpriteTools` is available when compiling with a supported framework define. Flixel uses `flixel.FlxSprite`, OpenFL uses `openfl.display.Sprite`, Heaps uses `h2d.Object`, and Ceramic uses `ceramic.Visual`. `NativeSprite` aliases the corresponding framework type where one is defined.

| Method | Description |
| --- | --- |
| `blink(sprite, elapsedTime, frequency):Void` | Applies a 50%-duty blink based on elapsed time. A non-positive frequency leaves the sprite visible. |
| `flashColor(sprite, color, duration):Void` | On Flixel, tweens from the current color to the flash color and back using the framework's color representation. |
| `flashColor(sprite, color, elapsedTime, duration):Void` | On OpenFL and Heaps, updates the color flash for the current frame; call with elapsed time since the effect began. Heaps requires an `h2d.Drawable`. |
| `flashColor(quad, color, duration):Void` | On Ceramic, tweens a `ceramic.Quad` from its current color and back using Ceramic's color representation. |
| `setVisible(sprite, visible):Void` | Sets sprite visibility. |
| `setAlpha(sprite, alpha):Void` | Sets opacity, clamped to `[0, 1]`. |
| `setPosition(sprite, x, y):Void` | Sets the sprite position. |
| `moveBy(sprite, x, y):Void` | Moves the sprite by an offset. |
| `setScale(sprite, x, y):Void` | Sets horizontal and vertical scale; Flixel also updates the hitbox. |
| `setRotation(sprite, degrees):Void` | Sets rotation in degrees; Heaps converts to radians internally. |
| `setFlipX(sprite, flipped):Void` | Enables or disables horizontal flipping. |
| `setFlipY(sprite, flipped):Void` | Enables or disables vertical flipping. |

When compiling with `kha`, the class instead provides image drawing helpers because Kha does not have a mutable sprite object:

| Method | Description |
| --- | --- |
| `drawAt(graphics, image, x, y):Void` | Draws an image at a position. |
| `drawCentered(graphics, image, x, y):Void` | Draws an image centered on a position. |
| `drawOffset(graphics, image, x, y, offsetX, offsetY):Void` | Draws an image with an additional offset. |
| `drawWithAlpha(graphics, image, x, y, alpha):Void` | Draws an image with the supplied opacity. |
| `drawScaled(graphics, image, x, y, scaleX, scaleY):Void` | Draws an image with independent horizontal and vertical scales. |
| `drawRotated(graphics, image, x, y, angle):Void` | Draws a rotated image; `angle` is in radians. |
| `drawFlipped(graphics, image, x, y, horizontal, vertical):Void` | Draws an image with optional horizontal and vertical flipping. |
| `drawTinted(graphics, image, x, y, color):Void` | Draws an image tinted with a Kha color. |
| `drawFlashColor(graphics, image, x, y, color, elapsedTime, duration):Void` | Draws a frame-driven color flash; call while drawing each frame. |
| `blink(graphics, image, x, y, elapsedTime, frequency):Void` | Draws the image on alternating intervals; a non-positive frequency draws it normally. |

## `tools.classes.structs.Vector2`

A mutable two-dimensional vector with methods that return new vectors for arithmetic and transforms.

| Member | Description |
| --- | --- |
| `x:Float`, `y:Float` | Public mutable components. |
| `new(x:Float = 0, y:Float = 0)` | Creates a vector with the supplied coordinates. |
| `zero:Vector2` | Shared mutable zero vector. Avoid mutating it if using it as a zero constant. |
| `copy():Vector2` | Returns a copy. |
| `add(other:Vector2):Vector2` | Returns the component-wise sum. |
| `subtract(other:Vector2):Vector2` | Returns the component-wise difference. |
| `scale(factor:Float):Vector2` | Returns a scalar-multiplied vector. |
| `dot(other:Vector2):Float` | Calculates the dot product. |
| `lengthSq():Float` | Calculates the squared length without a square root. |
| `length():Float` | Calculates vector length. |
| `normalized():Vector2` | Returns a unit vector in the same direction, or a zero vector for zero length. |
| `rotated(radians:Float):Vector2` | Returns a counterclockwise-rotated vector. |
| `distanceTo(other:Vector2):Float` | Calculates the distance to another vector. |

## `tools.classes.structs.Size2`

A mutable two-dimensional size.

| Member | Description |
| --- | --- |
| `width:Float`, `height:Float` | Public mutable dimensions. |
| `new(width:Float = 0, height:Float = 0)` | Creates a size. |
| `area():Float` | Returns `width * height`. |
| `isEmpty():Bool` | Returns true if either dimension is zero or negative. |
| `scale(factor:Float):Size2` | Returns a new size multiplied by `factor`. |
| `fitsWithin(bounds:Size2):Bool` | Checks whether both dimensions fit within another size. |

## `tools.classes.structs.Rect`

An axis-aligned rectangle with a mutable position and dimensions.

| Member | Description |
| --- | --- |
| `x:Float`, `y:Float`, `width:Float`, `height:Float` | Public mutable position and dimensions. |
| `new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)` | Creates a rectangle from its top-left corner and dimensions. |
| `containsPoint(point:Vector2):Bool` | Checks whether a point lies inside or on the rectangle boundary. |
| `intersects(other:Rect):Bool` | Checks whether rectangles overlap or share an edge. |
| `center():Vector2` | Returns the center point. |

## `tools.abstracts.Color`

An abstract ARGB color backed by `Int`, implicitly convertible from and to `Int` and `UInt`.

| Member | Description |
| --- | --- |
| `new(value:Int)` | Wraps a packed ARGB integer. |
| `TRANSPARENT`, `BLACK`, `WHITE`, `RED`, `GREEN`, `BLUE`, `YELLOW`, `CYAN`, `MAGENTA`, `ORANGE`, `PURPLE`, `PINK`, `BROWN`, `GRAY`, `LIGHT_GRAY`, `DARK_GRAY`, `NAVY`, `TEAL`, `LIME`, `MAROON`, `OLIVE`, `SILVER`, `GOLD`, `CORAL`, `TURQUOISE`, `INDIGO`, `VIOLET` | Static opaque color presets, except `TRANSPARENT` which has zero alpha. |
| `rgb:Int`, `alpha:Int`, `red:Int`, `green:Int`, `blue:Int` | Mutable ARGB color channels; `rgb` reads and writes the lower 24 bits. |
| `hue:Float`, `saturation:Float`, `brightness:Float`, `lightness:Float` | Mutable HSV/HSL components; hue is in degrees, saturation/value/brightness/lightness are normalized to `[0, 1]`. |
| `normalizedAlpha:Float`, `normalizedRed:Float`, `normalizedGreen:Float`, `normalizedBlue:Float` | Mutable normalized channels in `[0, 1]`. |
| `fromRgb(red:Int, green:Int, blue:Int):Color` | Creates an opaque color with channels clamped to `0-255`. |
| `fromArgb(alpha:Int, red:Int, green:Int, blue:Int):Color` | Creates a color with all channels clamped to `0-255`. |
| `withAlpha(value:Int):Color` | Returns a copy with the alpha channel replaced and clamped to `0-255`. |
| `fromString(value:String):Color` | Parses a decimal ARGB integer. |
| `toString():String` | Returns the decimal ARGB integer representation. |

The preset names `MAGENTA` and `PINK` have their packed values reversed from the conventional colors: `MAGENTA` is pink (`0xFFFFC0CB`) and `PINK` is magenta (`0xFFFF00FF`).

## `tools.abstracts.Easing`

A callable abstract around `Float->Float`, implicitly convertible to and from that function type.

| Member | Description |
| --- | --- |
| `apply(progress:Float):Float` | Calls the wrapped easing function. The abstract is callable using function-call syntax. |

## `tools.interfaces`

Small interfaces for common object capabilities.

| Interface | Contract |
| --- | --- |
| `IDestroyable` | Implements `destroy():Void`. |
| `IPositionable` | Exposes mutable `x:Float` and `y:Float` properties. |
| `IResettable` | Implements `reset():Void`. |
| `IUpdatable` | Implements `update(deltaTime:Float):Void`; `deltaTime` is elapsed seconds. |

## `tools.utils.FPSUtil`

Frame time and frame-rate-adjusted interpolation helpers.

| Method | Description |
| --- | --- |
| `getDeltaTime():Float` | Returns frame duration in seconds from Flixel, HaxePunk, Ceramic, or Heaps when the corresponding define is enabled; defaults to `1/60`. |
| `getFPSRatio(ratio, ?delta):Float` | Adjusts a ratio based on a 60 FPS reference and the supplied delta, or the current frame delta when omitted. |
