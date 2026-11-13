package tools.classes.iterables;

#if flixel
import flixel.FlxBasic;
#end

/**
 * Extension methods for reading, transforming, and managing arrays.
 */
final class ArrayTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Returns the first element of an array.
	 * @param array The array to read.
	 * @return The first element, or `null` when the array is empty.
	 */
	public static inline function first<T>(array:Array<T>):Null<T>
	{
		return array[0];
	}
	
	/**
	 * Returns the last element of an array.
	 * @param array The array to read.
	 * @return The last element, or `null` when the array is empty.
	 */
	public static inline function last<T>(array:Array<T>):Null<T>
	{
		return array[array.length - 1];
	}
	
	/**
	 * Removes all elements from an array. With the `flixel` define, also destroys each popped element as a `FlxBasic`.
	 * @param array The array to clear.
	 */
	public static inline function clear<T>(array:Array<T>)
	{
		while (hasItems(array))
		{
			#if flixel
			var flx:FlxBasic = cast array.pop();
			flx.destroy();
			#else
			array.pop();
			#end
		}
	}
	
	/**
	 * Creates a shallow copy of an array.
	 * @param array The array to copy.
	 * @return A new array containing the same elements.
	 */
	public static inline function clone<T>(array:Array<T>):Array<T>
	{
		return [for (i in array) i];
	}
	
	/**
	 * Adds the values in a non-empty numeric array. For a non-numeric array, returns its length.
	 * @param array The array to sum.
	 * @return The numeric total or array length, or `null` when the array is empty.
	 */
	public static inline function sum<T>(array:Array<T>):Null<Dynamic>
	{
		if (!hasItems(array)) return null;
		
		var bool:Bool = isArrayOf(array, Int) || isArrayOf(array, Float);
		var total:Dynamic = (bool) ? 0 : array.length;
		
		if (bool)
		{
			for (i in 0...array.length)
				total += array[i];
		}
		
		return total;
	}
	
	/**
	 * Subtracts each remaining value in a non-empty numeric array from its first value.
	 * For a non-numeric array, returns the negative array length.
	 * @param array The array to subtract.
	 * @return The result, or `null` when the array is empty.
	 */
	public static inline function sub<T>(array:Array<T>):Null<Dynamic>
	{
		if (!hasItems(array)) return null;
		
		var bool = isArrayOf(array, Int) || isArrayOf(array, Float);
		var total:Dynamic = (bool) ? array[0] : 0;
		
		if (bool)
		{
			for (i in 1...array.length)
			{
				total -= cast array[i];
			}
		}
		else
		{
			for (i in 0...array.length)
			{
				total--;
			}
		}
		
		return total;
	}
	
	/**
	 * Returns the item following `curItem`, or the first item when wrapping from the end.
	 * @param array The array to read.
	 * @param curItem The current item index.
	 * @param wrap Whether to return the first item when `curItem` is the last index.
	 * @return The next item, or `null` when the array is empty, the index is invalid, or wrapping is disabled at the end.
	 */
	public static inline function nextItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T>
	{
		if (!hasItems(array) || curItem < 0 || curItem >= array.length) return null;
		
		if (curItem == array.length - 1) return wrap ? array[0] : null;
		
		return array[curItem + 1];
	}
	
	/**
	 * Returns the item preceding `curItem`, or the last item when wrapping from the start.
	 * @param array The array to read.
	 * @param curItem The current item index.
	 * @param wrap Whether to return the last item when `curItem` is the first index.
	 * @return The previous item, or `null` when the array is empty, the index is invalid, or wrapping is disabled at the start.
	 */
	public static inline function previousItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T>
	{
		if (!hasItems(array) || curItem < 0 || curItem >= array.length) return null;
		
		if (curItem == 0) return wrap ? array[array.length - 1] : null;
		
		return array[curItem - 1];
	}
	
	/**
	 * Checks whether every element in an array is an instance of a type.
	 * @param array The array to inspect.
	 * @param type The type to check against.
	 * @return `true` if every element matches, `false` if one does not, or `null` for an empty array.
	 */
	public static function isArrayOf<T>(array:Array<T>, type:Dynamic):Null<Bool>
	{
		if (!hasItems(array)) return null;
		
		for (i in array)
		{
			if (!Std.isOfType(i, type)) return false;
		}
		return true;
	}
	
	#if flixel
	/**
	 * Removes and destroys elements whose `alive` or `exists` flag is false.
	 * @param array The array of Flixel objects to inspect.
	 */
	public static inline function removeArrayDead<T:FlxBasic>(array:Array<T>)
	{
		for (i in array)
		{
			if (!i.alive || !i.exists)
			{
				array.remove(i);
				i.destroy();
			}
		}
	}
	#end
	
	/**
	 * Selects up to `n` random elements without replacement, leaving the source array unchanged.
	 * @param array The array to sample.
	 * @param n The maximum number of elements to select.
	 * @return The selected elements, or an empty array if the source is empty or `n` is not positive.
	 */
	public static inline function sample<T>(array:Array<T>, n:Int):Array<T>
	{
		if (!hasItems(array)) return [];
		
		var copy = array.copy();
		var result = [];
		
		var count = (n > copy.length) ? copy.length : n;
		
		for (_ in 0...count)
			result.push(copy.splice(Std.random(copy.length), 1)[0]);
			
		return result;
	}
	
	/**
	 * Reads a named field from every array element.
	 * @param array The array of objects to read.
	 * @param key The reflected field name.
	 * @return An array containing the field values.
	 */
	public static inline function pluck<T, V>(array:Array<T>, key:String):Array<V>
	{
		return [for (i in array) (Reflect.field(i, key) : V)];
	}
	
	/**
	 * Creates a new array with duplicate values removed, preserving the last occurrence of each value.
	 * @param array The array to deduplicate.
	 * @return A new array of unique values in the order of their last occurrences.
	 */
	@:generic
	public static inline function unique<T>(array:Array<T>):Array<T>
	{
		if (!hasItems(array)) return [];
		
		var seen = new Map<T, Bool>();
		var result = [];
		
		for (i in array)
		{
			if (seen.exists(i))
			{
				seen.remove(i);
				result.remove(i);
			}
			
			seen.set(i, true);
			result.push(i);
		}
		
		return result;
	}
	
	/**
	 * Creates a new array without elements whose values occur in `values`, preserving order.
	 * @param array The source array, which is not modified.
	 * @param values The values to exclude.
	 * @return The source elements not found in `values`, or a copy of `array` when `values` is empty.
	 */
	public static inline function without<T>(array:Array<T>, values:Array<T>):Array<T>
	{
		return [for (i in array) if (values.indexOf(i) == -1) i];
	}
	
	/**
	 * Checks whether an array contains at least one element.
	 * @param array The array to check.
	 * @return `true` if the array is non-empty.
	 */
	public static inline function hasItems<T>(array:Array<T>):Bool
	{
		return array.length > 0 && array != null;
	}
	
	/**
	 * Splits an array into consecutive chunks of the requested size.
	 * @param array The array to split.
	 * @param size The positive maximum number of elements per chunk; must be greater than zero.
	 * @return The resulting chunks in their original order.
	 */
	public static inline function chunk<T>(array:Array<T>, size:Int):Array<Array<T>>
	{
		if (size <= 0) throw "Chunk size must be greater than zero.";
		
		var result = [];
		
		var index = 0;
		while (index < array.length)
		{
			result.push(array.slice(index, index + size));
			index += size;
		}
		
		return result;
	}
}
