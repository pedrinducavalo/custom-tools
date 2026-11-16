package tools.interfaces;

/**
 * Implemented by objects that expose an explicit cleanup operation.
 */
interface IDestroyable
{
	/**
	 * Releases resources held by the object.
	 */
	public function destroy():Void;
}
