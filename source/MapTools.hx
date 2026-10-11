package;

import haxe.Constraints.IMap;
#if flixel
import flixel.FlxBasic;
#end

/**
 * Utility class for `Map`.
 * **Author:** dre
 */
@:final
class MapTools {
    /**
     * Private constructor prevents `new MapTools()`.
     */
    @:noCompletion
    private function new():Void {}

    /**
     * Returns the value associated with a key, or a default value if the key is not present.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['name' => 'Ada'];
     * trace(values.getOrElse('name', 'Unknown')); // Result: Ada.
     * trace(values.getOrElse('role', 'Unknown')); // Result: Unknown.
     * ```
     * ---
     *
     * @param key The key to look up.
     * @param defaultValue The value to return if the key is not present.
     * @return The value associated with the key, or `defaultValue` if the key is not present.
     * @since 0.0.4
     */
    public inline static function getOrElse<K, V>(map:IMap<K, V>, key:K, defaultValue:V):Null<V>
        return (map.exists(key)) ? map.get(key) : defaultValue;

    /**
     * Returns the value associated with a key, creating and storing a default value if absent.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = new Map<String, Int>();
     * trace(values.getOrSet('count', function() return 0)); // Result: 0.
     * ```
     * ---
     *
     * @param key The key to look up.
     * @param defaultFactory The function used to create and store a value if the key is not present.
     * @return The existing value, or the value created by `defaultFactory`.
     * @since 0.0.4
     */
    public inline static function getOrSet<K, V>(map:IMap<K, V>, key:K, defaultFactory:()->V):V {
        if (map.exists(key))
            return map.get(key);
        else {
            var result = defaultFactory();
            map.set(key, result);
            return result;
        }
    }

    /**
     * Combines two maps into a new map.
     *
     * Values from `otherMap` replace values with matching keys from the source map.
     * Neither input map is modified.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var first = ['name' => 'Ada'];
     * var second = ['role' => 'Engineer'];
     * trace(first.merge(second)); // Result: a map containing name and role.
     * ```
     * ---
     *
     * @param otherMap The map whose entries are added to the result.
     * @return A new map containing the entries of both maps, with `otherMap` taking precedence.
     * @since 0.0.4
     */
    public inline static function merge<K, V>(map:IMap<K, V>, otherMap:IMap<K, V>):Map<K, V> {
        var result:Map<K, V> = cast map.copy();

        for (k => v in otherMap) {
            if (result.exists(k))
                result.remove(k);

            result.set(k, v);
        }

        return result;
    }

    /**
     * Creates a shallow copy of a map.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['name' => 'Ada'];
     * var copy = values.clone();
     * ```
     * ---
     *
     * @return A new map containing the same keys and values. Referenced values are not cloned.
     * @since 0.0.4
     */
    public inline static function clone<K, V>(map:IMap<K, V>):Map<K, V> {
        var copy:Map<K, V> = cast map.copy(); // Shallow copy
        return copy;
    }

    /**
     * Creates a new map with each key and value swapped.
     *
     * If multiple entries have the same value, the resulting key is associated with the
     * last corresponding key encountered in the source map.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['Ada' => 1, 'Linus' => 2];
     * trace(values.invert()); // Result: a map containing 1 => Ada and 2 => Linus.
     * ```
     * ---
     *
     * @return A new map whose keys are the source values and whose values are the source keys.
     * @since 0.0.4
     */
    @:generic
    public inline static function invert<K, V>(map:IMap<K, V>):Map<V, K> {
        var result = new Map<V, K>();

        for (k => v in map)
            result.set(v, k);

        return result;
    }

    /**
     * Indicates whether a map contains any entries.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = new Map<String, Int>();
     * trace(values.hasItems()); // Result: false.
     * ```
     * ---
     *
     * @return `true` if the map contains at least one entry; otherwise, `false`.
     * @since 0.0.4
     */
    public inline static function hasItems<K, V>(map:IMap<K, V>):Bool
        return map.keys().hasNext() && map != null;

    /**
     * Creates an array by applying a function to each key-value pair in a map.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['Ada' => 37];
     * trace(values.toArray(function(key, value) return key + ': ' + value));
     * // Result: ['Ada: 37'].
     * ```
     * ---
     *
     * @param f The function applied to each key and its value.
     * @return A new array containing the results of `f` for each entry.
     * @since 0.0.4
     */
    public inline static function toArray<K, V, T>(map:IMap<K, V>, f:(K, V)->T):Array<T> {
        var result = [];

        for (k in map.keys())
            result.push(f(k, map.get(k)));

        return result;
    }

