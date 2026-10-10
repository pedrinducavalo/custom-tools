package;

#if flixel
import flixel.FlxBasic;
import flixel.FlxG;
#end

/**
 * Utility class for `Array`.
 * **Author:** dre
 */
@:final
class ArrayTools {
    /**
     * Private constructor prevents `new ArrayTools()`.
     */
    @:noCompletion
    private function new():Void {}

    /**
     * Returns the first item of an `Array`.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<String> = ['First', 'Last'];
     * trace(myArray.firstItem()); // Result: First.
     * ```
     * ---
     * 
     * @return The first item in the list (or `null` if the list is empty).
     * @since 0.0.1
     */
    public inline static function firstItem<T>(array:Array<T>):Null<T>
        return hasItems(array) ? array[0] : null;

    /**
     * Returns the last item of an `Array`.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<String> = ['First', 'Last'];
     * trace(myArray.lastItem()); // Result: Last.
     * ```
     * ---
     * 
     * @return The last item in the list (or `null` if the list is empty).
     * @since 0.0.1
     */
    public inline static function lastItem<T>(array:Array<T>):Null<T>
        return hasItems(array) ? array[array.length - 1] : null;

    /**
     * Indicates whether the `Array` contains items.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<String> = [];
     * trace(myArray.hasItems()); // Result: false.
     * ```
     * ---
     * 
     * @return `true` if the list contains any item; otherwise, `false`.
     * @since 0.0.1
     */
    public inline static function hasItems<T>(array:Array<T>):Bool
        return array.length > 0 && array != null;

    /**
     * Randomly shuffles the items of an `Array`.
     * @since 0.0.1
     */
    public inline static function shuffle<T>(array:Array<T>):Array<T> {
        var i:Int = array.length;

        while (i > 1) {
            i--;
            var j:Int = Std.random(i + 1);

            var temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }

        return array;
    }

