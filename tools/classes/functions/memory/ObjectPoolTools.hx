package tools.classes.functions.memory;

/**
 * Operations for reusing objects stored in an array-backed pool.
 */
@:nullSafety
final class ObjectPoolTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Creates an empty object pool.
	 * @return A new empty pool.
	 */
	public static inline function create<T>():Array<T>
	{
		return [];
	}
	
	/**
	 * Retrieves a pooled object or creates one when the pool is empty.
	 * @param pool The pool to retrieve from.
	 * @param factory Creates an object when none is available.
	 * @return A pooled or newly created object.
	 */
	public static function acquire<T>(pool:Array<T>, factory:Void->T):T
	{
		if (pool.length == 0) return factory();
		
		var item = pool.pop();
		if (item == null) throw 'Pool must not contain null items.';
		return item;
	}
	
	/**
	 * Returns an object to the pool unless its optional capacity is reached.
	 * @param pool The pool to add to.
	 * @param item The object to store for reuse.
	 * @param maxSize The maximum number of pooled objects, or `-1` for no limit.
	 * @return `true` if the object was stored.
	 */
	public static function release<T>(pool:Array<T>, item:T, maxSize:Int = -1):Bool
	{
		if (maxSize < -1) throw 'Maximum pool size must be -1 or greater.';
		if (maxSize >= 0 && pool.length >= maxSize) return false;
		
		pool.push(item);
		return true;
	}
	
	/**
	 * Returns multiple objects to the pool without modifying the source array.
	 * @param pool The pool to add to.
	 * @param items The objects to store for reuse.
	 * @param maxSize The maximum number of pooled objects, or `-1` for no limit.
	 * @return The number of objects stored.
	 */
	public static function releaseMany<T>(pool:Array<T>, items:Array<T>, maxSize:Int = -1):Int
	{
		if (maxSize < -1) throw 'Maximum pool size must be -1 or greater.';
		
		var released = 0;
		for (item in items)
		{
			if (!release(pool, item, maxSize)) break;
			released++;
		}
		
		return released;
	}
	
	/**
	 * Removes excess objects from the end of a pool.
	 * @param pool The pool to trim.
	 * @param maxSize The maximum number of objects to retain.
	 * @return The number of objects removed.
	 */
	public static function trim<T>(pool:Array<T>, maxSize:Int):Int
	{
		if (maxSize < 0) throw 'Maximum pool size must not be negative.';
		
		var removed = 0;
		while (pool.length > maxSize)
		{
			pool.pop();
			removed++;
		}
		
		return removed;
	}
	
	/**
	 * Removes all objects from a pool.
	 * @param pool The pool to empty.
	 */
	public static function clear<T>(pool:Array<T>):Void
	{
		while (pool.length > 0)
		{
			pool.pop();
		}
	}
	
	/**
	 * Gets the number of reusable objects currently in a pool.
	 * @param pool The pool to inspect.
	 * @return The number of stored objects.
	 */
	public static inline function size<T>(pool:Array<T>):Int
	{
		return pool.length;
	}
	
	/**
	 * Checks whether a pool contains any reusable objects.
	 * @param pool The pool to inspect.
	 * @return `true` when the pool is not empty.
	 */
	public static inline function hasItems<T>(pool:Array<T>):Bool
	{
		return pool.length > 0;
	}
}
