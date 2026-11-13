package tools.classes.physics;

/**
 * Utility methods for basic one-dimensional kinematics.
 */
@:nullSafety
final class KinematicsTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Calculates velocity after a period of constant acceleration.
	 * @param initialVelocity The velocity at the start of the interval.
	 * @param acceleration The constant acceleration during the interval.
	 * @param time The elapsed time.
	 * @return The velocity at the end of the interval.
	 */
	public static inline function velocityAfter(initialVelocity:Float, acceleration:Float, time:Float):Float
	{
		return initialVelocity + acceleration * time;
	}
	
	/**
	 * Calculates displacement during a period of constant acceleration.
	 * @param initialVelocity The velocity at the start of the interval.
	 * @param acceleration The constant acceleration during the interval.
	 * @param time The elapsed time.
	 * @return The displacement during the interval.
	 */
	public static inline function displacement(initialVelocity:Float, acceleration:Float, time:Float):Float
	{
		return initialVelocity * time + acceleration * time * time / 2;
	}
	
	/**
	 * Calculates average velocity from displacement and elapsed time.
	 * @param displacement The displacement during the interval.
	 * @param time The elapsed time, which must not be zero.
	 * @return The average velocity during the interval.
	 */
	public static inline function averageVelocity(displacement:Float, time:Float):Float
	{
		if (time == 0) throw 'Time must not be zero.';
		return displacement / time;
	}
}
