package tools;

import tools.FloatTools;
import tools.utils.FPSUtil;

/**
 * Utility methods for creating, interpolating, and reading ARGB colors.
 */
@:nullSafety
final class ColorTools
{
	/**
	 * Interpolates between two ARGB colors using the supplied ratio directly.
	 * @param color1 The starting ARGB color.
	 * @param color2 The target ARGB color.
	 * @param ratio The interpolation ratio; resulting channels are clamped to the range 0-255.
	 * @return The interpolated ARGB color.
	 */
	public static inline function lerpColor(color1:Int, color2:Int, ratio:Float):Int
	{
		var a1 = (color1 >> 24) & 0xFF;
		var r1 = (color1 >> 16) & 0xFF;
		var g1 = (color1 >> 8) & 0xFF;
		var b1 = color1 & 0xFF;
		
		var a2 = (color2 >> 24) & 0xFF;
		var r2 = (color2 >> 16) & 0xFF;
		var g2 = (color2 >> 8) & 0xFF;
		var b2 = color2 & 0xFF;
		
		var a = clampChannel(a1 + (a2 - a1) * ratio);
		var r = clampChannel(r1 + (r2 - r1) * ratio);
		var g = clampChannel(g1 + (g2 - g1) * ratio);
		var b = clampChannel(b1 + (b2 - b1) * ratio);
		
		return (a << 24) | (r << 16) | (g << 8) | b;
	}
	
	/**
	 * Interpolates between two ARGB colors using a frame-rate-adjusted ratio.
	 * @param color1 The starting ARGB color.
	 * @param color2 The target ARGB color.
	 * @param ratio The interpolation ratio, clamped to the range 0-1 before frame-rate adjustment.
	 * @return The interpolated ARGB color.
	 */
	public static inline function fixedLerpColor(color1:Int, color2:Int, ratio:Float):Int
	{
		var fRatio:Float = FPSUtil.getFPSRatio(FloatTools.clamp(ratio, 0, 1));
		
		var a1 = (color1 >> 24) & 0xFF;
		var r1 = (color1 >> 16) & 0xFF;
		var g1 = (color1 >> 8) & 0xFF;
		var b1 = color1 & 0xFF;
		
		var a2 = (color2 >> 24) & 0xFF;
		var r2 = (color2 >> 16) & 0xFF;
		var g2 = (color2 >> 8) & 0xFF;
		var b2 = color2 & 0xFF;
		
		var a = clampChannel(a1 + (a2 - a1) * fRatio);
		var r = clampChannel(r1 + (r2 - r1) * fRatio);
		var g = clampChannel(g1 + (g2 - g1) * fRatio);
		var b = clampChannel(b1 + (b2 - b1) * fRatio);
		
		return (a << 24) | (r << 16) | (g << 8) | b;
	}
	
	/**
	 * Creates an opaque ARGB color from red, green, and blue channels in the range 0-255.
	 * Values outside that range are clamped.
	 */
	public static inline function fromRgb(r:Float, g:Float, b:Float):Int
	{
		return (0xFF << 24) | (clampChannel(r) << 16) | (clampChannel(g) << 8) | clampChannel(b);
	}
	
	/**
	 * Returns the alpha channel of an ARGB color.
	 * @param color The ARGB color to inspect.
	 * @return The alpha channel as a value from 0 to 255.
	 */
	public static inline function getAlpha(color:Int):Float
	{
		var alpha = (color >> 24) & 0xFF;
		return alpha;
	}
	
	/**
	 * Returns the red channel of an ARGB color.
	 * @param color The ARGB color to inspect.
	 * @return The red channel as a value from 0 to 255.
	 */
	public static inline function getRed(color:Int):Float
	{
		var red = (color >> 16) & 0xFF;
		return red;
	}
	
	/**
	 * Returns the green channel of an ARGB color.
	 * @param color The ARGB color to inspect.
	 * @return The green channel as a value from 0 to 255.
	 */
	public static inline function getGreen(color:Int):Float
	{
		var green = (color >> 8) & 0xFF;
		return green;
	}
	
	/**
	 * Returns the blue channel of an ARGB color.
	 * @param color The ARGB color to inspect.
	 * @return The blue channel as a value from 0 to 255.
	 */
	public static inline function getBlue(color:Int):Float
	{
		var blue = color & 0xFF;
		return blue;
	}
	
	/**
	 * Clamps a color channel to the inclusive range 0-255 and converts it to an integer.
	 * @param value The channel value to clamp.
	 * @return The clamped integer channel.
	 */
	private static inline function clampChannel(value:Float):Int
	{
		return Std.int(FloatTools.clamp(value, 0, 255));
	}
	
	/**
	 * Converts an ARGB color integer to its decimal string representation.
	 * @param color The ARGB color to convert.
	 * @return The decimal representation of `color`.
	 */
	public static inline function toString(color:Int):String
	{
		return Std.string(color);
	}
}
