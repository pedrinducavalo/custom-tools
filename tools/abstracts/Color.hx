package tools.abstracts;

import tools.classes.special.ColorTools;

/**
 * A packed ARGB color with helpers for channel access and interpolation.
 */
@:nullSafety
abstract Color(Int) from Int to Int
{
	public inline function new(value:Int)
	{
		this = value;
	}
	
	public var alpha(get, never):Int;
	public var red(get, never):Int;
	public var green(get, never):Int;
	public var blue(get, never):Int;
	
	inline function get_alpha():Int
	{
		return (this >>> 24) & 0xFF;
	}
	
	inline function get_red():Int
	{
		return (this >>> 16) & 0xFF;
	}
	
	inline function get_green():Int
	{
		return (this >>> 8) & 0xFF;
	}
	
	inline function get_blue():Int
	{
		return this & 0xFF;
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
	 * Interpolates this color toward another ARGB color.
	 * @param other The target color.
	 * @param ratio The interpolation ratio.
	 * @return The interpolated color.
	 */
	public inline function lerp(other:Color, ratio:Float):Color
	{
		return ColorTools.lerpColor(this, other, ratio);
	}
	
	static inline function clampChannel(value:Int):Int
	{
		return value < 0 ? 0 : (value > 255 ? 255 : value);
	}
}
