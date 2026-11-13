# custom-tools

`custom-tools` is a collection of Haxe utilities and reusable building blocks for data, math, physics, and gameplay. It includes extension helpers for common types, geometry and physics calculations, data classes, lifecycle interfaces, and typed color and easing abstracts.

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

Import only the helpers and types you need. This example combines collection extensions, interpolation, geometry, physics, and typed values:

```haxe
import tools.abstracts.Color;
import tools.classes.basic.FloatTools;
import tools.classes.math.EasingTools;
import tools.classes.physics.KinematicsTools;
import tools.classes.structs.Vector2;

using tools.classes.iterables.ArrayTools;
using tools.classes.special.StringTools;

class Main {
    static function main() {
        var readings = [12.5, 40.0, 75.0, 100.0];
        var groups = readings.without([40.0]).chunk(2);
        trace(groups); // [[12.5, 75.0], [100.0]]

        var progress = FloatTools.easeLerp(0, 100, 0.65, EasingTools.sineOut);
        var position = new Vector2(progress, 4);
        trace(position.length());
        trace(KinematicsTools.displacement(2, 3, 4)); // 32

        var accent:Color = Color.fromRgb(255, 64, 32);
        trace(accent.red); // 255
        trace("custom_tools library".toTitleCase()); // Custom Tools Library
    }
}
```

The main code areas are:

| Area | Contents |
| --- | --- |
| `tools.classes.basic` | Boolean, integer, and floating-point helpers. |
| `tools.classes.iterables` | Array and map extensions. |
| `tools.classes.math` | Easing, geometry, and date/time utilities. |
| `tools.classes.physics` | Kinematics, dynamics, and energy calculations. |
| `tools.classes.special` | Color, enum reflection, and string helpers. |
| `tools.classes.structs` | `Vector2`, `Size2`, and `Rect` geometry/data classes. |
| `tools.interfaces` | Reusable update, position, cleanup, and reset contracts. |
| `tools.abstracts` | Typed ARGB colors and callable easing values. |
| `tools.utils` | Frame-time utilities used by frame-adjusted interpolation. |

Utility modules use the `tools.classes.*` paths. `tools.Tools` provides typedef aliases for many public utility, abstract, and interface types. Structs are imported from `tools.classes.structs`. See [API](API.md) for the complete reference.

## Framework integrations

The library integrates with HaxeFlixel, HaxePunk, Ceramic, and Heaps. Framework-aware helpers use the active framework's timing facilities, while some integrations also provide framework-specific object lifecycle utilities. Enable the relevant compile-time define in your project to use these features.

## Lambda compatibility

`ArrayTools.find()`, `ArrayTools.flatten()`, and `MapTools.filter()` were removed in version 0.1.0 because their names conflict with Haxe's standard `Lambda` extensions. Use `using Lambda;` for those operations.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).

## API

For a complete reference to the library's utilities and methods, see [API](API.md).

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
