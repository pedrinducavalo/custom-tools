package tools.classes.special;

using StringTools; // que ironico, nao?

/**
 * Utility methods for checking, transforming, and formatting strings.
 */
@:nullSafety
final class StringTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Checks whether a string is `null`, empty, or contains only whitespace.
	 * @param str The string to check.
	 * @return `true` if the string is `null`, empty, or blank after trimming.
	 */
	public static inline function isBlank(str:String):Bool
	{
		return str == null || str.trim().length == 0;
	}
	
	/**
	 * Truncates a string when its length exceeds a threshold. The threshold controls the prefix length, not the final
	 * length when a suffix is appended.
	 * @param str The string to truncate.
	 * @param maxLength The length threshold and prefix limit; values less than or equal to zero produce an empty string.
	 * @param suffix The text appended after truncation; defaults to `"..."`.
	 * @return The original string if it fits, an empty string if `maxLength` is not positive, or the first
	 * `maxLength - 1` characters followed by `suffix`. The suffix can make the result longer than `maxLength`.
	 */
	public static inline function truncate(str:String, maxLength:Int, suffix:String = '...'):String
	{
		if (maxLength <= 0) return '';
		if (str.length <= maxLength) return str;
		return str.substr(0, maxLength - 1) + suffix;
	}
	
	/**
	 * Reverses the order of the characters in a string.
	 * @param str The string to reverse.
	 * @return A new string with the characters in reverse order.
	 */
	public static inline function reverse(str:String):String
	{
		var buf = new StringBuf();
		
		var i = str.length - 1;
		while (i >= 0)
		{
			buf.add(str.charAt(i));
			i--;
		}
		
		return buf.toString();
	}
	
	/**
	 * Removes the specified prefix if the string starts with it.
	 * @param str The string to inspect.
	 * @param prefix The prefix to remove.
	 * @return The string without `prefix` when it starts with it; otherwise, the original string.
	 */
	public static inline function stripPrefix(str:String, prefix:String):String
	{
		if (str.startsWith(prefix)) return str.substr(prefix.length);
		return str;
	}
	
	/**
	 * Removes the specified suffix if the string ends with it.
	 * @param str The string to inspect.
	 * @param suffix The suffix to remove.
	 * @return The string without `suffix` when it ends with it; otherwise, the original string.
	 */
	public static inline function stripSuffix(str:String, suffix:String):String
	{
		if (str.endsWith(suffix)) return str.substr(0, str.length - suffix.length);
		return str;
	}
	
	/**
	 * Converts a string to title case, separating words at whitespace, hyphens, and underscores.
	 * Each word starts with an uppercase letter and continues in lowercase; separators become spaces.
	 * @param str The string to convert.
	 * @return The title-cased string.
	 */
	public static inline function toTitleCase(str:String):String
	{
		var separator = ~/[\s\-_]+/g;
		var words = separator.split(str.trim());
		
		var buf = new StringBuf();
		
		var firstWord = true;
		for (word in words)
		{
			if (isBlank(word)) continue;
			
			if (!firstWord) buf.add(' ');
			var firstChar = word.charAt(0).toUpperCase();
			var rest = word.substr(1).toLowerCase();
			buf.add(firstChar + rest);
			firstWord = false;
		}
		
		return buf.toString();
	}
	
	/**
	 * Converts a string to camel case, separating words at whitespace, hyphens, and underscores.
	 * @param str The string to convert.
	 * @param type Whether the first word starts in lowercase (`Lower`) or uppercase (`Upper`); defaults to `Lower`.
	 * @return The camel-cased string with separators removed.
	 */
	public static inline function toCamelCase(str:String, type:CaseType = Lower):String
	{
		var separator = ~/[\s\-_]+/g;
		var words = separator.split(str.trim());
		
		var buf = new StringBuf();
		
		var firstWord = true;
		for (word in words)
		{
			if (isBlank(word)) continue;
			
			if (firstWord)
			{
				if (type == Lower)
				{
					buf.add(word.toLowerCase());
				}
				else
				{
					var firstChar = word.charAt(0).toUpperCase();
					var rest = word.substr(1).toLowerCase();
					buf.add(firstChar + rest);
				}
				firstWord = false;
			}
			else
			{
				var firstChar = word.charAt(0).toUpperCase();
				var rest = word.substr(1).toLowerCase();
				buf.add(firstChar + rest);
			}
		}
		
		return buf.toString();
	}
	
	/**
	 * Converts whitespace-, hyphen-, and underscore-separated words to kebab case.
	 * Leading and trailing separators are removed, and consecutive separators become one hyphen.
	 * @param str The string to convert.
	 * @param type Whether the result is lowercase (`Lower`) or uppercase (`Upper`); defaults to `Lower`.
	 * @return The converted string with words separated by hyphens.
	 */
	public static inline function toKebabCase(str:String, type:CaseType = Lower):String
	{
		var edgeSeparators = ~/^[\s\-_]+|[\s\-_]+$/g; // que que eu to fazendo da vida😢
		var separator = ~/[\s\-_]+/g;
		var normalized = separator.replace(edgeSeparators.replace(str.trim(), ''), '-');
		if (type == Lower) return normalized.toLowerCase();
		return normalized.toUpperCase();
	}
	
	/**
	 * Converts whitespace-, hyphen-, and underscore-separated words to snake case.
	 * Leading and trailing separators are removed, and consecutive separators become one underscore.
	 * @param str The string to convert.
	 * @param type Whether the result is lowercase (`Lower`) or uppercase (`Upper`); defaults to `Lower`.
	 * @return The converted string with words separated by underscores.
	 */
	public static inline function toSnakeCase(str:String, type:CaseType = Lower):String
	{
		var edgeSeparators = ~/^[\s\-_]+|[\s\-_]+$/g;
		var separator = ~/[\s\-_]+/g;
		var normalized = separator.replace(edgeSeparators.replace(str.trim(), ''), '_');
		if (type == Lower) return normalized.toLowerCase();
		return normalized.toUpperCase();
	}
}

/**
 * Selects the letter case used when converting strings.
 */
enum CaseType
{
	/**
	 * Produces lowercase text.
	 */
	Lower;
	
	/**
	 * Produces uppercase text.
	 */
	Upper;
}