    /**
     * Returns the keys of a map as an array.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['name' => 'Ada'];
     * trace(values.keysArray()); // Result: ['name'].
     * ```
     * ---
     *
     * @return A new array containing the map's keys.
     * @since 0.0.4
     */
    public inline static function keysArray<K, V>(map:IMap<K, V>):Array<K> {
        var result = [];

        for (k in map.keys())
            result.push(k);

        return result;
    }

    /**
     * Returns the values of a map as an array.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['name' => 'Ada'];
     * trace(values.valuesArray()); // Result: ['Ada'].
     * ```
     * ---
     *
     * @return A new array containing the map's values, or an empty array if the map is empty.
     * @since 0.0.4
     */
    public inline static function valuesArray<K, V>(map:IMap<K, V>):Array<V> {
        if (!hasItems(map)) return [];

        var result = [];

        for (v in map)
            result.push(v);

        return result;
    }

    #if flixel
    /**
     * Destroys and removes the map's values if every value is a `FlxBasic`.
     *
     * If the map contains no entries or any value is not a `FlxBasic`, it is returned unchanged.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var objects = new Map<String, FlxBasic>();
     * objects.removeDead();
     * ```
     * ---
     *
     * @return The original map.
     * @since 0.0.4
     */
    public inline static function removeDead<K, V>(map:IMap<K, V>):Map<K, V> {
        if (hasItems(map) && isMapValuesOf(map, FlxBasic)) {
            for (k in map.keys()) {
                var value = map.get(k);
                map.remove(k);
                value.destroy();
            }
        }
        return cast map;
    }
    #end

    /**
     * Creates a new map containing only the entries that match a predicate.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['Ada' => 37, 'Linus' => 54];
     * var adults = values.filter(function(name, age) return age >= 18);
     * ```
     * ---
     *
     * @param f The function used to test each key-value pair.
     * @return A new map containing the entries for which `f` returns `true`.
     * @since 0.0.4
     */
    @:generic
    public inline static function filter<K, V>(map:IMap<K, V>, f:(K, V)->Bool):Map<K, V> {
        var result = new Map<K, V>();

        for (k in map.keys()) {
            var value = map.get(k);
            if (f(k, value))
                result.set(k, value);
        }

        return result;
    }

    /**
     * Creates a new map by transforming each value while keeping its key.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values = ['Ada' => 37];
     * var labels = values.mapValues(function(age) return 'Age: ' + age);
     * ```
     * ---
     *
     * @param f The function applied to each value.
     * @return A new map with the same keys and the transformed values.
     * @since 0.0.4
     */
    @:generic
    public inline static function mapValues<K, V, R>(map:IMap<K, V>, f:V->R):Map<K, R> {
        var result = new Map<K, R>();
        for (k in map.keys())
            result.set(k, f(map.get(k)));

        return result;
    }

    /**
     * Checks whether all keys in a map are instances of a specified type.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values:Map<Dynamic, String> = ['name' => 'Ada'];
     * trace(values.isMapKeysOf(String)); // Result: true.
     * ```
     * ---
     *
     * @param type The type to check the keys against.
     * @return `true` if all keys have the specified type, `false` if any key does not,
     * or `null` if the map is empty.
     * @since 0.0.4
     */
    public static function isMapKeysOf<K, V>(map:IMap<K, V>, type:Dynamic):Null<Bool> {
        if (hasItems(map)) {
            for (k in map.keys()) {
                if (!Std.isOfType(k, type))
                    return false;
            }

            return true;
        }
        return null;
    }

    /**
     * Checks whether all values in a map are instances of a specified type.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var values:Map<String, Dynamic> = ['name' => 'Ada'];
     * trace(values.isMapValuesOf(String)); // Result: true.
     * ```
     * ---
     *
     * @param type The type to check the values against.
     * @return `true` if all values have the specified type, `false` if any value does not,
     * or `null` if the map is empty.
     * @since 0.0.4
     */
    public static function isMapValuesOf<K, V>(map:IMap<K, V>, type:Dynamic):Null<Bool> {
        if (hasItems(map)) {
            for (v in map) {
                if (!Std.isOfType(v, type))
                    return false;
            }

            return true;
        }
        return null;
    }
}