    /**
     * Returns a random item from an `Array`.
     * @return A random item from the list (or `null` if the list is empty).
     * @since 0.0.1
     */
    public inline static function randomItem<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            #if flixel
            return FlxG.random.getObject(array);
            #else
            return array[Std.random(array.length)];
            #end
        }
        return null;
    }

    /**
     * Sums all items in a numeric `Array`.
     * If the `Array` is of another type, the item count is returned as the result.
     * 
     * ---
     * **Usage examples:**
     * ```haxe
     * var floatArray:Array<Float> = [1.27, 3.18, 2.72];
     * var intArray:Array<Int> = [2, 9, 6];
     * var stringArray:Array<String> = ['One', 'Two', 'Three'];
     * trace(floatArray.sum()); // Result: 7.17.
     * trace(intArray.sum()); // Result: 17.
     * trace(stringArray.sum()); // Result: 3.
     * ```
     * ---
     * 
     * @return The sum of all items in the list (or `null` if the list is empty).
     * @since 0.0.1
     */
    public inline static function sum<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            var bool:Bool = isArrayOf(array, Int) || isArrayOf(array, Float);
            var total:Dynamic = (bool) ? 0 : array.length;
            if (bool) {
                for (i in 0...array.length)
                    total += array[i];
            }
            return total;
        }
        return null;
    }

    /**
     * Subtracts all items from a numeric `Array`.
     * If the `Array` is not of that type, it returns the negative item count.
     * 
     * ---
     * **Usage examples:**
     * ```haxe
     * var floatArray:Array<Float> = [1.27, 3.18, 2.72];
     * var intArray:Array<Int> = [2, 9, 6];
     * var stringArray:Array<String> = ['One', 'Two', 'Three'];
     * trace(floatArray.sub()); // Result: -4.63.
     * trace(intArray.sub()); // Result: -13.
     * trace(stringArray.sub()); // Result: -3.
     * ```
     * ---
     * 
     * @return The result of subtracting the items (or `null` if the list is empty).
     * @since 0.0.1
     */
    public inline static function sub<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            var bool = isArrayOf(array, Int) || isArrayOf(array, Float);
            var total:Dynamic = (bool) ? array[0] : 0;
            if (bool) {
                for (i in 0...array.length + 1) // Skip the first item because subtraction starts from it.
                    total -= (i < array.length) ? (cast array[i]:Dynamic) : 0;
            } else {
                for (i in 0...array.length)
                    total--;
            }
            return total;
        }
        return null;
    }

    /**
     * Returns an item based on the current item.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<String> = ['First', 'Second'];
     * trace(myArray.nextItem(0)); // Result: Second.
     * trace(myArray.nextItem(2, true)); // Result: First.
     * ```
     * ---
     * 
     * @param curItem The index of the current item.
     * @param wrap If `true`, returns the first item when passing beyond the list bounds.
     * @return The next item in the list (or `null` if the list is empty,
     * or the index is out of bounds and `wrap` is disabled).
     * @since 0.0.1
     */
    public inline static function nextItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T> {
        if (hasItems(array)) {
            if (curItem > (array.length - 1) || curItem < (array.length - 1)) {
                if (wrap)
                    return array[0];
            } else return array[curItem + 1];
        } 
        return null;
    }

    /**
     * Returns an item based on the current item.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<String> = ['First', 'Second'];
     * trace(myArray.previousItem(1)); // Result: First.
     * trace(myArray.previousItem(0, true)); // Result: Second.
     * ```
     * ---
     * 
     * @param curItem The index of the current item.
     * @param wrap If `true`, returns the last item when passing beyond the list bounds.
     * @return The previous item in the list (or `null` if the list is empty,
     * or the index is out of bounds and `wrap` is disabled).
     * @since 0.0.1
     */
    public inline static function previousItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T> {
        if (hasItems(array)) {
            var lengthIndex:Int = array.length - 1;
            if (curItem < lengthIndex || curItem > lengthIndex) {
                if (wrap)
                    return array[lengthIndex];
            } else return array[curItem - 1];
        } 
        return null;
    }

    /**
     * Returns whether an `Array` is of a specific type.
     * 
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray = ['Yes', 'No'];
     * trace(myArray.isArrayOf(String)); // Result: true
     * ```
     * ---
     * 
     * @param type The target type of the `Array`.
     * @return `true` if all items are of that type, `false` if any are not,
     * and `null` if the list is empty.
     * @since 0.0.1
     */
    public static function isArrayOf<T>(array:Array<T>, type:Dynamic):Null<Bool> {
        if (!hasItems(array)) return null;

        for (i in array) {
            if (!Std.isOfType(i, type))
                return false;
        }
        return true;
    }

    /**
     * Destroys items that are instances of `FlxBasic` and clears the `Array`.
     *
     * If the list is already empty, returns a new empty `Array`.
     *
     * @return The cleared list or a new empty `Array` if the original list was already empty.
     * @since 0.0.1
     */
    public inline static function clear<T>(array:Array<T>):Array<T> {
        if (hasItems(array)) {
            #if flixel
            for (i in array) {
                if (Std.isOfType(i, FlxBasic)) {
                    var b = cast(i, FlxBasic);
                    b.destroy();
                }
            }
            #end
            array.resize(0);
            return array;
        }
        return [];
    }

    #if flixel
    /**
     * Removes and destroys `FlxBasic` items that are inactive or do not exist.
     *
     * If the list is already empty, returns a new empty `Array`.
     *
     * @return The list without inactive or nonexistent items, or a new empty `Array`
     * if the original list was already empty.
     * @since 0.0.1
     */
    public inline static function removeDead<T:FlxBasic>(array:Array<T>):Array<T> {
        if (hasItems(array)) {
            for (i in array) {
                if (!i.alive || !i.exists) {
                    array.remove(i);
                    i.destroy();
                }
            }
            return array;
        }
        return [];
    }
    #end

    /**
     * Returns the first item in an `Array` that matches a predicate.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<Int> = [1, 2, 3];
     * trace(myArray.find(function(item) return item > 1)); // Result: 2.
     * ```
     * ---
     *
     * @param predicate The function used to test each item.
     * @return The first matching item, or `null` if no item matches.
     * @since 0.0.2
     */
    public inline static function find<T>(array:Array<T>, predicate:T->Bool):Null<T> {
        if (hasItems(array)) {
            for (i in array) {
                if (predicate(i))
                    return i;
            }
        }
        return null;
    }

    /**
     * Returns up to a specified number of randomly selected items from an `Array`.
     *
     * The original `Array` is not modified.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<Int> = [1, 2, 3];
     * trace(myArray.sample(2)); // Result: two randomly selected items.
     * ```
     * ---
     *
     * @param n The maximum number of items to return.
     * @return A new `Array` containing the selected items, or an empty `Array`
     * if the source is empty or `n` is less than or equal to zero.
     * @since 0.0.2
     */
    public inline static function sample<T>(array:Array<T>, n:Int):Array<T> {
        if (hasItems(array)) {
            var copy = array.copy();
            var result = [];

            var count = (n > copy.length) ? copy.length : n;

            for (i in 0...count)
                result.push(copy.splice(Std.random(copy.length), 1)[0]);

            return result;
        }
        return [];
    }

    /**
     * Returns the value of a field from each item in an `Array`.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var users = [{name: 'Ada'}, {name: 'Linus'}];
     * trace(users.pluck('name')); // Result: ['Ada', 'Linus'].
     * ```
     * ---
     *
     * @param key The name of the field to retrieve from each item.
     * @return A new `Array` containing the field values, or an empty `Array`
     * if the source is empty.
     * @since 0.0.2
     */
    public inline static function pluck<T, V>(array:Array<T>, key:String):Array<V> {
        if (hasItems(array)) {
            return [
                for (i in array)
                (Reflect.field(i, key) : V)
            ];
        }
        return [];
    }

    /**
     * Returns a new `Array` containing only the unique items from an `Array`.
     *
     * The first occurrence of each item is kept, preserving the original order.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<Int> = [1, 2, 1, 3];
     * trace(myArray.unique()); // Result: [1, 2, 3].
     * ```
     * ---
     *
     * @return A new `Array` without duplicate items, or an empty `Array`
     * if the source is empty.
     * @since 0.0.2
     */
    public inline static function unique<T>(array:Array<T>):Array<T> {
        if (hasItems(array)) {
            var seen = new Map<Dynamic, Bool>();
            var result = [];

            for (i in array) {
                if (!seen.exists(i)) {
                    seen.set(i, true);
                    result.push(i);
                }
            }

            return result;
        }
        return [];
    }

    /**
     * Combines the items of nested `Array`s into a single `Array`.
     *
     * This flattens one level of nesting and does not modify the source `Array`.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<Array<Int>> = [[1, 2], [3]];
     * trace(myArray.flatten()); // Result: [1, 2, 3].
     * ```
     * ---
     *
     * @return A new `Array` containing the items from each nested `Array`,
     * or an empty `Array` if the source contains no items.
     * @since 0.0.2
     */
    public inline static function flatten<T>(array:Array<Array<T>>):Array<T> {
        if (hasItems(array)) {
            var result = [];

            for (s in array) {
                if (hasItems(s)) {
                    for (i in s)
                        result.push(i);
                }
            }

            return result;
        }
        return [];
    }

    /**
     * Removes the specified values from an `Array`.
     *
     * The source `Array` is modified; only the first matching occurrence of
     * each value is removed.
     *
     * ---
     * **Usage example:**
     * ```haxe
     * var myArray:Array<Int> = [1, 2, 3, 2];
     * myArray.without([2, 3]);
     * trace(myArray); // Result: [1, 2].
     * ```
     * ---
     *
     * @param values The values to remove from the `Array`.
     * @return The modified `Array`, or a new empty `Array` if the source is empty.
     * @since 0.0.2
     */
    public inline static function without<T>(array:Array<T>, values:Array<T>):Array<T> {
        if (hasItems(array)) {
            for (i in values)
                array.remove(i);

            return array;
        }
        return [];
    }
}