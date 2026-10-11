package tools;

import haxe.Exception;

/**
 * Utility class for `Enum`.
 * **Author:** dre
 */
final class EnumTools {
    /**
     * Private constructor prevents `new EnumTools()`.
     */
    @:noCompletion
    private function new():Void {}

    public static function getNames<T>(e:Enum<T>):Array<String> {
        if (e == null) return [];
        return Type.getEnumConstructs(e);
    }

    public static function fromString<T>(e:Enum<T>, name:String, ?defaultValue:T):Null<T> {
        if (e == null || name == null) return defaultValue;

        try {
            if (Type.getEnumConstructs(e).indexOf(name) != -1)
                return Type.createEnum(e, name);
        } catch (e:Exception) {}

        return defaultValue;
    }

    public static function fromIndex<T>(e:Enum<T>, index:Int, ?defaultValue:T):Null<T> {
        if (e == null || (index < 0 || index == null)) return defaultValue;

        var constructs = Type.getEnumConstructs(e);
        if (index < constructs.length)
            return Type.createEnum(e, constructs[index]);

        return defaultValue;
    }

    public static function toIndex(enumValue:EnumValue):Int {
        if (enumValue == null) return -1;
        return Type.enumIndex(enumValue);
    }

    public static function toString(enumValue:EnumValue):String {
        if (enumValue == null) return '';
        return Type.enumConstructor(enumValue);
    }

    public static function getAllValues<T>(e:Enum<T>):Array<T> {
        if (e == null) return [];

        var result = [];
        for (c in Type.getEnumConstructs(e)) {
            try {
                result.push(Type.createEnum(e, c));
            } catch (e:Exception) {}
        }
        return result;
    }
}