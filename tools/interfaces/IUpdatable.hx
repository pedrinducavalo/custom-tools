package tools.interfaces;

/**
 * Implemented by objects that advance over elapsed time.
 */
interface IUpdatable
{
	/**
	 * Advances the object by an elapsed time in seconds.
	 * @param deltaTime The elapsed time.
	 */
	public function update(deltaTime:Float):Void;
}
