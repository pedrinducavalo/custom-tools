package tools.math;

/**
 * Utility functions for easing interpolation progress along common curves.
 */
@:nullSafety
final class EasingTools
{
	@:noCompletion
	private function new() {}
	
	// obrigado, flixel
	// https://api.haxeflixel.com/flixel/tweens/FlxEase.html
	private static final PI2:Float = Math.PI / 2;
	private static final EL:Float = 2 * Math.PI / .45;
	private static inline var B1:Float = 1 / 2.75;
	private static inline var B2:Float = 2 / 2.75;
	private static inline var B3:Float = 1.5 / 2.75;
	private static inline var B4:Float = 2.5 / 2.75;
	private static inline var B5:Float = 2.25 / 2.75;
	private static inline var B6:Float = 2.625 / 2.75;
	
	private static inline var ELASTIC_AMPLITUDE:Float = 1;
	private static inline var ELASTIC_PERIOD:Float = 0.4;
	private static final ELASTIC_IN_START:Float = elasticIn(0);
	private static final ELASTIC_IN_END:Float = elasticIn(1);
	private static final ELASTIC_OUT_START:Float = elasticOut(0);
	private static final ELASTIC_OUT_END:Float = elasticOut(1);
	
	/**
	 * Returns the interpolation progress unchanged.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function linear(t:Float):Float
	{
		return t;
	}
	
	/**
	 * Applies the quadratic easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function quad(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: quadIn(t);
			case Out: quadOut(t);
			case InOut: quadInOut(t);
			case OutIn: quadOutIn(t);
		};
	}
	
	/**
	 * Applies the quadratic easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quadIn(t:Float):Float
	{
		return t * t;
	}
	
	/**
	 * Applies the quadratic easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quadOut(t:Float):Float
	{
		return -t * (t - 2);
	}
	
	/**
	 * Applies the quadratic easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quadInOut(t:Float):Float
	{
		return t < .5 ? quadIn(t * 2) / 2 : .5 + quadOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the quadratic easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quadOutIn(t:Float):Float
	{
		return t < .5 ? quadOut(t * 2) / 2 : .5 + quadIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the cubic easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function cube(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: cubeIn(t);
			case Out: cubeOut(t);
			case InOut: cubeInOut(t);
			case OutIn: cubeOutIn(t);
		};
	}
	
	/**
	 * Applies the cubic easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function cubeIn(t:Float):Float
	{
		return t * t * t;
	}
	
	/**
	 * Applies the cubic easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function cubeOut(t:Float):Float
	{
		return 1 + (--t) * t * t;
	}
	
	/**
	 * Applies the cubic easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function cubeInOut(t:Float):Float
	{
		return t < .5 ? cubeIn(t * 2) / 2 : .5 + cubeOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the cubic easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function cubeOutIn(t:Float):Float
	{
		return t < .5 ? cubeOut(t * 2) / 2 : .5 + cubeIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the quartic easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function quart(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: quartIn(t);
			case Out: quartOut(t);
			case InOut: quartInOut(t);
			case OutIn: quartOutIn(t);
		};
	}
	
	/**
	 * Applies the quartic easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quartIn(t:Float):Float
	{
		return t * t * t * t;
	}
	
	/**
	 * Applies the quartic easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quartOut(t:Float):Float
	{
		return 1 - (t -= 1) * t * t * t;
	}
	
	/**
	 * Applies the quartic easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quartInOut(t:Float):Float
	{
		return t < .5 ? quartIn(t * 2) / 2 : .5 + quartOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the quartic easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quartOutIn(t:Float):Float
	{
		return t < .5 ? quartOut(t * 2) / 2 : .5 + quartIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the quintic easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function quint(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: quintIn(t);
			case Out: quintOut(t);
			case InOut: quintInOut(t);
			case OutIn: quintOutIn(t);
		};
	}
	
	/**
	 * Applies the quintic easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quintIn(t:Float):Float
	{
		return t * t * t * t * t;
	}
	
	/**
	 * Applies the quintic easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quintOut(t:Float):Float
	{
		return (t = t - 1) * t * t * t * t + 1;
	}
	
	/**
	 * Applies the quintic easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quintInOut(t:Float):Float
	{
		return t < .5 ? quintIn(t * 2) / 2 : .5 + quintOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the quintic easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function quintOutIn(t:Float):Float
	{
		return t < .5 ? quintOut(t * 2) / 2 : .5 + quintIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the smoothstep easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function smoothStep(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: smoothStepIn(t);
			case Out: smoothStepOut(t);
			case InOut: smoothStepInOut(t);
			case OutIn: smoothStepOutIn(t);
		};
	}
	
	/**
	 * Applies the smoothstep easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smoothStepIn(t:Float):Float
	{
		return t * t * (3 - t) / 2;
	}
	
	/**
	 * Applies the smoothstep easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smoothStepOut(t:Float):Float
	{
		return 1 - smoothStepIn(1 - t);
	}
	
	/**
	 * Applies the smoothstep easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smoothStepInOut(t:Float):Float
	{
		return t < .5 ? smoothStepIn(t * 2) / 2 : .5 + smoothStepOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the smoothstep easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smoothStepOutIn(t:Float):Float
	{
		return t < .5 ? smoothStepOut(t * 2) / 2 : .5 + smoothStepIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the smootherstep easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function smootherStep(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: smootherStepIn(t);
			case Out: smootherStepOut(t);
			case InOut: smootherStepInOut(t);
			case OutIn: smootherStepOutIn(t);
		};
	}
	
	/**
	 * Applies the smootherstep easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smootherStepIn(t:Float):Float
	{
		return t * t * t * (t * (3 * t - 15) + 20) / 8;
	}
	
	/**
	 * Applies the smootherstep easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smootherStepOut(t:Float):Float
	{
		return 1 - smootherStepIn(1 - t);
	}
	
	/**
	 * Applies the smootherstep easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smootherStepInOut(t:Float):Float
	{
		return t < .5 ? smootherStepIn(t * 2) / 2 : .5 + smootherStepOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the smootherstep easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function smootherStepOutIn(t:Float):Float
	{
		return t < .5 ? smootherStepOut(t * 2) / 2 : .5 + smootherStepIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the sinusoidal easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function sine(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: sineIn(t);
			case Out: sineOut(t);
			case InOut: sineInOut(t);
			case OutIn: sineOutIn(t);
		};
	}
	
	/**
	 * Applies the sinusoidal easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function sineIn(t:Float):Float
	{
		return -Math.cos(PI2 * t) + 1;
	}
	
	/**
	 * Applies the sinusoidal easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function sineOut(t:Float):Float
	{
		return Math.sin(PI2 * t);
	}
	
	/**
	 * Applies the sinusoidal easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function sineInOut(t:Float):Float
	{
		return t < .5 ? sineIn(t * 2) / 2 : .5 + sineOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the sinusoidal easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function sineOutIn(t:Float):Float
	{
		return t < .5 ? sineOut(t * 2) / 2 : .5 + sineIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the bounce easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function bounce(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: bounceIn(t);
			case Out: bounceOut(t);
			case InOut: bounceInOut(t);
			case OutIn: bounceOutIn(t);
		};
	}
	
	/**
	 * Applies the bounce easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function bounceIn(t:Float):Float
	{
		return 1 - bounceOut(1 - t);
	}
	
	/**
	 * Applies the bounce easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function bounceOut(t:Float):Float
	{
		if (t < B1) return 7.5625 * t * t;
		if (t < B2) return 7.5625 * (t - B3) * (t - B3) + .75;
		if (t < B4) return 7.5625 * (t - B5) * (t - B5) + .9375;
		return 7.5625 * (t - B6) * (t - B6) + .984375;
	}
	
	/**
	 * Applies the bounce easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function bounceInOut(t:Float):Float
	{
		return t < .5 ? bounceIn(t * 2) / 2 : .5 + bounceOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the bounce easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function bounceOutIn(t:Float):Float
	{
		return t < .5 ? bounceOut(t * 2) / 2 : .5 + bounceIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the circular easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function circ(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: circIn(t);
			case Out: circOut(t);
			case InOut: circInOut(t);
			case OutIn: circOutIn(t);
		};
	}
	
	/**
	 * Applies the circular easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function circIn(t:Float):Float
	{
		return -(Math.sqrt(1 - t * t) - 1);
	}
	
	/**
	 * Applies the circular easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function circOut(t:Float):Float
	{
		return Math.sqrt(1 - (t - 1) * (t - 1));
	}
	
	/**
	 * Applies the circular easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function circInOut(t:Float):Float
	{
		return t < .5 ? circIn(t * 2) / 2 : .5 + circOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the circular easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function circOutIn(t:Float):Float
	{
		return t < .5 ? circOut(t * 2) / 2 : .5 + circIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the exponential easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function expo(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: expoIn(t);
			case Out: expoOut(t);
			case InOut: expoInOut(t);
			case OutIn: expoOutIn(t);
		};
	}
	
	/**
	 * Applies the exponential easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function expoIn(t:Float):Float
	{
		if (t <= 0) return 0;
		if (t >= 1) return 1;
		return Math.pow(2, 10 * (t - 1));
	}
	
	/**
	 * Applies the exponential easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function expoOut(t:Float):Float
	{
		if (t <= 0) return 0;
		if (t >= 1) return 1;
		return -Math.pow(2, -10 * t) + 1;
	}
	
	/**
	 * Applies the exponential easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function expoInOut(t:Float):Float
	{
		return t < .5 ? expoIn(t * 2) / 2 : .5 + expoOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the exponential easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function expoOutIn(t:Float):Float
	{
		return t < .5 ? expoOut(t * 2) / 2 : .5 + expoIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the back easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function back(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: backIn(t);
			case Out: backOut(t);
			case InOut: backInOut(t);
			case OutIn: backOutIn(t);
		};
	}
	
	/**
	 * Applies the back easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function backIn(t:Float):Float
	{
		return t * t * (2.70158 * t - 1.70158);
	}
	
	/**
	 * Applies the back easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function backOut(t:Float):Float
	{
		return 1 - (--t) * (t) * (-2.70158 * t - 1.70158);
	}
	
	/**
	 * Applies the back easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function backInOut(t:Float):Float
	{
		return t < .5 ? backIn(t * 2) / 2 : .5 + backOut(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the back easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function backOutIn(t:Float):Float
	{
		return t < .5 ? backOut(t * 2) / 2 : .5 + backIn(t * 2 - 1) / 2;
	}
	
	/**
	 * Applies the elastic easing curve using the selected direction.
	 * @param t The interpolation progress value.
	 * @param type The easing direction; defaults to `InOut`.
	 * @return The eased progress value.
	 */
	public static inline function elastic(t:Float, type:EasingType = InOut):Float
	{
		return switch (type)
		{
			case In: elasticIn(t);
			case Out: elasticOut(t);
			case InOut: elasticInOut(t);
			case OutIn: elasticOutIn(t);
		};
	}
	
