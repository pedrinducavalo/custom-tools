package tools.interfaces;

/**
 * Implemented by objects that can restore their initial state.
 */
interface IResettable
{
	/**
	 * Restores the object to its initial or reusable state.
	 */
	public function reset():Void;
}
