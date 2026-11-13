package tools.abstracts;

/**
 * A callable easing function that maps progress to eased progress.
 */
@:nullSafety
abstract Easing(Float->Float) from Float->Float to Float->Float
{
	/**
	 * Applies this easing function to a progress value.
	 * @param progress The input progress value.
	 * @return The eased progress value.
	 */
	@:op(a())
	public inline function apply(progress:Float):Float
	{
		return this(progress);
	}
}
