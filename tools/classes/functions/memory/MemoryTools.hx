package tools.classes.functions.memory;

/**
 * Utilities for converting, formatting, and aligning memory sizes.
 */
@:nullSafety
final class MemoryTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Converts bytes to kibibytes using a base of 1024.
	 * @param bytes The size in bytes.
	 * @return The size in kibibytes.
	 */
	public static inline function bytesToKilobytes(bytes:Float):Float
	{
		return bytes / 1024;
	}
	
	/**
	 * Converts kibibytes to bytes using a base of 1024.
	 * @param kilobytes The size in kibibytes.
	 * @return The size in bytes.
	 */
	public static inline function kilobytesToBytes(kilobytes:Float):Float
	{
		return kilobytes * 1024;
	}
	
	/**
	 * Converts bytes to mebibytes using a base of 1024.
	 * @param bytes The size in bytes.
	 * @return The size in mebibytes.
	 */
	public static inline function bytesToMegabytes(bytes:Float):Float
	{
		return bytes / (1024 * 1024);
	}
	
	/**
	 * Converts mebibytes to bytes using a base of 1024.
	 * @param megabytes The size in mebibytes.
	 * @return The size in bytes.
	 */
	public static inline function megabytesToBytes(megabytes:Float):Float
	{
		return megabytes * (1024 * 1024);
	}
	
	/**
	 * Converts bytes to gibibytes using a base of 1024.
	 * @param bytes The size in bytes.
	 * @return The size in gibibytes.
	 */
	public static inline function bytesToGigabytes(bytes:Float):Float
	{
		return bytes / (1024 * 1024 * 1024);
	}
	
	/**
	 * Converts gibibytes to bytes using a base of 1024.
	 * @param gigabytes The size in gibibytes.
	 * @return The size in bytes.
	 */
	public static inline function gigabytesToBytes(gigabytes:Float):Float
	{
		return gigabytes * (1024 * 1024 * 1024);
	}
	
	/**
	 * Formats a non-negative byte count using binary units.
	 * @param bytes The size in bytes.
	 * @param decimals The number of decimal places for scaled units, from 0 to 10.
	 * @return A formatted size such as `1.5 KiB`.
	 */
	public static function formatBytes(bytes:Float, decimals:Int = 2):String
	{
		if (bytes < 0) throw 'Byte count must not be negative.';
		if (decimals < 0 || decimals > 10) throw 'Decimal places must be between 0 and 10.';
		
		var units = ['B', 'KiB', 'MiB', 'GiB', 'TiB'];
		var value = bytes;
		var unitIndex = 0;
		
		while (value >= 1024 && unitIndex < units.length - 1)
		{
			value /= 1024;
			unitIndex++;
		}
		
		if (unitIndex == 0) return '${Math.floor(value)} ${units[unitIndex]}';
		
		var factor = Math.pow(10, decimals);
		var rounded = Math.round(value * factor) / factor;
		return '$rounded ${units[unitIndex]}';
	}
	
	/**
	 * Rounds a non-negative byte count up to the next multiple of an alignment.
	 * @param bytes The size in bytes.
	 * @param alignment The positive alignment in bytes.
	 * @return The aligned size in bytes.
	 */
	public static function alignUp(bytes:Int, alignment:Int):Int
	{
		validateAlignment(bytes, alignment);
		
		var remainder = bytes % alignment;
		if (remainder == 0) return bytes;
		
		var padding = alignment - remainder;
		if (bytes > 2147483647 - padding) throw 'Aligned byte count exceeds the maximum Int value.';
		return bytes + padding;
	}
	
	/**
	 * Rounds a non-negative byte count down to the previous multiple of an alignment.
	 * @param bytes The size in bytes.
	 * @param alignment The positive alignment in bytes.
	 * @return The aligned size in bytes.
	 */
	public static function alignDown(bytes:Int, alignment:Int):Int
	{
		validateAlignment(bytes, alignment);
		return bytes - bytes % alignment;
	}
	
	/**
	 * Checks whether a non-negative byte count is a multiple of an alignment.
	 * @param bytes The size in bytes.
	 * @param alignment The positive alignment in bytes.
	 * @return `true` when the size is aligned.
	 */
	public static function isAligned(bytes:Int, alignment:Int):Bool
	{
		validateAlignment(bytes, alignment);
		return bytes % alignment == 0;
	}
	
	private static function validateAlignment(bytes:Int, alignment:Int):Void
	{
		if (bytes < 0) throw 'Byte count must not be negative.';
		if (alignment <= 0) throw 'Alignment must be greater than zero.';
	}
}
