package tools;

#if flixel
import flixel.FlxBasic;
#end

@:nullSafety(Strict)

/**
	Extension methods for reading, transforming, and managing arrays.
**/
final class ArrayTools

{
	@:noCompletion
	function new() {}
	
	/**
		Returns the first element of an array.
		@param array The array to read.
		@return The first element, or `null` when the array is empty.
	**/
	public static function first<T>(array:Array<T>):Null<T>
	{
		return array[0];
	}
	
	/**
		Returns the last element of an array.
		@param array The array to read.
		@return The last element, or `null` when the array is empty.
	**/
	public static function last<T>(array:Array<T>):Null<T>
	{
		return array[array.length - 1];
	}
	
	/**
		Removes all elements from an array. With the `flixel` define, also destroys each popped element as a `FlxBasic`.
		@param array The array to clear.
	**/
	public static function clear<T>(array:Array<T>)
	{
		while (hasItems(array))
		{
			#if flixel
			var flx:FlxBasic = array.pop();
			flx.destroy();
			#else
			array.pop();
			#end
		}
	}
	
	/**
		Creates a shallow copy of an array.
		@param array The array to copy.
		@return A new array containing the same elements.
	**/
	public static function clone<T>(array:Array<T>):Array<T>
	{
		return [for (i in array) i];
	}
	
	/**
		Adds the values in a non-empty numeric array. For a non-numeric array, returns its length.
		@param array The array to sum.
		@return The numeric total or array length, or `null` when the array is empty.
	**/
	public static function sum<T>(array:Array<T>):Null<Dynamic>
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
		Subtracts every value in a non-empty numeric array from its first value, including the first value itself.
		For a non-numeric array, returns the negative array length.
		@param array The array to subtract.
		@return The result, or `null` when the array is empty.
	**/
	public static function sub<T>(array:Array<T>):Null<Dynamic>
	{
		if (!hasItems(array)) return null;
		
		var bool = isArrayOf(array, Int) || isArrayOf(array, Float);
		var total:Dynamic = (bool) ? array[0] : 0;
		
		if (bool)
		{
			for (i in 0...array.length + 1)
			{
				total -= (i < array.length) ? (cast array[i] : Dynamic) : 0;
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
		Returns the first item when `curItem` is not the last index and `wrap` is enabled.
		When `curItem` is the last index, attempts to return the item after it; otherwise returns `null`.
		@param array The array to read.
		@param curItem The current item index.
		@param wrap Whether to return the first item when the current index is outside the last index.
		@return The first item, the item at `curItem + 1`, or `null`, according to the current index and `wrap`.
	**/
	public static function nextItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T>
	{
		if (!hasItems(array)) return null;
		
		if (curItem > (array.length - 1) || curItem < (array.length - 1))
		{
			if (wrap)
			{
				return array[0];
			}
		}
		else return
		{
			array[curItem + 1];
		}
		
		return null;
	}
	
	/**
		Returns the last item when `curItem` is not the last index and `wrap` is enabled.
		When `curItem` is the last index, returns the preceding item.
		@param array The array to read.
		@param curItem The current item index.
		@param wrap Whether to return the last item when the current index is outside the last index.
		@return The last item, the preceding item, or `null`, according to the current index and `wrap`.
	**/
	public static function previousItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T>
	{
		if (!hasItems(array)) return null;
		
		var lengthIndex:Int = array.length - 1;
		
		if (curItem < lengthIndex || curItem > lengthIndex)
		{
			if (wrap) return array[lengthIndex];
		}
		else
		{
			return array[curItem - 1];
		}
		
		return null;
	}
	
	/**
		Checks whether every element in an array is an instance of a type.
		@param array The array to inspect.
		@param type The type to check against.
		@return `true` if every element matches, `false` if one does not, or `null` for an empty array.
	**/
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
		Removes and destroys elements whose `alive` or `exists` flag is false.
		@param array The array of Flixel objects to inspect.
	**/
	public static function removeArrayDead<T:FlxBasic>(array:Array<T>)
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
		Returns the first element that matches a predicate.
		@param array The array to search.
		@param predicate The condition to test for each element.
		@return The first matching element, or `null` if there is no match.
	**/
	public static function find<T>(array:Array<T>, predicate:T->Bool):Null<T>
	{
		for (i in array)
		{
			if (predicate(i)) return i;
		}
		return null;
	}
	
	/**
		Selects up to `n` random elements without replacement, leaving the source array unchanged.
		@param array The array to sample.
		@param n The maximum number of elements to select.
		@return The selected elements, or an empty array if the source is empty or `n` is not positive.
	**/
	public static function sample<T>(array:Array<T>, n:Int):Array<T>
	{
		if (!hasItems(array)) return [];
		
		var copy = array.copy();
		var result = [];
		
		var count = (n > copy.length) ? copy.length : n;
		
		for (i in 0...count)
			result.push(copy.splice(Std.random(copy.length), 1)[0]);
			
		return result;
	}
	
	/**
		Reads a named field from every array element.
		@param array The array of objects to read.
		@param key The reflected field name.
		@return An array containing the field values.
	**/
	public static function pluck<T, V>(array:Array<T>, key:String):Array<V>
	{
		return [for (i in array) (Reflect.field(i, key) : V)];
	}
	
	@:generic
	/**
		Returns an array with duplicate values removed, preserving the first occurrence of each value.
		@param array The array to deduplicate.
		@return A new array of unique values.
	**/
	public static function unique<T>(array:Array<T>):Array<T>
	{
		if (!hasItems(array)) return [];
		
		var seen = new Map<T, Bool>();
		var result = [];
		
		for (i in array)
		{
			if (!seen.exists(i))
			{
				seen.set(i, true);
				result.push(i);
			}
		}
		
		return result;
	}
	
	/**
		Concatenates one level of nested arrays.
		@param array The nested arrays to flatten.
		@return A new array containing the elements of each inner array in order.
	**/
	public static function flatten<T>(array:Array<Array<T>>):Array<T>
	{
		if (!hasItems(array)) return [];
		
		var result = [];
		
		for (s in array)
		{
			if (hasItems(s))
			{
				for (i in s)
					result.push(i);
			}
		}
		
		return result;
	}
	
	/**
		Removes the specified values from the original array.
		@param array The array to modify.
		@param values The values to remove.
		@return The modified original array.
	**/
	public static function without<T>(array:Array<T>, values:Array<T>):Array<T>
	{
		for (i in values)
			array.remove(i);
			
		return array;
	}
	
	/**
		Checks whether an array contains at least one element.
		@param array The array to check.
		@return `true` if the array is non-empty.
	**/
	public static inline function hasItems<T>(array:Array<T>):Bool
	{
		return array.length > 0;
	}
}
