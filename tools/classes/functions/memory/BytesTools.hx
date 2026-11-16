package tools.classes.functions.memory;

import haxe.io.Bytes;

/**
 * Utilities for copying, combining, searching, and encoding byte sequences.
 */
@:nullSafety
final class BytesTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Creates a copy of a byte sequence.
	 * @param bytes The bytes to copy.
	 * @return A new byte sequence with the same contents.
	 */
	public static inline function copy(bytes:Bytes):Bytes
	{
		return bytes.sub(0, bytes.length);
	}
	
	/**
	 * Concatenates byte sequences in order.
	 * @param values The byte sequences to concatenate.
	 * @return A new byte sequence containing all input bytes.
	 */
	public static function concat(values:Array<Bytes>):Bytes
	{
		var length = 0;
		for (bytes in values)
			length += bytes.length;
			
		var result = Bytes.alloc(length);
		var offset = 0;
		for (bytes in values)
		{
			result.blit(offset, bytes, 0, bytes.length);
			offset += bytes.length;
		}
		
		return result;
	}
	
	/**
	 * Fills a byte sequence with a byte value.
	 * @param bytes The sequence to modify.
	 * @param value The byte value from 0 to 255.
	 */
	public static function fill(bytes:Bytes, value:Int):Void
	{
		if (value < 0 || value > 255) throw 'Byte value must be between 0 and 255.';
		
		for (index in 0...bytes.length)
			bytes.set(index, value);
	}
	
	/**
	 * Checks whether two byte sequences have identical contents.
	 * @param a The first sequence.
	 * @param b The second sequence.
	 * @return `true` when both sequences are identical.
	 */
	public static inline function equals(a:Bytes, b:Bytes):Bool
	{
		return a.compare(b) == 0;
	}
	
	/**
	 * Finds the first occurrence of a byte sequence.
	 * @param bytes The sequence to search.
	 * @param pattern The sequence to find.
	 * @param start The first index to search from.
	 * @return The matching index, or `-1` if there is no match.
	 */
	public static function indexOf(bytes:Bytes, pattern:Bytes, start:Int = 0):Int
	{
		if (start < 0) throw 'Start index must not be negative.';
		if (start > bytes.length) return -1;
		if (pattern.length == 0) return start;
		if (pattern.length > bytes.length - start) return -1;
		
		var lastStart = bytes.length - pattern.length;
		for (index in start...(lastStart + 1))
		{
			var matches = true;
			for (patternIndex in 0...pattern.length)
			{
				if (bytes.get(index + patternIndex) != pattern.get(patternIndex))
				{
					matches = false;
					break;
				}
			}
			if (matches) return index;
		}
		
		return -1;
	}
	
	/**
	 * Encodes bytes as lowercase hexadecimal text.
	 * @param bytes The sequence to encode.
	 * @return A hexadecimal string with two characters per byte.
	 */
	public static inline function toHex(bytes:Bytes):String
	{
		return bytes.toHex();
	}
	
	/**
	 * Decodes hexadecimal text into bytes.
	 * @param hex The even-length hexadecimal string to decode.
	 * @return The decoded byte sequence.
	 */
	public static inline function fromHex(hex:String):Bytes
	{
		return Bytes.ofHex(hex);
	}
}
