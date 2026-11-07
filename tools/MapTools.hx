package tools;

import haxe.Constraints.IMap;

#if flixel
import flixel.FlxBasic;
#end

@:nullSafety(Strict)

/**
 * Extension methods for looking up, copying, transforming, and inspecting maps.
 */
final class MapTools

{
	/**
	 * Creates a `MapTools` instance. This constructor is not intended for public use.
	 */
	@:noCompletion
	function new():Void {}
	
	/**
	 * Gets a value from a map or returns a fallback when the key is absent.
	 * @param map The map to read.
	 * @param key The key to look up.
	 * @param defaultValue The value to return if the key does not exist.
	 * @return The mapped value or the fallback value.
	 */
	public static function getOrElse<K, V>(map:IMap<K, V>, key:K,
			defaultValue:V):Null<V> return (map.exists(key)) ? map.get(key) : defaultValue;
			
	/**
	 * Gets a value from a map or creates and stores one when the key is absent.
	 * @param map The map to read and potentially modify.
	 * @param key The key to look up or insert.
	 * @param defaultFactory Creates the value to store when the key is absent.
	 * @return The existing value or the newly created value.
	 */
	public static function getOrSet<K, V>(map:IMap<K, V>, key:K, defaultFactory:() -> V):Null<V>
	{
		if (map.exists(key)) return map.get(key);
		else
		{
			var result = defaultFactory();
			map.set(key, result);
			return result;
		}
	}
	
	/**
	 * Creates a map containing the entries of both maps, with `otherMap` taking precedence.
	 * @param map The source map.
	 * @param otherMap The map whose entries override matching keys from `map`.
	 * @return A new map containing the merged entries.
	 */
	public static function merge<K, V>(map:IMap<K, V>, otherMap:IMap<K, V>):Map<K, V>
	{
		var result:Map<K, V> = cast map.copy();
		
		for (k => v in otherMap)
		{
			if (result.exists(k)) result.remove(k);
			
			result.set(k, v);
		}
		
		return result;
	}
	
	/**
	 * Creates a shallow copy of a map.
	 * @param map The map to copy.
	 * @return A new map containing the same keys and values.
	 */
	public static function clone<K, V>(map:IMap<K, V>):Map<K, V>
	{
		var copy:Map<K, V> = cast map.copy(); // Shallow copy
		return copy;
	}
	
	@:generic
	/**
	 * Creates a map with each value used as a key and its original key used as the value.
	 * @param map The map to invert.
	 * @return A new map with keys and values swapped.
	 */
	public static function invert<K, V>(map:IMap<K, V>):Map<V, K>
	{
		var result = new Map<V, K>();
		
		for (k => v in map)
			result.set(v, k);
			
		return result;
	}
	
	/**
	 * Checks whether a map contains at least one key.
	 * @param map The map to check.
	 * @return `true` if the map has at least one entry.
	 */
	public static function hasItems<K, V>(map:IMap<K, V>):Bool return map.keys().hasNext() && map != null;
	
	/**
	 * Converts map entries into an array, skipping entries whose value is `null`.
	 * @param map The map to convert.
	 * @param f Converts a key and its non-null value into an array element.
	 * @return An array of converted values.
	 */
	public static function toArray<K, V, T>(map:IMap<K, V>, f:(K, V) -> T):Array<T>
	{
		var result = [];
		
		for (k in map.keys())
		{
			var value = map.get(k);
			if (value != null) result.push(f(k, value));
		}
		
		return result;
	}
	
	/**
	 * Returns a map's keys as an array.
	 * @param map The map to read.
	 * @return An array containing the map's keys.
	 */
	public static function keysArray<K, V>(map:IMap<K, V>):Array<K>
	{
		var result = [];
		
		for (k in map.keys())
		{
			result.push(k);
		}
		
		return result;
	}
	
	/**
	 * Returns a map's values as an array.
	 * @param map The map to read.
	 * @return An array containing the map's values, or an empty array for an empty map.
	 */
	public static function valuesArray<K, V>(map:IMap<K, V>):Array<V>
	{
		if (!hasItems(map)) return [];
		
		var result = [];
		
		for (v in map)
			result.push(v);
			
		return result;
	}
	
	#if flixel
	/**
	 * If every map value is a `FlxBasic`, removes all entries and destroys their values.
	 * @param map The map of Flixel objects to clear.
	 * @return The same map after cleanup.
	 */
	public static function removeMapDead<K, V>(map:IMap<K, V>):Map<K, V>
	{
		if (hasItems(map) && isMapValuesOf(map, FlxBasic))
		{
			for (k in map.keys())
			{
				var value = cast map.get(k);
				map.remove(k);
				value.destroy();
			}
		}
		return cast map;
	}
	#end
	
	@:generic
	/**
	 * Creates a map with each non-null value transformed by a function.
	 * @param map The map to transform.
	 * @param f Transforms each non-null value.
	 * @return A new map with the same keys and transformed non-null values.
	 */
	public static function mapValues<K, V, R>(map:IMap<K, V>, f:V->R):Map<K, R>
	{
		var result = new Map<K, R>();
		for (k in map.keys())
		{
			var value = map.get(k);
			if (value != null) result.set(k, f(value));
		}
		
		return result;
	}
	
	/**
	 * Checks whether all keys in a non-empty map are instances of a type.
	 * @param map The map to inspect.
	 * @param type The type to check against.
	 * @return `true` if every key matches, `false` if one does not, or `null` for an empty map.
	 */
	public static function isMapKeysOf<K, V>(map:IMap<K, V>, type:Dynamic):Null<Bool>
	{
		if (hasItems(map))
		{
			for (k in map.keys())
			{
				if (!Std.isOfType(k, type)) return false;
			}
			
			return true;
		}
		return null;
	}
	
	/**
	 * Checks whether all values in a non-empty map are instances of a type.
	 * @param map The map to inspect.
	 * @param type The type to check against.
	 * @return `true` if every value matches, `false` if one does not, or `null` for an empty map.
	 */
	public static function isMapValuesOf<K, V>(map:IMap<K, V>, type:Dynamic):Null<Bool>
	{
		if (hasItems(map))
		{
			for (v in map)
			{
				if (!Std.isOfType(v, type)) return false;
			}
			
			return true;
		}
		return null;
	}
}
