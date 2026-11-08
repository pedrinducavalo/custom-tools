package tools;

/**
 * Utility methods for common integer operations.
 */
@:nullSafety
final class IntTools
{
	/**
	 * Restricts an integer to the inclusive interval from `min` to `max`.
	 * @param int The value to clamp.
	 * @param min The lower bound.
	 * @param max The upper bound.
	 * @return The clamped value.
	 */
	public static inline function clamp(int:Int, min:Int, max:Int):Int
	{
		return (int < min) ? min : ((int > max) ? max : int);
	}

	/**
	 * Returns the smaller of the two supplied integers.
	 * @param int The first value to compare.
	 * @param max The second value to compare.
	 * @return The smaller value.
	 */
	public static inline function min(int:Int, max:Int):Int
	{
		if (max > int) return int;
		return max;
	}

	/**
	 * Returns the larger of the two supplied integers.
	 * @param int The first value to compare.
	 * @param min The second value to compare.
	 * @return The larger value.
	 */
	public static inline function max(int:Int, min:Int):Int
	{
		if (min < int) return int;
		return min;
	}

	/**
	 * Returns the sign of an integer.
	 * @param int The integer to inspect.
	 * @return `1` for positive values, `-1` for negative values, and `0` for zero.
	 */
	public static inline function sign(int:Int):Int
	{
		#if js
		return js.Syntax.code('Math.sign({0})', int);
		#elseif java
		return Std.int(java.lang.Math.signum(int));
		#elseif cs
		return cs.system.Math.Sign(int);
		#elseif python
		return (int == 0) ? 0 : Std.int(python.Syntax.code('math.copysign(1, {0})', int));
		#else
		return (int > 0) ? 1 : ((int < 0) ? -1 : 0);
		#end
	}

	/**
	 * Chooses a random sign value, excluding zero.
	 * @return `-1` or `1`, each with equal probability.
	 */
	public static inline function randomSign():Int
	{
		return Std.random(2) * 2 - 1; // sempre 1 ou -1, nunca zero
	}
}
