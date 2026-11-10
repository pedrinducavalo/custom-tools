package tools.math;

/**
 * Utility methods for formatting times and converting between common time units.
 */
@:nullSafety
final class TimeTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Formats a non-negative duration as minutes and seconds, or hours, minutes, and seconds when needed.
	 * @param seconds The duration in seconds; negative values are treated as zero.
	 * @param showMs Whether to append milliseconds as a three-digit fractional part.
	 * @return The formatted time, such as `02:05`, `1:02:05`, or `02:05.125`.
	 */
	public static function formatTime(seconds:Float, showMs:Bool = false):String
	{
		seconds = Math.max(seconds, 0);
		
		var totalSeconds = Math.floor(seconds);
		var hours = Math.floor(totalSeconds / 3600);
		var minutes = Math.floor(toMinutes(totalSeconds % 3600));
		var secs = totalSeconds % 60;
		
		var minStr:String = StringTools.lpad(Std.string(minutes), '0', 2);
		var secStr:String = StringTools.lpad(Std.string(secs), '0', 2);
		
		var result:String = (hours > 0) ? '$hours:$minStr:$secStr' : '$minStr:$secStr';
		
		if (showMs)
		{
			var ms:Int = Math.floor(toMs(seconds - totalSeconds));
			var msStr:String = StringTools.lpad(Std.string(ms), '0', 3);
			result += '.$msStr';
		}
		
		return result;
	}
	
	/**
	 * Converts seconds to milliseconds.
	 * @param seconds The duration in seconds.
	 * @return The duration in milliseconds.
	 */
	public static inline function toMs(seconds:Float)
	{
		return seconds * 1000;
	}
	
	/**
	 * Converts minutes to seconds.
	 * @param minutes The duration in minutes.
	 * @return The duration in seconds.
	 */
	public static inline function toSeconds(minutes:Float):Float
	{
		return minutes * 60;
	}
	
	/**
	 * Converts a time value between hours and minutes.
	 * @param time The time value to convert.
	 * @param isHours If `true`, converts hours to minutes; otherwise, converts seconds to minutes.
	 * @return The converted time value.
	 */
	public static inline function toMinutes(time:Float, isHours:Bool = false):Float
	{
		return (isHours) ? time * 60 : time / 60;
	}
}
