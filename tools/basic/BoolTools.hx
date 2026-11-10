package tools.basic;

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
		if (bool) return 1;
		return 0;
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
