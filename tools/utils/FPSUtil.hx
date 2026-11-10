package tools.utils;

/**
 * Helpers for obtaining frame time and scaling interpolation ratios to the current frame rate.
 */
@:nullSafety
final class FPSUtil
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Returns the elapsed time for the current frame using the active framework's timer.
	 * Falls back to the duration of a 60 FPS frame when no supported framework is defined.
	 * @return The current frame's delta time in seconds.
	 */
	public static inline function getDeltaTime():Float
	{
		#if flixel
		return flixel.FlxG.elapsed;
		#elseif haxepunk // nao faço ideia se isso funciona bru
		return haxepunk.HXP.elapsed;
		#elseif ceramic
		return ceramic.App.app.delta;
		#elseif heaps
		return hxd.Timer.elapsedTime;
		#else
		return 1 / 60;
		#end
	}
	
	/**
	 * Adjusts a per-frame interpolation ratio for the elapsed frame time.
	 * @param ratio The interpolation ratio for a 60 FPS frame.
	 * @param delta The frame duration in seconds; defaults to {@link getDeltaTime()}.
	 * @return The frame-rate-adjusted ratio.
	 */
	public static inline function getFPSRatio(ratio:Float, ?delta:Float):Float
	{
		return 1 - Math.pow(1 - ratio, (delta != null ? delta : getDeltaTime()) * 60);
	}
}
