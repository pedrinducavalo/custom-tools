package tools.classes;

/**
 * Namespace holder for extension helper classes.
 */
final class Extensions
{
	@:noCompletion
	private function new() {}
}

/**
 * Alias for boolean extensions.
 */
typedef BoolTools = tools.classes.extensions.basic.BoolTools;

/**
 * Alias for floating-point extensions.
 */
typedef FloatTools = tools.classes.extensions.basic.FloatTools;

/**
 * Alias for integer extensions.
 */
typedef IntTools = tools.classes.extensions.basic.IntTools;

/**
 * Alias for array extensions.
 */
typedef ArrayTools = tools.classes.extensions.iterables.ArrayTools;

/**
 * Alias for map extensions.
 */
typedef MapTools = tools.classes.extensions.iterables.MapTools;

/**
 * Alias for color extensions.
 */
typedef ColorTools = tools.classes.extensions.special.ColorTools;

/**
 * Alias for enum helpers.
 */
typedef EnumTools = tools.classes.extensions.special.EnumTools;

/**
 * Alias for string extensions.
 */
typedef StringTools = tools.classes.extensions.special.StringTools;

#if (flixel || openfl || heaps || ceramic || kha)
/**
 * Alias for framework-specific sprite helpers.
 */
typedef SpriteTools = tools.classes.extensions.backend.SpriteTools;
#end

#if (flixel || openfl || heaps || ceramic)
/**
 * Alias for the native display object type accepted by sprite helpers.
 */
typedef NativeSprite = tools.classes.extensions.backend.SpriteTools.NativeSprite;
#end
