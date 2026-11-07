package tools;

import tools.utils.FPSUtil;

@:nullSafety

/**
 * Extension methods for common floating-point operations.
 */
final class FloatTools

{
	/**
	 * Creates a `FloatTools` instance. This constructor is not intended for public use.
	 */
	@:noCompletion
	function new() {}
	
	/**
	 * Checks whether two numbers differ by no more than a tolerance.
	 * @param a The first number.
	 * @param b The second number.
	 * @param epsilon The maximum accepted absolute difference.
	 * @return `true` when the absolute difference is at most `epsilon`.
	 */
	public static inline function nearEquals(a:Float, b:Float, epsilon:Float = .00001):Bool
	{
		return Math.abs(a - b) <= epsilon;
	}
	
	/**
	 * Restricts a number to the inclusive interval from `min` to `max`.
	 * @param float The value to clamp.
	 * @param min The lower bound.
	 * @param max The upper bound.
	 * @return The clamped value.
	 */
	public static inline function clamp(float:Float, min:Float, max:Float):Float
	{
		#if cs
		return cs.system.Math.Clamp(float, min, max);
		#else
		return (float < min) ? min : ((float > max) ? max : float);
		#end
	}
	
	/**
	 * Rounds a number to a specified number of decimal places.
	 * @param float The value to round.
	 * @param decimals The number of decimal places.
	 * @return The rounded value.
	 */
	public static inline function roundToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.round(float * p) / p;
	}
	
	/**
	 * Rounds a number down to a specified number of decimal places.
	 * @param float The value to round.
	 * @param decimals The number of decimal places.
	 * @return The rounded-down value.
	 */
	public static inline function floorToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.floor(float * p) / p;
	}
	
	/**
	 * Rounds a number up to a specified number of decimal places.
	 * @param float The value to round.
	 * @param decimals The number of decimal places.
	 * @return The rounded-up value.
	 */
	public static inline function ceilToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.ceil(float * p) / p;
	}
	
	/**
	 * Interpolates toward a target using a per-frame factor adjusted for frame time.
	 * @param a The starting value.
	 * @param b The ending value.
	 * @param t The interpolation factor per 60 FPS frame, clamped to the range 0-1.
	 * @return The interpolated value; `0` returns `a` and `1` returns `b`.
	 */
	public static inline function lerp(a:Float, b:Float, t:Float):Float
	{
		return a + (b - a) * FPSUtil.getFPSRatio(clamp(t, 0, 1));
	}
	
	/**
	 * Returns the sign of a number.
	 * @param float The number to inspect.
	 * @return `1` for positive values, `-1` for negative values, and `0` for zero.
	 */
	public static inline function sign(float:Float):Int
	{
		#if js
		return js.Syntax.code('Math.sign({0})', float);
		#elseif java
		return Std.int(java.lang.Math.signum(float));
		#elseif cs
		return cs.system.Math.Sign(float);
		#elseif python
		return (float == 0) ? 0 : Std.int(python.Syntax.code('math.copysign(1, {0})', float));
		#else
		return (float > 0) ? 1 : ((float < 0) ? -1 : 0);
		#end
	}
	
	/**
	 * Returns the smaller of the two supplied values.
	 * @param float The first value to compare.
	 * @param max The second value to compare.
	 * @return The smaller value.
	 */
	public static inline function min(float:Float, max:Float):Float
	{
		return Math.min(float, max);
	}
	
	/**
	 * Returns the larger of the two supplied values.
	 * @param float The first value to compare.
	 * @param min The second value to compare.
	 * @return The larger value.
	 */
	public static inline function max(float:Float, min:Float):Float
	{
		return Math.max(float, min);
	}
	
	/**
	 * Chooses a random sign value.
	 * @return `-1`, `0`, or `1`, each with equal probability.
	 */
	public static inline function randomSign():Int
	{
		return Std.random(3) - 1;
	}
}