	/**
	 * Applies the elastic easing curve in ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function elasticIn(t:Float):Float
	{
		return -(ELASTIC_AMPLITUDE * Math.pow(2,
			10 * (t -= 1)) * Math.sin((t
				- (ELASTIC_PERIOD / (2 * Math.PI) * Math.asin(1 / ELASTIC_AMPLITUDE))) * (2 * Math.PI) / ELASTIC_PERIOD));
	}
	
	/**
	 * Applies the elastic easing curve in ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static inline function elasticOut(t:Float):Float
	{
		return (ELASTIC_AMPLITUDE * Math.pow(2,
			-10 * t) * Math.sin((t
				- (ELASTIC_PERIOD / (2 * Math.PI) * Math.asin(1 / ELASTIC_AMPLITUDE))) * (2 * Math.PI) / ELASTIC_PERIOD)
			+ 1);
	}
	
	/**
	 * Applies the elastic easing curve in ease-in/ease-out mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function elasticInOut(t:Float):Float
	{
		if (t < 0.5)
		{
			return -0.5 * (Math.pow(2, 10 * (t -= 0.5)) * Math.sin((t - (ELASTIC_PERIOD / 4)) * (2 * Math.PI) / ELASTIC_PERIOD));
		}
		return Math.pow(2, -10 * (t -= 0.5)) * Math.sin((t - (ELASTIC_PERIOD / 4)) * (2 * Math.PI) / ELASTIC_PERIOD) * 0.5 + 1;
	}
	
	/**
	 * Applies the elastic easing curve in ease-out/ease-in mode.
	 * @param t The interpolation progress value.
	 * @return The eased progress value.
	 */
	public static function elasticOutIn(t:Float):Float
	{
		return t < .5 ? (elasticOut(t * 2) - ELASTIC_OUT_START) / (ELASTIC_OUT_END - ELASTIC_OUT_START) / 2 : .5
			+ (elasticIn(t * 2 - 1) - ELASTIC_IN_START) / (ELASTIC_IN_END - ELASTIC_IN_START) / 2;
	}
	
