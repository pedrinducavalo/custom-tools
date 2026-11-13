package tools.classes.structs;

/**
 * A simple two-dimensional size.
 */
@:nullSafety
final class Size2
{
	public var width:Float;
	public var height:Float;
	
	/**
	 * Creates a size with the supplied dimensions.
	 * @param width The horizontal dimension.
	 * @param height The vertical dimension.
	 */
	public inline function new(width:Float = 0, height:Float = 0)
	{
		this.width = width;
		this.height = height;
	}
	
	/**
	 * Calculates the area represented by this size.
	 * @return The product of the width and height.
	 */
	public inline function area():Float
	{
		return width * height;
	}
	
	/**
	 * Checks whether either dimension is zero or negative.
	 * @return `true` when either dimension is not positive.
	 */
	public inline function isEmpty():Bool
	{
		return width <= 0 || height <= 0;
	}
	
	/**
	 * Returns a copy of this size multiplied by a scalar.
	 * @param factor The scalar multiplier.
	 * @return A new scaled size.
	 */
	public inline function scale(factor:Float):Size2
	{
		return new Size2(width * factor, height * factor);
	}
	
	/**
	 * Checks whether this size fits within the supplied bounds.
	 * @param bounds The maximum allowed dimensions.
	 * @return `true` when both dimensions fit within `bounds`.
	 */
	public inline function fitsWithin(bounds:Size2):Bool
	{
		return width <= bounds.width && height <= bounds.height;
	}
}
