package tools;

@:nullSafety(Strict)
/**
	Extension methods for common floating-point operations.
**/
class FloatTools
{
	@:noCompletion
	function new() {}
	
	/**
		Checks whether two numbers differ by no more than a tolerance.
		@param a The first number.
		@param b The second number.
		@param epsilon The maximum accepted absolute difference.
		@return `true` when the absolute difference is at most `epsilon`.
	**/
	public static inline function nearEquals(a:Float, b:Float, epsilon:Float = .00001):Bool
	{
		return Math.abs(a - b) <= epsilon;
	}
	
	/**
		Restricts a number to the inclusive interval from `min` to `max`.
		@param float The value to clamp.
		@param min The lower bound.
		@param max The upper bound.
		@return The clamped value.
	**/
	public static inline function clamp(float:Float, min:Float, max:Float):Float
	{
		#if cs
		return cs.system.Math.Clamp(float, min, max);
		#else
		return (float < min) ? min : ((float > max) ? max : float);
		#end
	}
	
	/**
		Rounds a number to a specified number of decimal places.
		@param float The value to round.
		@param decimals The number of decimal places.
		@return The rounded value.
	**/
	public static inline function roundToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.round(float * p) / p;
	}
	
	/**
		Rounds a number down to a specified number of decimal places.
		@param float The value to round.
		@param decimals The number of decimal places.
		@return The rounded-down value.
	**/
	public static inline function floorToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.floor(float * p) / p;
	}
	
	/**
		Rounds a number up to a specified number of decimal places.
		@param float The value to round.
		@param decimals The number of decimal places.
		@return The rounded-up value.
	**/
	public static inline function ceilToDecimal(float:Float, decimals:Int):Float
	{
		var p = Math.pow(10, decimals);
		return Math.ceil(float * p) / p;
	}
	
	/**
		Linearly interpolates between two numbers.
		@param a The starting value.
		@param b The ending value.
		@param t The interpolation factor; `0` returns `a` and `1` returns `b`.
		@return The interpolated value.
	**/
	public static inline function lerp(a:Float, b:Float, t:Float):Float
	{
		#if cs
		return cs.system.MathF.Lerp((cast a : cs.StdTypes.Float32), (cast b : cs.StdTypes.Float32),
			(cast t : cs.StdTypes.Float32));
		#else
		return a + (b - a) * t;
		#end
	}
	
	/**
		Returns the sign of a number.
		@param float The number to inspect.
		@return `1` for positive values, `-1` for negative values, and `0` for zero.
	**/
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
}
