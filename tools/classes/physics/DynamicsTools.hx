package tools.classes.physics;

/**
 * Utility methods for basic force and momentum calculations.
 */
@:nullSafety
final class DynamicsTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Calculates force from mass and acceleration.
	 * @param mass The object's mass.
	 * @param acceleration The object's acceleration.
	 * @return The applied force.
	 */
	public static inline function force(mass:Float, acceleration:Float):Float
	{
		return mass * acceleration;
	}
	
	/**
	 * Calculates acceleration from force and mass.
	 * @param force The applied force.
	 * @param mass The object's mass, which must not be zero.
	 * @return The resulting acceleration.
	 */
	public static inline function acceleration(force:Float, mass:Float):Float
	{
		if (mass == 0) throw 'Mass must not be zero.';
		return force / mass;
	}
	
	/**
	 * Calculates linear momentum.
	 * @param mass The object's mass.
	 * @param velocity The object's velocity.
	 * @return The object's linear momentum.
	 */
	public static inline function momentum(mass:Float, velocity:Float):Float
	{
		return mass * velocity;
	}
	
	/**
	 * Calculates impulse from a constant force over a time interval.
	 * @param force The applied force.
	 * @param time The duration of the force.
	 * @return The resulting impulse.
	 */
	public static inline function impulse(force:Float, time:Float):Float
	{
		return force * time;
	}
}
