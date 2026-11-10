package tools.math;

/**
 * Utility methods for measuring distances, angles, and simple geometric overlap.
 */
@:nullSafety
final class GeomTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Calculates the Euclidean distance between two points.
	 * @param x1 The x-coordinate of the first point.
	 * @param y1 The y-coordinate of the first point.
	 * @param x2 The x-coordinate of the second point.
	 * @param y2 The y-coordinate of the second point.
	 * @return The distance between the points.
	 */
	public static inline function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		return Math.sqrt((dx * dx) + (dy * dy));
	}
	
	/**
	 * Calculates the squared Euclidean distance between two points without taking a square root.
	 * @param x1 The x-coordinate of the first point.
	 * @param y1 The y-coordinate of the first point.
	 * @param x2 The x-coordinate of the second point.
	 * @param y2 The y-coordinate of the second point.
	 * @return The squared distance between the points.
	 */
	public static inline function distanceSq(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		return (dx * dx) + (dy * dy);
	}
	
	/**
	 * Calculates the angle from the first point to the second point.
	 * @param x1 The x-coordinate of the starting point.
	 * @param y1 The y-coordinate of the starting point.
	 * @param x2 The x-coordinate of the target point.
	 * @param y2 The y-coordinate of the target point.
	 * @return The angle in radians, as returned by `Math.atan2`.
	 */
	public static inline function angleBetween(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return Math.atan2(y2 - y1, x2 - x1);
	}
	
	/**
	 * Checks whether a point lies inside or on the boundary of an axis-aligned rectangle.
	 * @param px The x-coordinate of the point.
	 * @param py The y-coordinate of the point.
	 * @param rx The x-coordinate of the rectangle's top-left corner.
	 * @param ry The y-coordinate of the rectangle's top-left corner.
	 * @param rw The rectangle's width.
	 * @param rh The rectangle's height.
	 * @return `true` if the point is within the rectangle, including its edges.
	 */
	public static inline function pointInRect(px:Float, py:Float, rx:Float, ry:Float, rw:Float, rh:Float):Bool
	{
		return px >= rx && px <= rx + rw && py >= ry && py <= ry + rh;
	}
	
	/**
	 * Checks whether two circles overlap or touch.
	 * @param x1 The x-coordinate of the first circle's center.
	 * @param y1 The y-coordinate of the first circle's center.
	 * @param r1 The radius of the first circle.
	 * @param x2 The x-coordinate of the second circle's center.
	 * @param y2 The y-coordinate of the second circle's center.
	 * @param r2 The radius of the second circle.
	 * @return `true` if the distance between the centers is no greater than the sum of the radii.
	 */
	public static inline function circleOverlap(x1:Float, y1:Float, r1:Float, x2:Float, y2:Float, r2:Float):Bool
	{
		var radiusSum = r1 + r2;
		return distanceSq(x1, y1, x2, y2) <= radiusSum * radiusSum;
	}
}
