package tools.classes.functions.math;

#if macro
import haxe.macro.Expr;
#end

/**
 * Utility functions for comparing and selecting floating-point values.
 */
@:nullSafety
final class MathTools
{
	@:noCompletion
	private function new() {}
	
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
	 * Returns the smallest of the supplied values.
	 * For code that is not a runtime script, prefer `fastMin`.
	 * @param values The values to compare; at least one value is required.
	 * @return The smallest value.
	 */
	public static function min(...values:Float):Float
	{
		var result = values[0];
		for (current in values)
		{
			result = Math.min(result, current);
		}
		return result;
	}
	
	/**
	 * Returns the largest of the supplied values.
	 * For code that is not a runtime script, prefer `fastMax`.
	 * @param values The values to compare; at least one value is required.
	 * @return The largest value.
	 */
	public static function max(...values:Float):Float
	{
		var result = values[0];
		for (current in values)
		{
			result = Math.max(result, current);
		}
		return result;
	}
	
	/**
	 * Expands to a balanced expression that computes the smallest supplied value.
	 * With no arguments, expands to `Math.POSITIVE_INFINITY`.
	 * #### **This macro is unavailable in runtime scripts such as HScript or Lua.**
	 * @param values The expressions to compare.
	 * @return A macro expression that evaluates to the smallest value.
	 */
	public static macro function fastMin(...values:Expr):Expr
	{
		return genericFastMinMax(values.toArray(), 'Math.min', 'Math.POSITIVE_INFINITY');
	}
	
	/**
	 * Expands to a balanced expression that computes the largest supplied value.
	 * With no arguments, expands to `Math.NEGATIVE_INFINITY`.
	 * #### **This macro is unavailable in runtime scripts such as HScript or Lua.**
	 * @param values The expressions to compare.
	 * @return A macro expression that evaluates to the largest value.
	 */
	public static macro function fastMax(...values:Expr):Expr
	{
		return genericFastMinMax(values.toArray(), 'Math.max', 'Math.NEGATIVE_INFINITY');
	}
	
	#if macro
	private static function genericFastMinMax(values:Array<Expr>, functionPath:String, emptyPath:String):Expr
	{
		if (values.length == 0) return macro $p{emptyPath.split('.')};
		
		var functionParts = functionPath.split('.');
		
		/**
		 * Recursively combines expression ranges into a balanced call tree.
		 * @param args The expressions in the current range.
		 * @return The original expression for a single item, or a call combining the subranges.
		 */
		function nested(args:Array<Expr>):Expr
		{
			if (args.length == 1) return args[0];
			
			var middle = Std.int(args.length / 2);
			return macro $p{functionParts}(${nested(args.slice(0, middle))}, ${nested(args.slice(middle))});
		}
		
		return nested(values);
	}
	#end
}
