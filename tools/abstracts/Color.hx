package tools.abstracts;

using tools.classes.extensions.basic.IntTools;

using StringTools;

/**
 * A packed ARGB color with helpers for channel access and interpolation.
 */
@:nullSafety
abstract Color(Int) from Int from UInt to Int to UInt
{
	public inline function new(value:Int)
	{
		this = value;
	}
	
	/**
	 * Predefined fully transparent ARGB color.
	 */
	public static inline var TRANSPARENT:Color = 0x00000000;
	
	/**
	 * Predefined black ARGB color.
	 */
	public static inline var BLACK:Color = 0xFF000000;
	
	/**
	 * Predefined white ARGB color.
	 */
	public static inline var WHITE:Color = 0xFFFFFFFF;
	
	/**
	 * Predefined red ARGB color.
	 */
	public static inline var RED:Color = 0xFFFF0000;
	
	/**
	 * Predefined green ARGB color.
	 */
	public static inline var GREEN:Color = 0xFF008000;
	
	/**
	 * Predefined blue ARGB color.
	 */
	public static inline var BLUE:Color = 0xFF0000FF;
	
	/**
	 * Predefined yellow ARGB color.
	 */
	public static inline var YELLOW:Color = 0xFFFFFF00;
	
	/**
	 * Predefined cyan ARGB color.
	 */
	public static inline var CYAN:Color = 0xFF00FFFF;
	
	/**
	 * `MAGENTA` constant with packed value `0xFFFFC0CB` (pink).
	 */
	public static inline var MAGENTA:Color = 0xFFFFC0CB;
	
	/**
	 * Predefined orange ARGB color.
	 */
	public static inline var ORANGE:Color = 0xFFFFA500;
	
	/**
	 * Predefined purple ARGB color.
	 */
	public static inline var PURPLE:Color = 0xFF800080;
	
	/**
	 * `PINK` constant with packed value `0xFFFF00FF` (magenta).
	 */
	public static inline var PINK:Color = 0xFFFF00FF;
	
	/**
	 * Predefined brown ARGB color.
	 */
	public static inline var BROWN:Color = 0xFF8D5324;
	
	/**
	 * Predefined gray ARGB color.
	 */
	public static inline var GRAY:Color = 0xFF808080;
	
	/**
	 * Predefined light gray ARGB color.
	 */
	public static inline var LIGHT_GRAY:Color = 0xFFD3D3D3;
	
	/**
	 * Predefined dark gray ARGB color.
	 */
	public static inline var DARK_GRAY:Color = 0xFF383838;
	
	/**
	 * Predefined navy ARGB color.
	 */
	public static inline var NAVY:Color = 0xFF000080;
	
	/**
	 * Predefined teal ARGB color.
	 */
	public static inline var TEAL:Color = 0xFF008080;
	
	/**
	 * Predefined lime ARGB color.
	 */
	public static inline var LIME:Color = 0xFF00FF00;
	
	/**
	 * Predefined maroon ARGB color.
	 */
	public static inline var MAROON:Color = 0xFF68001F;
	
	/**
	 * Predefined olive ARGB color.
	 */
	public static inline var OLIVE:Color = 0xFF808000;
	
	/**
	 * Predefined silver ARGB color.
	 */
	public static inline var SILVER:Color = 0xFFC0C0C0;
	
	/**
	 * Predefined gold ARGB color.
	 */
	public static inline var GOLD:Color = 0xFFFFD700;
	
	/**
	 * Predefined coral ARGB color.
	 */
	public static inline var CORAL:Color = 0xFFFF6A50;
	
	/**
	 * Predefined turquoise ARGB color.
	 */
	public static inline var TURQUOISE:Color = 0xFF40E0D0;
	
	/**
	 * Predefined indigo ARGB color.
	 */
	public static inline var INDIGO:Color = 0xFF4B0082;
	
	/**
	 * Predefined violet ARGB color.
	 */
	public static inline var VIOLET:Color = 0xFFEE82EE;
	
	/**
	 * Gets or sets the packed RGB channels, excluding alpha.
	 * Assignments preserve the current alpha channel and ignore bits outside the low 24.
	 */
	public var rgb(get, set):Int;
	
	@:noCompletion
	private inline function get_rgb():Int
	{
		return this & 0x00FFFFFF;
	}
	
	@:noCompletion
	private inline function set_rgb(value:Int):Int
	{
		this = (this & 0xFF000000) | (value & 0x00FFFFFF);
		return value;
	}
	
	/**
	 * Gets or sets the hue in degrees. Assignments update RGB while preserving the other color components.
	 */
	public var hue(get, set):Float;
	
	@:noCompletion
	private inline function get_hue():Float
	{
		var red = get_red() / 255;
		var green = get_green() / 255;
		var blue = get_blue() / 255;
		var max = red > green ? (red > blue ? red : blue) : (green > blue ? green : blue);
		var min = red < green ? (red < blue ? red : blue) : (green < blue ? green : blue);
		var delta = max - min;
		var hue:Float;
		
		if (delta == 0) return 0;
		if (max == red) hue = 60 * (((green - blue) / delta) % 6);
		else if (max == green) hue = 60 * ((blue - red) / delta + 2);
		else hue = 60 * ((red - green) / delta + 4);
		return hue < 0 ? hue + 360 : hue;
	}
	
	@:noCompletion
	private inline function set_hue(value:Float):Float
	{
		setHsl(value, saturation, lightness);
		return value;
	}
	
	/**
	 * Gets or sets HSL saturation in the range 0-1.
	 */
	public var saturation(get, set):Float;
	
	@:noCompletion
	private inline function get_saturation():Float
	{
		var max = maxChannel();
		var min = minChannel();
		var lightness = (max + min) / 2;
		var delta = max - min;
		return delta == 0 ? 0 : delta / (1 - Math.abs(2 * lightness - 1));
	}
	
	@:noCompletion
	private inline function set_saturation(value:Float):Float
	{
		setHsl(hue, clampUnit(value), lightness);
		return value;
	}
	
	/**
	 * Gets or sets HSV brightness (value) in the range 0-1.
	 */
	public var brightness(get, set):Float;
	
	@:noCompletion
	private inline function get_brightness():Float
	{
		return maxChannel();
	}
	
	@:noCompletion
	private inline function set_brightness(value:Float):Float
	{
		setHsv(hue, hsvSaturation(), clampUnit(value));
		return value;
	}
	
	/**
	 * Gets or sets HSL lightness in the range 0-1.
	 */
	public var lightness(get, set):Float;
	
	@:noCompletion
	private inline function get_lightness():Float
	{
		return (maxChannel() + minChannel()) / 2;
	}
	
	@:noCompletion
	private inline function set_lightness(value:Float):Float
	{
		setHsl(hue, saturation, clampUnit(value));
		return value;
	}
	
	/**
	 * Gets or sets the alpha channel in the range 0-255.
	 */
	public var alpha(get, set):Int;
	
	@:noCompletion
	private inline function get_alpha():Int
	{
		return (this >>> 24) & 0xFF;
	}
	
	@:noCompletion
	private inline function set_alpha(value:Int):Int
	{
		this = (this & 0x00FFFFFF) | (clampChannel(value) << 24);
		return value;
	}
	
	/**
	 * Gets or sets the red channel in the range 0-255.
	 */
	public var red(get, set):Int;
	
	@:noCompletion
	private inline function get_red():Int
	{
		return (this >>> 16) & 0xFF;
	}
	
	@:noCompletion
	private inline function set_red(value:Int):Int
	{
		this = (this & 0xFF00FFFF) | (clampChannel(value) << 16);
		return value;
	}
	
	/**
	 * Gets or sets the green channel in the range 0-255.
	 */
	public var green(get, set):Int;
	
	@:noCompletion
	private inline function get_green():Int
	{
		return (this >>> 8) & 0xFF;
	}
	
	@:noCompletion
	private inline function set_green(value:Int):Int
	{
		this = (this & 0xFFFF00FF) | (clampChannel(value) << 8);
		return value;
	}
	
	/**
	 * Gets or sets the blue channel in the range 0-255.
	 */
	public var blue(get, set):Int;
	
	@:noCompletion
	private inline function get_blue():Int
	{
		return this & 0xFF;
	}
	
	@:noCompletion
	private inline function set_blue(value:Int):Int
	{
		this = (this & 0xFFFFFF00) | clampChannel(value);
		return value;
	}
	
	/**
	 * Gets or sets the alpha channel normalized to the range 0-1.
	 */
	public var normalizedAlpha(get, set):Float;
	
	@:noCompletion
	private inline function get_normalizedAlpha():Float
	{
		return alpha / 255;
	}
	
	@:noCompletion
	private inline function set_normalizedAlpha(value:Float):Float
	{
		return alpha = Math.round(value * 255);
	}
	
	/**
	 * Gets or sets the red channel normalized to the range 0-1.
	 */
	public var normalizedRed(get, set):Float;
	
	@:noCompletion
	private inline function get_normalizedRed():Float
	{
		return red / 255;
	}
	
	@:noCompletion
	private inline function set_normalizedRed(value:Float):Float
	{
		return red = Math.round(value * 255);
	}
	
	/**
	 * Gets or sets the green channel normalized to the range 0-1.
	 */
	public var normalizedGreen(get, set):Float;
	
	@:noCompletion
	private inline function get_normalizedGreen():Float
	{
		return green / 255;
	}
	
	@:noCompletion
	private inline function set_normalizedGreen(value:Float):Float
	{
		return green = Math.round(value * 255);
	}
	
	/**
	 * Gets or sets the blue channel normalized to the range 0-1.
	 */
	public var normalizedBlue(get, set):Float;
	
	@:noCompletion
	private inline function get_normalizedBlue():Float
	{
		return blue / 255;
	}
	
	@:noCompletion
	private inline function set_normalizedBlue(value:Float):Float
	{
		return blue = Math.round(value * 255);
	}
	
	/**
	 * Creates an opaque color from red, green, and blue channels.
	 * @param red The red channel, clamped to 0-255.
	 * @param green The green channel, clamped to 0-255.
	 * @param blue The blue channel, clamped to 0-255.
	 * @return The packed ARGB color.
	 */
	public static inline function fromRgb(red:Int, green:Int, blue:Int):Color
	{
		return fromArgb(255, red, green, blue);
	}
	
	/**
	 * Creates a color from alpha, red, green, and blue channels.
	 * @param alpha The alpha channel, clamped to 0-255.
	 * @param red The red channel, clamped to 0-255.
	 * @param green The green channel, clamped to 0-255.
	 * @param blue The blue channel, clamped to 0-255.
	 * @return The packed ARGB color.
	 */
	public static inline function fromArgb(alpha:Int, red:Int, green:Int, blue:Int):Color
	{
		return (clampChannel(alpha) << 24) | (clampChannel(red) << 16) | (clampChannel(green) << 8) | clampChannel(blue);
	}
	
	/**
	 * Returns this color with its alpha channel replaced.
	 * @param value The new alpha channel, clamped to 0-255.
	 * @return The updated ARGB color.
	 */
	public inline function withAlpha(value:Int):Color
	{
		return fromArgb(value, red, green, blue);
	}
	
	/**
	 * Parses a decimal integer string into an ARGB color.
	 * @param value The decimal representation to parse.
	 * @return The parsed ARGB color.
	 * @throws haxe.Exception If `value` cannot be parsed as an integer.
	 */
	@:from
	public static inline function fromString(value:String):Color
	{
		var parsed = Std.parseInt(value.trim());
		if (parsed == null) throw new haxe.Exception('Invalid decimal ARGB color: ' + value);
		return parsed;
	}
	
	/**
	 * Converts this color to its decimal integer representation.
	 * @return The decimal ARGB color string.
	 */
	@:to
	public inline function toString():String
	{
		return Std.string(this);
	}
	
	private inline function maxChannel():Float
	{
		var max = red > green ? red : green;
		return (max > blue ? max : blue) / 255;
	}
	
	private inline function minChannel():Float
	{
		var min = red < green ? red : green;
		return (min < blue ? min : blue) / 255;
	}
	
	private inline function hsvSaturation():Float
	{
		var max = maxChannel();
		var delta = max - minChannel();
		return max == 0 ? 0 : delta / max;
	}
	
	private inline function setHsl(hue:Float, saturation:Float, lightness:Float):Void
	{
		var normalizedHue = ((hue % 360) + 360) % 360;
		var chroma = (1 - Math.abs(2 * lightness - 1)) * saturation;
		var segment = normalizedHue / 60;
		var second = chroma * (1 - Math.abs((segment % 2) - 1));
		
		if (segment < 1) setRgbChannels(chroma, second, 0, lightness - chroma / 2);
		else if (segment < 2) setRgbChannels(second, chroma, 0, lightness - chroma / 2);
		else if (segment < 3) setRgbChannels(0, chroma, second, lightness - chroma / 2);
		else if (segment < 4) setRgbChannels(0, second, chroma, lightness - chroma / 2);
		else if (segment < 5) setRgbChannels(second, 0, chroma, lightness - chroma / 2);
		else setRgbChannels(chroma, 0, second, lightness - chroma / 2);
	}
	
	private inline function setHsv(hue:Float, saturation:Float, brightness:Float):Void
	{
		var normalizedHue = ((hue % 360) + 360) % 360;
		var chroma = brightness * saturation;
		var segment = normalizedHue / 60;
		var second = chroma * (1 - Math.abs((segment % 2) - 1));
		var offset = brightness - chroma;
		
		if (segment < 1) setRgbChannels(chroma, second, 0, offset);
		else if (segment < 2) setRgbChannels(second, chroma, 0, offset);
		else if (segment < 3) setRgbChannels(0, chroma, second, offset);
		else if (segment < 4) setRgbChannels(0, second, chroma, offset);
		else if (segment < 5) setRgbChannels(second, 0, chroma, offset);
		else setRgbChannels(chroma, 0, second, offset);
	}
	
	private inline function setRgbChannels(red:Float, green:Float, blue:Float, offset:Float):Void
	{
		var r = Math.round((red + offset) * 255);
		var g = Math.round((green + offset) * 255);
		var b = Math.round((blue + offset) * 255);
		this = (this & 0xFF000000) | (r << 16) | (g << 8) | b;
	}
	
	private static inline function clampUnit(value:Float):Float
	{
		return value < 0 ? 0 : (value > 1 ? 1 : value);
	}
	
	private static inline function clampChannel(value:Int):Int
	{
		return value.clamp(0, 255);
	}
}
