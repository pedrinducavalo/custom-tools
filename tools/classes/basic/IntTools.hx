package tools.classes.basic;

/**
 * Utility methods for common integer operations.
 */
@:nullSafety
final class IntTools
{
	@:noCompletion
	private function new() {}
	
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
	
	/**
	 * Checks whether an integer is divisible by two.
	 * @param int The integer to check.
	 * @return `true` if the integer is even.
	 */
	public static inline function isEven(int:Int):Bool
	{
		return int % 2 == 0;
	}
	
	/**
	 * Checks whether an integer is not divisible by two.
	 * @param int The integer to check.
	 * @return `true` if the integer is odd.
	 */
	public static inline function isOdd(int:Int):Bool
	{
		return !isEven(int);
	}
	
	/**
	 * Wraps an integer outside the given bounds to the opposite bound.
	 * Values already within the bounds are returned unchanged.
	 * @param int The integer to wrap.
	 * @param min The lower bound.
	 * @param max The upper bound.
	 * @return `max` if `int` is below `min`, `min` if it is above `max`, or `int` otherwise.
	 */
	public static inline function wrap(int:Int, min:Int, max:Int):Int
	{
		if (int < min) int = max;
		if (int > max) int = min;
		return int;
	}
	
	/**
	 * Advances an integer to the next index in a zero-based sequence, wrapping at `max`.
	 * @param int The current index.
	 * @param max The positive number of indices in the sequence; must be greater than zero.
	 * @return The next index in the range from 0 to `max - 1`.
	 */
	public static inline function loop(int:Int, max:Int):Int
	{
		return ((int + 1) % max + max) % max;
	}
	
	/**
	 * Checks whether an integer falls within a range.
	 * @param int The integer to check.
	 * @param min The lower bound.
	 * @param max The upper bound, which must be greater than or equal to `min`.
	 * @param inclusive Whether the bounds are included; defaults to `true`.
	 * @return `true` if `int` is within the range according to `inclusive`.
	 */
	public static inline function between(int:Int, min:Int, max:Int, inclusive:Bool = true):Bool
	{
		return (inclusive) ? int >= min && int <= max : int > min && int < max;
	}
	
	/**
	 * Returns the absolute value of an integer.
	 * @param int The integer to convert.
	 * @return The non-negative magnitude of `int`.
	 */
	public static inline function abs(int:Int):Int
	{
		return int < 0 ? -int : int;
	}
	
	/**
	 * Counts the decimal digits in an integer, excluding its sign.
	 * @param int The integer to inspect.
	 * @return The number of decimal digits; returns `1` for zero.
	 */
	public static inline function digits(int:Int):Int
	{
		if (int == 0) return 1;
		
		var n = abs(int);
		var count = 0;
		
		while (n > 0)
		{
			n = Std.int(n / 10);
			count++;
		}
		return count;
	}
	
	/**
	 * Converts an integer to a string padded on the left to a minimum length.
	 * @param int The integer to convert.
	 * @param length The minimum resulting string length.
	 * @param char The string used for padding; defaults to `"0"`.
	 * @return The padded integer string.
	 */
	public static inline function padLeft(int:Int, length:Int, char:String = "0"):String
	{
		return std.StringTools.lpad(Std.string(int), char, length);
	}
	
	/**
	 * Chooses a random integer from the inclusive range `min` to `max`.
	 * @param min The lower bound, which must be less than or equal to `max`.
	 * @param max The upper bound.
	 * @return A randomly selected integer in the range.
	 */
	public static inline function random(min:Int, max:Int):Int
	{
		return min + Std.random(max - min + 1);
	}
}
