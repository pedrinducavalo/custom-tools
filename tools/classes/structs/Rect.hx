package tools.classes.structs;

/**
 * An axis-aligned rectangle described by its top-left corner and dimensions.
 */
@:nullSafety
final class Rect
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	
	/**
	 * Creates a rectangle from its top-left corner and dimensions.
	 * @param x The horizontal coordinate of the top-left corner.
	 * @param y The vertical coordinate of the top-left corner.
	 * @param width The rectangle width.
	 * @param height The rectangle height.
	 */
	public inline function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	/**
	 * Checks whether a point is inside or on the boundary of this rectangle.
	 * @param point The point to check.
	 * @return `true` when the point lies within the rectangle.
	 */
	public inline function containsPoint(point:Vector2):Bool
	{
		return point.x >= x && point.x <= x + width && point.y >= y && point.y <= y + height;
	}
	
	/**
	 * Checks whether this rectangle overlaps or touches another rectangle.
	 * @param other The rectangle to compare with.
	 * @return `true` when the rectangles overlap or share an edge.
	 */
	public inline function intersects(other:Rect):Bool
	{
		return x <= other.x + other.width
			&& x + width >= other.x
			&& y <= other.y + other.height
			&& y + height >= other.y;
	}
	
	/**
	 * Returns the center point of this rectangle.
	 * @return The center coordinates as a vector.
	 */
	public inline function center():Vector2
	{
		return new Vector2(x + width / 2, y + height / 2);
	}
}
