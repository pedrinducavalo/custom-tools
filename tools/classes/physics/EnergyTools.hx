package tools.classes.physics;

/**
 * Utility methods for basic work, energy, and power calculations.
 */
@:nullSafety
final class EnergyTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Calculates kinetic energy.
	 * @param mass The object's mass.
	 * @param velocity The object's velocity.
	 * @return The object's kinetic energy.
	 */
	public static inline function kineticEnergy(mass:Float, velocity:Float):Float
	{
		return mass * velocity * velocity / 2;
	}
	
	/**
	 * Calculates gravitational potential energy relative to a reference height.
	 * @param mass The object's mass.
	 * @param gravity The gravitational acceleration.
	 * @param height The object's height relative to the reference.
	 * @return The object's gravitational potential energy.
	 */
	public static inline function potentialEnergy(mass:Float, gravity:Float, height:Float):Float
	{
		return mass * gravity * height;
	}
	
	/**
	 * Calculates work performed by a constant force over a displacement.
	 * @param force The force magnitude.
	 * @param displacement The displacement magnitude.
	 * @param angleRadians The angle between the force and displacement, in radians.
	 * @return The work performed.
	 */
	public static inline function work(force:Float, displacement:Float, angleRadians:Float = 0):Float
	{
		return force * displacement * Math.cos(angleRadians);
	}
	
	/**
	 * Calculates average power from work and elapsed time.
	 * @param work The work performed.
	 * @param time The elapsed time, which must be greater than zero.
	 * @return The average power.
	 */
	public static inline function power(work:Float, time:Float):Float
	{
		if (time <= 0) throw 'Time must be greater than zero.';
		return work / time;
	}
}