	/**
	 * Looks up an easing function by name, ignoring case and surrounding whitespace.
	 * @param ease The easing family name, such as `quad` or `sine`.
	 * @param type The optional direction suffix to append to `ease`.
	 * @return The matching easing function, or `null` if the name is not recognized.
	 */
	public static function fromString(ease:String, ?type:EasingType):Null<EaseFunc>
	{
		var name = StringTools.trim(type == null ? ease : ease + type).toLowerCase();
		return switch (name)
		{
			case 'linear' | 'linearin' | 'linearout' | 'linearinout' | 'linearoutin': linear;
			case 'quadin': quadIn;
			case 'quadout': quadOut;
			case 'quadinout' | 'quad': quadInOut;
			case 'quadoutin': quadOutIn;
			case 'cubein': cubeIn;
			case 'cubeout': cubeOut;
			case 'cubeinout' | 'cube': cubeInOut;
			case 'cubeoutin': cubeOutIn;
			case 'quartin': quartIn;
			case 'quartout': quartOut;
			case 'quartinout' | 'quart': quartInOut;
			case 'quartoutin': quartOutIn;
			case 'quintin': quintIn;
			case 'quintout': quintOut;
			case 'quintinout' | 'quint': quintInOut;
			case 'quintoutin': quintOutIn;
			case 'smoothstepin': smoothStepIn;
			case 'smoothstepout': smoothStepOut;
			case 'smoothstepinout' | 'smoothstep': smoothStepInOut;
			case 'smoothstepoutin': smoothStepOutIn;
			case 'smootherstepin': smootherStepIn;
			case 'smootherstepout': smootherStepOut;
			case 'smootherstepinout' | 'smootherstep': smootherStepInOut;
			case 'smootherstepoutin': smootherStepOutIn;
			case 'sinein': sineIn;
			case 'sineout': sineOut;
			case 'sineinout' | 'sine': sineInOut;
			case 'sineoutin': sineOutIn;
			case 'bouncein': bounceIn;
			case 'bounceout': bounceOut;
			case 'bounceinout' | 'bounce': bounceInOut;
			case 'bounceoutin': bounceOutIn;
			case 'circin': circIn;
			case 'circout': circOut;
			case 'circinout' | 'circ': circInOut;
			case 'circoutin': circOutIn;
			case 'expoin': expoIn;
			case 'expoout': expoOut;
			case 'expoinout' | 'expo': expoInOut;
			case 'expooutin': expoOutIn;
			case 'backin': backIn;
			case 'backout': backOut;
			case 'backinout' | 'back': backInOut;
			case 'backoutin': backOutIn;
			case 'elasticin': elasticIn;
			case 'elasticout': elasticOut;
			case 'elasticinout' | 'elastic': elasticInOut;
			case 'elasticoutin': elasticOutIn;
			default: null;
		};
	}
}

/**
 * Function type for easing a progress value.
 * @param t The interpolation progress value.
 * @return The eased progress value.
 */
typedef EaseFunc = Float->Float;

/**
 * Function type for easing a progress value using an explicit easing direction.
 * @param t The interpolation progress value.
 * @param type The easing direction.
 * @return The eased progress value.
 */
typedef EaseFuncWithType = (Float, EasingType) -> Float;

/**
 * Selects the direction or combination of directions for an easing curve.
 */
enum abstract EasingType(String) from String to String
{
	/**
	 * Applies the easing curve with a slow start and increasing speed.
	 */
	var In = 'in';
	
	/**
	 * Applies the easing curve with a fast start and decreasing speed.
	 */
	var Out = 'out';
	
	/**
	 * Applies ease-in during the first half and ease-out during the second half.
	 */
	var InOut = 'inout';
	
	/**
	 * Applies ease-out during the first half and ease-in during the second half.
	 */
	var OutIn = 'outin';
}
