package tools.classes.math;

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
	 * Formats a date using a common numeric date convention for the given locale.
	 * @param day The day of the month.
	 * @param month The month of the year.
	 * @param year The year.
	 * @param locale A locale tag such as `en-US`, `pt-BR`, `de-DE`, or `ja-JP`. Defaults to `en-US`.
	 * @return The date formatted as month/day/year for `en-US`, year/month/day for Japanese or Chinese
	 * locales (with slashes) and Korean locales (with dots), or day/month/year for other locales.
	 * German and Russian locales use dots as separators.
	 */
	public static function formatDate(day:Int, month:Int, year:Int, locale:String = 'en-US'):String
	{
		var normalizedLocale = StringTools.replace(locale, '_', '-').toLowerCase();
		var dayString = StringTools.lpad(Std.string(day), '0', 2);
		var monthString = StringTools.lpad(Std.string(month), '0', 2);
		var yearString = Std.string(year);
		
		if (normalizedLocale == 'en-us' || StringTools.startsWith(normalizedLocale, 'en-us-')) return '$month/$day/$year';
		
		if (StringTools.startsWith(normalizedLocale,
			'ja') || StringTools.startsWith(normalizedLocale, 'zh')) return '$yearString/$monthString/$dayString';
			
		if (StringTools.startsWith(normalizedLocale, 'ko')) return '$yearString.$monthString.$dayString';
		
		var separator = StringTools.startsWith(normalizedLocale,
			'de') || StringTools.startsWith(normalizedLocale, 'ru') ? '.' : '/';
		return '$dayString$separator$monthString$separator$yearString';
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
	 * Converts minutes to seconds, or milliseconds to seconds when `inMs` is `true`.
	 * @param time The duration in minutes, or milliseconds when `inMs` is `true`.
	 * @param inMs Whether the input is in milliseconds instead of minutes.
	 * @return The duration in seconds.
	 */
	public static inline function toSeconds(time:Float, inMs:Bool = false):Float
	{
		return (inMs) ? time / 1000 : time * 60;
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
