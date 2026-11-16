package tools;

/**
 * Namespace holder for public interfaces.
 */
final class Interfaces
{
	@:noCompletion
	private function new() {}
}

/**
 * Alias for the update lifecycle interface.
 */
typedef IUpdatable = tools.interfaces.IUpdatable;

/**
 * Alias for the position interface.
 */
typedef IPositionable = tools.interfaces.IPositionable;

/**
 * Alias for the cleanup lifecycle interface.
 */
typedef IDestroyable = tools.interfaces.IDestroyable;

/**
 * Alias for the reset lifecycle interface.
 */
typedef IResettable = tools.interfaces.IResettable;
