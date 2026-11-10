# custom-tools

`custom-tools` is a collection of Haxe extension methods and helpers for common data, math, and gameplay tasks. Version 0.2.0 reorganizes the library into focused packages and adds easing, geometry, time, and string utilities alongside the existing array, map, enum, boolean, integer, float, and color helpers.

## Installation

Install the published haxelib:

```bash
haxelib install custom-tools
```

To use a local checkout during development:

```bash
haxelib dev custom-tools .
```

## Using the library

Import only the helpers you need with Haxe's `using` syntax. For example, this combines collection operations, numeric interpolation, easing, geometry, and time formatting:

```haxe
using tools.basic.FloatTools;
using tools.iterables.ArrayTools;
using tools.math.EasingTools;
using tools.math.GeomTools;
using tools.math.TimeTools;

class Main {
    static function main() {
        var samples = [12.5, 40.0, 75.0, 100.0];
        var visible = samples.without([40.0]).chunk(2);
        trace(visible); // [[12.5, 75.0], [100.0]]

        var progress = 0.65;
        var eased = FloatTools.easeLerp(0, 100, progress, EasingTools.sineOut);
        trace(eased);

        var distance = GeomTools.distance(0, 0, 3, 4);
        trace(distance); // 5

        trace(TimeTools.formatTime(125.25, true)); // 02:05.250
    }
}
```

Utilities are organized by purpose:

| Package | Contents |
| --- | --- |
| `tools.basic` | Boolean, integer, and floating-point helpers. |
| `tools.iterables` | Array and map extensions. |
| `tools.math` | Easing curves, geometry operations, and time formatting/conversions. |
| `tools.special` | Color, enum reflection, and string helpers. |
| `tools.utils` | Frame-time utilities used by frame-adjusted interpolation. |

Version 0.2.0 changes the module paths from the earlier flat `tools.*` layout. Update imports to the corresponding subpackage paths. `tools.Tools` also declares typedef aliases for the public helper classes; see [API.md](./API.md) for module paths and the complete reference.

## HaxeFlixel support

When compiled with the `flixel` define, `ArrayTools.clear()` destroys each popped element, `ArrayTools.removeArrayDead()` removes and destroys inactive or nonexistent `FlxBasic` values, and `MapTools.removeMapDead()` removes and destroys map values when all of them are `FlxBasic` instances. `FPSUtil` also reads the current frame time from supported framework timers when their defines are enabled.

## Lambda compatibility

`ArrayTools.find()`, `ArrayTools.flatten()`, and `MapTools.filter()` were removed in version 0.1.0 because their names conflict with Haxe's standard `Lambda` extensions. Use `using Lambda;` for those operations.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
