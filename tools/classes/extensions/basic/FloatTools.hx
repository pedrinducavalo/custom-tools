package tools.classes.extensions.basic;

import tools.classes.functions.math.EasingTools.EaseFunc;
import tools.utils.FPSUtil;

/**
 * Extension methods for common floating-point operations.
 */
@:nullSafety
final class FloatTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Restricts a number to the inclusive interval from `min` to `max`.
	 * @param f The value to clamp.
	 * @param min The lower bound.
	 * @param max The upper bound.
	 * @return The clamped value.
	 */
	public static inline function clamp(f:Float, min:Float, max:Float):Float
	{
		return (f < min) ? min : ((f > max) ? max : f);
	}
	
	/**
	 * Rounds a number to a specified number of decimal places.
	 * @param f The value to round.
	 * @param d The number of decimal places.
	 * @return The rounded value.
	 */
	public static inline function roundToDecimal(f:Float, d:Int):Float
	{
		var p = Math.pow(10, d);
		return Math.round(f * p) / p;
	}
	
	/**
	 * Rounds a number down to a specified number of decimal places.
	 * @param f The value to round.
	 * @param d The number of decimal places.
	 * @return The rounded-down value.
	 */
	public static inline function floorToDecimal(f:Float, d:Int):Float
	{
		var p = Math.pow(10, d);
		return Math.floor(f * p) / p;
	}
	
	/**
	 * Rounds a number up to a specified number of decimal places.
	 * @param f The value to round.
	 * @param d The number of decimal places.
	 * @return The rounded-up value.
	 */
	public static inline function ceilToDecimal(f:Float, d:Int):Float
	{
		var p = Math.pow(10, d);
		return Math.ceil(f * p) / p;
	}
	
	/**
	 * Linearly interpolates between two numbers.
	 * @param a The starting value.
	 * @param b The ending value.
	 * @param t The interpolation factor, clamped to the range 0-1.
	 * @return The interpolated value.
	 */
	public static inline function lerp(a:Float, b:Float, t:Float):Float
	{
		return a + (b - a) * clamp(t, 0, 1);
	}
	
	/**
	 * Interpolates toward a target with a factor adjusted for the current frame time.
	 * The result is independent of frame rate when called once per frame with a consistent `t`.
	 * @param a The starting value.
	 * @param b The target value.
	 * @param t The interpolation factor for a 60 FPS frame, clamped to the range 0-1.
	 * @return The frame-time-adjusted interpolated value.
	 */
	public static inline function fixedLerp(a:Float, b:Float, t:Float):Float
	{
		return a + (b - a) * FPSUtil.getFPSRatio(clamp(t, 0, 1));
	}
	
	/**
	 * Interpolates between two numbers using an optional easing function.
	 * @param a The starting value.
	 * @param b The target value.
	 * @param t The interpolation factor, clamped to the range 0-1.
	 * @param e The optional easing function applied to the clamped factor.
	 * @return The interpolated value.
	 */
	public static inline function easeLerp(a:Float, b:Float, t:Float, ?e:EaseFunc):Float
	{
		var clampedRatio = clamp(t, 0, 1);
		return a + (b - a) * (e != null ? e(clampedRatio) : clampedRatio);
	}
	
	/**
	 * Interpolates between two numbers using a frame-time-adjusted factor and an optional easing function.
	 * @param a The starting value.
	 * @param b The target value.
	 * @param t The per-frame interpolation factor, clamped to the range 0-1 before frame-time adjustment.
	 * @param e The optional easing function applied to the adjusted factor.
	 * @return The interpolated value.
	 */
	public static inline function fixedEaseLerp(a:Float, b:Float, t:Float, ?e:EaseFunc):Float
	{
		var clampedRatio = FPSUtil.getFPSRatio(clamp(t, 0, 1));
		return a + (b - a) * (e != null ? e(clampedRatio) : clampedRatio);
	}
	
	/**
	 * Returns the sign of a number.
	 * @param f The number to inspect.
	 * @return `1` for positive values, `-1` for negative values, and `0` for zero.
	 */
	public static inline function sign(f:Float):Int
	{
		#if js
		return js.Syntax.code('Math.sign({0})', f);
		#elseif java
		return Std.int(java.lang.Math.signum(f));
		#elseif cs
		return cs.system.Math.Sign(f);
		#elseif python
		return (f == 0) ? 0 : Std.int(python.Syntax.code('math.copysign(1, {0})', f));
		#else
		return (f > 0) ? 1 : ((f < 0) ? -1 : 0);
		#end
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
