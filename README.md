# custom-tools

`custom-tools` is a collection of Haxe tools and reusable building blocks for applications and games. It includes extension methods, static utility functions, framework helpers, and common data types.

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
import tools.Abstracts.Color;
import tools.classes.functions.math.EasingTools;
import tools.classes.functions.physics.KinematicsTools;
import tools.classes.functions.math.GeomTools;
import tools.classes.structs.Vector2;

using tools.classes.extensions.basic.FloatTools;
using tools.classes.extensions.iterables.ArrayTools;
using tools.classes.extensions.special.StringTools;

class Main {
    static function main() {
        var readings = [12.5, 40.0, 75.0, 100.0];
        var groups = readings.without([40.0]).chunk(2);
        trace(groups); // [[12.5, 75.0], [100.0]]

        var progress = 0.0.easeLerp(100, 0.65, EasingTools.sineOut);
        var position = new Vector2(progress, 4);
        trace(position.length());
        trace(GeomTools.distance(0, 0, 3, 4)); // 5
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
| `tools.classes.extensions.basic` | Boolean, integer, and floating-point extensions. |
| `tools.classes.extensions.iterables` | Array and map extensions. |
| `tools.classes.extensions.special` | Color, enum, and string helpers. |
| `tools.classes.extensions.backend` | Framework-specific sprite and image drawing helpers. |
| `tools.classes.functions.math` | Numeric, easing, geometry, and date/time functions. |
| `tools.classes.functions.physics` | Kinematics, dynamics, and energy functions. |
| `tools.classes.functions.memory` | Memory-size, byte sequence, and object-pool utilities. |
| `tools.classes.structs` | `Vector2`, `Size2`, and `Rect` geometry/data classes. |
| `tools.interfaces` | Reusable update, position, cleanup, and reset contracts. |
| `tools.abstracts` | Typed ARGB colors and callable easing values. |
| `tools.utils` | Frame-time utilities used by frame-adjusted interpolation. |

Use `using tools.classes.extensions.*` for extension methods and import static helpers from `tools.classes.functions.*`. Category aliases are available through `tools.classes.Extensions`, `tools.classes.Functions`, `tools.classes.Structs`, `tools.Abstracts`, `tools.Interfaces`, and `tools.Utils`. See [API](API.md) for the complete reference.

`SpriteTools` provides common sprite and image-drawing helpers for supported rendering frameworks. The available operations vary by framework and are summarized in [API](API.md).

## Framework integrations

The library has integrations for HaxeFlixel, HaxePunk, OpenFL, Ceramic, Heaps, and Kha. `FPSUtil` can use native frame timing in HaxeFlixel, HaxePunk, Ceramic, and Heaps; framework-specific helpers also include Flixel-aware collection cleanup, native sprite color flashes, and Kha image drawing. Enable the relevant compile-time define in your project to use them.

## Lambda compatibility

`ArrayTools.find()`, `ArrayTools.flatten()`, and `MapTools.filter()` were removed in version 0.1.0 because their names conflict with Haxe's standard `Lambda` extensions. Use `using Lambda;` for those operations.

## `Tools.hx` compatibility

`Tools.hx` was dissolved to fit the project's new package structure. Its aliases are now split across six modules: `tools.classes.Extensions`, `tools.classes.Functions`, `tools.classes.Structs`, `tools.Abstracts`, `tools.Interfaces`, and `tools.Utils`. Update references such as `tools.Tools.FloatTools` to the corresponding category alias, for example `tools.classes.Extensions.FloatTools`. Direct imports from the helper's own module paths are unchanged.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).

## API

For a complete reference to the library's utilities and methods, see [API](API.md).

## Contributing

Contributions are welcome. Please keep additions lightweight and consistent with the existing API.
