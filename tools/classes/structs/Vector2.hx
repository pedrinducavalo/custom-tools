package tools.classes.structs;

/**
 * A simple two-dimensional vector.
 */
@:nullSafety
final class Vector2
{
	public var x:Float;
	public var y:Float;
	
	/**
	 * Creates a vector with the supplied coordinates.
	 * @param x The horizontal component.
	 * @param y The vertical component.
	 */
	public inline function new(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
	}
	
	/**
	 * Returns a copy of this vector.
	 * @return A new vector with the same components.
	 */
	public inline function copy():Vector2
	{
		return new Vector2(x, y);
	}
	
	/**
	 * Returns the sum of this vector and another vector.
	 * @param other The vector to add.
	 * @return A new vector containing the sum.
	 */
	public inline function add(other:Vector2):Vector2
	{
		return new Vector2(x + other.x, y + other.y);
	}
	
	/**
	 * Returns the difference between this vector and another vector.
	 * @param other The vector to subtract.
	 * @return A new vector containing the difference.
	 */
	public inline function subtract(other:Vector2):Vector2
	{
		return new Vector2(x - other.x, y - other.y);
	}
	
	/**
	 * Returns this vector multiplied by a scalar.
	 * @param factor The scalar multiplier.
	 * @return A new scaled vector.
	 */
	public inline function scale(factor:Float):Vector2
	{
		return new Vector2(x * factor, y * factor);
	}
	
	/**
	 * Calculates the dot product with another vector.
	 * @param other The vector to compare with.
	 * @return The dot product.
	 */
	public inline function dot(other:Vector2):Float
	{
		return x * other.x + y * other.y;
	}
	
	/**
	 * Calculates the squared length without taking a square root.
	 * @return The squared length.
	 */
	public inline function lengthSq():Float
	{
		return x * x + y * y;
	}
	
	/**
	 * Calculates the length of this vector.
	 * @return The vector length.
	 */
	public inline function length():Float
	{
		return Math.sqrt(lengthSq());
	}
	
	/**
	 * Returns a unit-length vector in the same direction, or zero when this vector has no direction.
	 * @return A normalized copy, or a zero vector when this vector has zero length.
	 */
	public inline function normalized():Vector2
	{
		var magnitude = length();
		return magnitude == 0 ? new Vector2() : scale(1 / magnitude);
	}
	
	/**
	 * Returns this vector rotated counterclockwise by an angle in radians.
	 * @param radians The counterclockwise rotation angle.
	 * @return A new rotated vector.
	 */
	public inline function rotated(radians:Float):Vector2
	{
		var cos = Math.cos(radians);
		var sin = Math.sin(radians);
		return new Vector2(x * cos - y * sin, x * sin + y * cos);
	}
	
	/**
	 * Calculates the distance from this vector to another vector.
	 * @param other The vector to measure to.
	 * @return The distance between the vectors.
	 */
	public inline function distanceTo(other:Vector2):Float
	{
		return other.subtract(this).length();
	}
}
