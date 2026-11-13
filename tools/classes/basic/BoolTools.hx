package tools.classes.basic;

/**
 * Utility methods for converting and transforming boolean values.
 */
@:nullSafety
final class BoolTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Converts a boolean value to its integer representation.
	 * @param bool The value to convert.
	 * @return `1` for `true` or `0` for `false`.
	 */
	public static inline function int(bool:Bool):Int
	{
		return (bool) ? 1 : 0;
	}
	
	/**
	 * Returns the opposite of a boolean value.
	 * @param bool The value to toggle.
	 * @return `false` for `true` or `true` for `false`.
	 */
	public static inline function toggle(bool:Bool):Bool
	{
		return !bool;
	}
	
	/**
	 * Returns whether exactly one of the two values is `true`.
	 * @param bool The first value.
	 * @param other The second value.
	 * @return `true` when the values differ.
	 */
	public static inline function xor(bool:Bool, other:Bool):Bool
	{
		return bool != other;
	}
	
	/**
	 * Returns whether both values are `false` or both are `true`.
	 * @param bool The first value.
	 * @param other The second value.
	 * @return `true` when the values are equal.
	 */
	public static inline function xnor(bool:Bool, other:Bool):Bool
	{
		return bool == other;
	}
	
	/**
	 * Returns the negation of the logical AND of two values.
	 * @param bool The first value.
	 * @param other The second value.
	 * @return `false` only when both values are `true`.
	 */
	public static inline function nand(bool:Bool, other:Bool):Bool
	{
		return !(bool && other);
	}
	
	/**
	 * Returns the negation of the logical OR of two values.
	 * @param bool The first value.
	 * @param other The second value.
	 * @return `true` only when both values are `false`.
	 */
	public static inline function nor(bool:Bool, other:Bool):Bool
	{
		return !(bool || other);
	}
	
	/**
	 * Checks whether the second value follows logically from the first.
	 * @param bool The premise.
	 * @param other The conclusion.
	 * @return `false` only when the premise is `true` and the conclusion is `false`.
	 */
	public static inline function implies(bool:Bool, other:Bool):Bool
	{
		return !bool || other;
	}
	
	/**
	 * Selects a value based on this boolean.
	 * @param bool The condition.
	 * @param whenTrue The value returned when `bool` is `true`.
	 * @param whenFalse The value returned when `bool` is `false`.
	 * @return The value corresponding to `bool`.
	 */
	public static inline function choose<T>(bool:Bool, whenTrue:T, whenFalse:T):T
	{
		return bool ? whenTrue : whenFalse;
	}
	
	/**
	 * Converts a boolean to its floating-point representation.
	 * @param bool The value to convert.
	 * @return `1.0` for `true` or `0.0` for `false`.
	 */
	public static inline function float(bool:Bool):Float
	{
		return int(bool);
	}
	
	/**
	 * Converts a nonzero integer to `true` and zero to `false`.
	 * @param int The value to convert.
	 * @return `true` when `int` is nonzero.
	 */
	public static inline function fromInt(int:Int):Bool
	{
		return int != 0;
	}
	
	/**
	 * Runs an action only when this value is `true`.
	 * @param bool The condition.
	 * @param action The action to run when `bool` is `true`.
	 */
	public static inline function when(bool:Bool, action:Void->Void):Void
	{
		if (bool) action();
	}
	
	/**
	 * Runs an action only when this value is `false`.
	 * @param bool The condition.
	 * @param action The action to run when `bool` is `false`.
	 */
	public static inline function unless(bool:Bool, action:Void->Void):Void
	{
		if (!bool) action();
	}
	
	/**
	 * Converts a boolean to a string, optionally using custom text for each value.
	 * @param bool The value to convert.
	 * @param yes The string to return when `bool` is `true`; used only when `no` is also provided.
	 * @param no The string to return when `bool` is `false`; used only when `yes` is also provided.
	 * @return The matching custom string when both `yes` and `no` are provided; otherwise, the standard boolean string.
	 */
	public static inline function string(bool:Bool, ?yes:String, ?no:String):String
	{
		if (yes != null && no != null)
		{
			if (bool) return yes;
			else return no;
		}
		
		return Std.string(bool);
	}
}
