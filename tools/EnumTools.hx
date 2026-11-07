package tools;

@:nullSafety

/**
 * Reflection helpers for enum types and values.
 */
final class EnumTools

{
	/**
	 * Creates an `EnumTools` instance. This constructor is not intended for public use.
	 */
	@:noCompletion
	function new():Void {}
	
	/**
	 * Returns the constructor names of an enum.
	 * @param e The enum type to inspect.
	 * @return The constructor names, or an empty array when `e` is `null`.
	 */
	public static function getNames<T>(e:Enum<T>):Array<String>
	{
		if (e == null) return [];
		return Type.getEnumConstructs(e);
	}
	
	/**
	 * Creates an enum value from its constructor name.
	 * @param e The enum type.
	 * @param name The constructor name.
	 * @param defaultValue The value to return if the enum or constructor name is invalid.
	 * @return The created enum value, or `defaultValue` if it cannot be created.
	 */
	public static function fromString<T>(e:Enum<T>, name:String, ?defaultValue:T):Null<T>
	{
		if (e == null || name == null) return defaultValue;
		
		try
		{
			if (Type.getEnumConstructs(e).indexOf(name) != -1) return Type.createEnum(e, name);
		}
		
		return defaultValue;
	}
	
	/**
	 * Creates an enum value from its constructor index.
	 * @param e The enum type.
	 * @param index The zero-based constructor index.
	 * @param defaultValue The value to return if the enum or index is invalid.
	 * @return The created enum value, or `defaultValue` if it cannot be created.
	 */
	public static function fromIndex<T>(e:Enum<T>, index:Int, ?defaultValue:T):Null<T>
	{
		if (index < 0) return defaultValue;
		
		var constructs = Type.getEnumConstructs(e);
		if (index < constructs.length) return Type.createEnum(e, constructs[index]);
		
		return defaultValue;
	}
	
	/**
	 * Returns the constructor index of an enum value.
	 * @param enumValue The enum value to inspect.
	 * @return The zero-based constructor index, or `-1` if the value is `null`.
	 */
	public static function toIndex(enumValue:EnumValue):Int
	{
		if (enumValue == null) return -1;
		return Type.enumIndex(enumValue);
	}
	
	/**
	 * Returns the constructor name of an enum value.
	 * @param enumValue The enum value to inspect.
	 * @return The constructor name, or an empty string if the value is `null`.
	 */
	public static function toString(enumValue:EnumValue):String
	{
		if (enumValue == null) return '';
		return Type.enumConstructor(enumValue);
	}
	
	/**
	 * Creates every enum constructor that can be instantiated without arguments.
	 * @param e The enum type to inspect.
	 * @return The created values; constructors requiring arguments are skipped.
	 */
	public static function getAllValues<T>(e:Enum<T>):Array<T>
	{
		if (e == null) return [];
		
		var result = [];
		for (c in Type.getEnumConstructs(e))
		{
			try
			{
				result.push(Type.createEnum(e, c));
			}
		}
		return result;
	}
}
