package tools.classes.extensions.backend;

#if flixel
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

import haxe.ds.ObjectMap;

/**
 * Sprite type used by the Flixel backend.
 */
typedef NativeSprite = flixel.FlxSprite;
#elseif openfl
import openfl.display.Sprite;
import openfl.geom.ColorTransform;

import haxe.ds.ObjectMap;

import tools.classes.extensions.special.ColorTools;

/**
 * Sprite type used by the OpenFL backend.
 */
typedef NativeSprite = openfl.display.Sprite;
#elseif heaps
import h2d.Drawable;
import h2d.Object;

import haxe.ds.ObjectMap;

import tools.classes.extensions.special.ColorTools;

/**
 * Sprite type used by the Heaps backend.
 */
typedef NativeSprite = h2d.Object;
#elseif ceramic
import ceramic.Visual;
import ceramic.Quad;
import ceramic.Easing;
import ceramic.Tween;

import haxe.ds.ObjectMap;

import tools.classes.extensions.special.ColorTools;

/**
 * Sprite type used by the Ceramic backend.
 */
typedef NativeSprite = ceramic.Visual;
#elseif kha
import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;

import tools.classes.extensions.special.ColorTools;
#end

#if (flixel || openfl || heaps || ceramic)
/**
 * Common sprite operations implemented for the active display framework.
 */
@:nullSafety
final class SpriteTools
{
	@:noCompletion
	private function new() {}
	
	#if flixel
	/**
	 * Active color flash tweens, keyed by their target sprites.
	 */
	private static var activeColorTweens = new ObjectMap<NativeSprite, FlxTween>();
	/**
	 * Sprite colors saved before their active color flashes.
	 */
	private static var originalColors = new ObjectMap<NativeSprite, Int>();
	#elseif openfl
	/**
	 * Original color transforms saved before sprites are flashed.
	 */
	private static var flashOrigins = new ObjectMap<NativeSprite, ColorTransform>();
	#elseif heaps
	/**
	 * Original color multipliers saved before drawables are flashed.
	 */
	private static var flashOrigins = new ObjectMap<Drawable, h3d.Vector4>();
	#elseif ceramic
	/**
	 * Active color flash tweens, keyed by their target quads.
	 */
	private static var activeColorTweens = new ObjectMap<Quad, Tween>();
	/**
	 * Quad colors saved before their active color flashes.
	 */
	private static var originalColors = new ObjectMap<Quad, Int>();
	#end
	
	/**
	 * Shows or hides a sprite according to a 50% duty-cycle blink.
	 * A non-positive frequency leaves the sprite visible.
	 * @param sprite The sprite to update.
	 * @param elapsedTime The elapsed time in seconds.
	 * @param frequency The number of blink cycles per second.
	 */
	public static inline function blink(sprite:NativeSprite, elapsedTime:Float, frequency:Float)
	{
		sprite.visible = isBlinkVisible(elapsedTime, frequency);
	}
	
	/**
	 * Sets a sprite's visibility.
	 * @param sprite The sprite to update.
	 * @param visible Whether the sprite should be rendered.
	 */
	public static inline function setVisible(sprite:NativeSprite, visible:Bool)
	{
		sprite.visible = visible;
	}
	
	/**
	 * Sets a sprite's opacity, clamped to 0-1.
	 * @param sprite The sprite to update.
	 * @param alpha The opacity.
	 */
	public static inline function setAlpha(sprite:NativeSprite, alpha:Float)
	{
		sprite.alpha = clampUnit(alpha);
	}
	
	#if flixel
	/**
	 * Tweens a Flixel sprite to a flash color and back over the given duration.
	 * A non-positive duration leaves the sprite unchanged.
	 * @param sprite The sprite to flash.
	 * @param color The target flash color.
	 * @param duration The total duration of the flash in seconds.
	 */
	public static function flashColor(sprite:NativeSprite, color:Int, duration:Float)
	{
		var activeTween = activeColorTweens.get(sprite);
		var originalColor = originalColors.get(sprite);
		if (activeTween != null)
		{
			activeTween.cancel();
			if (originalColor != null) sprite.color = originalColor;
		}
		
		if (duration <= 0)
		{
			originalColors.remove(sprite);
			activeColorTweens.remove(sprite);
			return;
		}
		
		var startColor:Int = originalColor != null ? originalColor : sprite.color;
		originalColors.set(sprite, startColor);
		var halfDuration = duration / 2;
		var flashTween = FlxTween.color(sprite, halfDuration, startColor, color,
			{
				onComplete: function(_) {
					var returnTween = FlxTween.color(sprite, halfDuration, color, startColor,
						{
							onComplete: function(_) {
								activeColorTweens.remove(sprite);
								originalColors.remove(sprite);
							}
						});
					activeColorTweens.set(sprite, returnTween);
				}
			});
		activeColorTweens.set(sprite, flashTween);
	}
	
	#elseif openfl
	/**
	 * Updates an OpenFL sprite's color flash for the current frame.
	 * `elapsedTime` is the time since the flash began.
	 * @param sprite The sprite to update.
	 * @param color The target flash color.
	 * @param elapsedTime The time elapsed since the flash began, in seconds.
	 * @param duration The total duration of the flash in seconds.
	 */
	public static function flashColor(sprite:NativeSprite, color:Int, elapsedTime:Float, duration:Float)
	{
		var original = flashOrigins.get(sprite);
		if (original == null || elapsedTime <= 0)
		{
			if (original != null) sprite.transform.colorTransform = copyColorTransform(original);
			original = copyColorTransform(sprite.transform.colorTransform);
			flashOrigins.set(sprite, original);
		}
		
		if (duration <= 0 || elapsedTime >= duration)
		{
			sprite.transform.colorTransform = copyColorTransform(original);
			flashOrigins.remove(sprite);
			return;
		}
		
		var target = new ColorTransform();
		target.color = color;
		target.alphaMultiplier = original.alphaMultiplier;
		target.alphaOffset = original.alphaOffset;
		var ratio = flashProgress(elapsedTime, duration);
		var transform = new ColorTransform();
		transform.redMultiplier = lerp(original.redMultiplier, target.redMultiplier, ratio);
		transform.redOffset = lerp(original.redOffset, target.redOffset, ratio);
		transform.greenMultiplier = lerp(original.greenMultiplier, target.greenMultiplier, ratio);
		transform.greenOffset = lerp(original.greenOffset, target.greenOffset, ratio);
		transform.blueMultiplier = lerp(original.blueMultiplier, target.blueMultiplier, ratio);
		transform.blueOffset = lerp(original.blueOffset, target.blueOffset, ratio);
		transform.alphaMultiplier = original.alphaMultiplier;
		transform.alphaOffset = original.alphaOffset;
		sprite.transform.colorTransform = transform;
	}
	
	#elseif heaps
	/**
	 * Updates a Heaps drawable's color flash for the current frame.
	 * `elapsedTime` is the time since the flash began.
	 * @param sprite The drawable to update.
	 * @param color The target RGB color.
	 * @param elapsedTime The time elapsed since the flash began, in seconds.
	 * @param duration The total duration of the flash in seconds.
	 */
	public static function flashColor(sprite:Drawable, color:Int, elapsedTime:Float, duration:Float)
	{
		var original = flashOrigins.get(sprite);
		if (original == null || elapsedTime <= 0)
		{
			if (original != null) sprite.color = copyVector4(original);
			original = copyVector4(sprite.color);
			flashOrigins.set(sprite, original);
		}
		
		if (duration <= 0 || elapsedTime >= duration)
		{
			sprite.color = copyVector4(original);
			flashOrigins.remove(sprite);
			return;
		}
		
		var ratio = flashProgress(elapsedTime, duration);
		sprite.color = new h3d.Vector4(lerp(original.r, ((color >> 16) & 0xFF) / 255, ratio),
			lerp(original.g, ((color >> 8) & 0xFF) / 255, ratio), lerp(original.b, (color & 0xFF) / 255, ratio), original.a);
	}
	
	#elseif ceramic
	/**
	 * Tweens a Ceramic quad to a flash color and back over the given duration.
	 * A non-positive duration leaves the quad unchanged.
	 * @param sprite The quad to flash.
	 * @param color The target flash color.
	 * @param duration The total duration of the flash in seconds.
	 */
	public static function flashColor(sprite:Quad, color:Int, duration:Float)
	{
		var activeTween = activeColorTweens.get(sprite);
		var originalColor = originalColors.get(sprite);
		if (activeTween != null)
		{
			activeTween.destroy();
			if (originalColor != null) sprite.color = originalColor;
		}
		
		if (duration <= 0)
		{
			originalColors.remove(sprite);
			activeColorTweens.remove(sprite);
			return;
		}
		
		var startColor:Int = originalColor != null ? originalColor : sprite.color;
		originalColors.set(sprite, startColor);
		var halfDuration = duration / 2;
		var flashTween = Tween.start(sprite, Easing.LINEAR, halfDuration, 0, 1, function(value:Float, _) {
			sprite.color = ColorTools.lerpColor(startColor, color, value);
		});
		activeColorTweens.set(sprite, flashTween);
		flashTween.onceComplete(sprite, function() {
			if (activeColorTweens.get(sprite) != flashTween) return;
			
			var returnTween = Tween.start(sprite, Easing.LINEAR, halfDuration, 0, 1, function(value:Float, _) {
				sprite.color = ColorTools.lerpColor(color, startColor, value);
			});
			activeColorTweens.set(sprite, returnTween);
			returnTween.onceComplete(sprite, function() {
				sprite.color = startColor;
				activeColorTweens.remove(sprite);
				originalColors.remove(sprite);
			});
		});
	}
	#end
	
	/**
	 * Sets a sprite's position.
	 * @param sprite The sprite to update.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 */
	public static inline function setPosition(sprite:NativeSprite, x:Float, y:Float)
	{
		sprite.x = x;
		sprite.y = y;
	}
	
	/**
	 * Moves a sprite by an offset.
	 * @param sprite The sprite to update.
	 * @param x The horizontal offset.
	 * @param y The vertical offset.
	 */
	public static inline function moveBy(sprite:NativeSprite, x:Float, y:Float)
	{
		sprite.x += x;
		sprite.y += y;
	}
	
	/**
	 * Sets a sprite's horizontal and vertical scale.
	 * @param sprite The sprite to update.
	 * @param x The horizontal scale.
	 * @param y The vertical scale.
	 */
	public static inline function setScale(sprite:NativeSprite, x:Float, y:Float)
	{
		#if flixel
		sprite.scale.set(x, y);
		sprite.updateHitbox();
		#else
		sprite.scaleX = x;
		sprite.scaleY = y;
		#end
	}
	
	/**
	 * Sets a sprite's rotation in degrees.
	 * @param sprite The sprite to update.
	 * @param degrees The clockwise rotation.
	 */
	public static inline function setRotation(sprite:NativeSprite, degrees:Float)
	{
		#if flixel
		sprite.angle = degrees;
		#elseif heaps
		sprite.rotation = degrees * Math.PI / 180;
		#else
		sprite.rotation = degrees;
		#end
	}
	
	/**
	 * Sets whether a sprite is horizontally flipped.
	 * @param sprite The sprite to update.
	 * @param flipped Whether to flip the sprite.
	 */
	public static inline function setFlipX(sprite:NativeSprite, flipped:Bool)
	{
		#if flixel
		sprite.flipX = flipped;
		#else
		sprite.scaleX = Math.abs(sprite.scaleX) * (flipped ? -1 : 1);
		#end
	}
	
	/**
	 * Sets whether a sprite is vertically flipped.
	 * @param sprite The sprite to update.
	 * @param flipped Whether to flip the sprite.
	 */
	public static inline function setFlipY(sprite:NativeSprite, flipped:Bool)
	{
		#if flixel
		sprite.flipY = flipped;
		#else
		sprite.scaleY = Math.abs(sprite.scaleY) * (flipped ? -1 : 1);
		#end
	}
	
	private static inline function isBlinkVisible(elapsedTime:Float, frequency:Float):Bool
	{
		return frequency <= 0 || Math.floor(elapsedTime * frequency * 2) % 2 == 0;
	}
	
	private static inline function clampUnit(value:Float):Float
	{
		return value < 0 ? 0 : (value > 1 ? 1 : value);
	}
	
	private static inline function flashProgress(elapsedTime:Float, duration:Float):Float
	{
		if (duration <= 0 || elapsedTime >= duration) return 0;
		var progress = elapsedTime <= 0 ? 0 : elapsedTime / duration;
		return progress <= 0.5 ? progress * 2 : (1 - progress) * 2;
	}
	
	private static inline function lerp(from:Float, to:Float, ratio:Float):Float
	{
		return from + (to - from) * ratio;
	}
	
	#if (openfl && !flixel)
	private static function copyColorTransform(source:ColorTransform):ColorTransform
	{
		var result = new ColorTransform();
		result.redMultiplier = source.redMultiplier;
		result.redOffset = source.redOffset;
		result.greenMultiplier = source.greenMultiplier;
		result.greenOffset = source.greenOffset;
		result.blueMultiplier = source.blueMultiplier;
		result.blueOffset = source.blueOffset;
		result.alphaMultiplier = source.alphaMultiplier;
		result.alphaOffset = source.alphaOffset;
		return result;
	}
	#elseif heaps
	private static inline function copyVector4(source:h3d.Vector4):h3d.Vector4
	{
		return new h3d.Vector4(source.r, source.g, source.b, source.a);
	}
	#end
}

#elseif kha
/**
 * Drawing helpers for Kha images, which are rendered through a Graphics context rather than a sprite object.
 */
@:nullSafety
final class SpriteTools
{
	@:noCompletion
	private function new() {}
	
	/**
	 * Draws an image with a color flash that returns to the current graphics tint.
	 * Call each frame with elapsed time since the flash began.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal drawing position.
	 * @param y The vertical drawing position.
	 * @param color The target flash tint.
	 * @param elapsedTime The time elapsed since the flash began, in seconds.
	 * @param duration The total duration of the flash, in seconds.
	 */
	public static inline function drawFlashColor(graphics:Graphics, image:Image, x:Float, y:Float, color:Color,
			elapsedTime:Float, duration:Float)
	{
		var startColor = graphics.color;
		var ratio = flashProgress(elapsedTime, duration);
		var tint:Color = cast ColorTools.lerpColor(cast startColor, cast color, ratio);
		drawTinted(graphics, image, x, y, tint);
	}
	
	/**
	 * Draws an image at the supplied position.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 */
	public static inline function drawAt(graphics:Graphics, image:Image, x:Float, y:Float)
	{
		graphics.drawImage(image, x, y);
	}
	
	/**
	 * Draws an image centered at the supplied point.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal center coordinate.
	 * @param y The vertical center coordinate.
	 */
	public static inline function drawCentered(graphics:Graphics, image:Image, x:Float, y:Float)
	{
		graphics.drawImage(image, x - image.width / 2, y - image.height / 2);
	}
	
	/**
	 * Draws an image at an offset from a base position.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The base horizontal position.
	 * @param y The base vertical position.
	 * @param offsetX The horizontal offset.
	 * @param offsetY The vertical offset.
	 */
	public static inline function drawOffset(graphics:Graphics, image:Image, x:Float, y:Float, offsetX:Float, offsetY:Float)
	{
		graphics.drawImage(image, x + offsetX, y + offsetY);
	}
	
	/**
	 * Draws an image with temporary opacity, clamped to 0-1.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param alpha The opacity multiplier.
	 */
	public static function drawWithAlpha(graphics:Graphics, image:Image, x:Float, y:Float, alpha:Float)
	{
		graphics.pushOpacity(graphics.opacity * clampUnit(alpha));
		try
		{
			graphics.drawImage(image, x, y);
		}
		catch (error)
		{
			graphics.popOpacity();
			throw error;
		}
		graphics.popOpacity();
	}
	
	/**
	 * Draws an image scaled by horizontal and vertical factors.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param scaleX The horizontal scale factor.
	 * @param scaleY The vertical scale factor.
	 */
	public static inline function drawScaled(graphics:Graphics, image:Image, x:Float, y:Float, scaleX:Float, scaleY:Float)
	{
		graphics.drawScaledImage(image, x, y, image.width * scaleX, image.height * scaleY);
	}
	
	/**
	 * Draws an image rotated around its center. The angle is in radians.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param radians The counterclockwise rotation angle in radians.
	 */
	public static function drawRotated(graphics:Graphics, image:Image, x:Float, y:Float, radians:Float)
	{
		graphics.pushRotation(radians, x + image.width / 2, y + image.height / 2);
		try
		{
			graphics.drawImage(image, x, y);
		}
		catch (error:Dynamic)
		{
			graphics.popTransformation();
			throw error;
		}
		graphics.popTransformation();
	}
	
	/**
	 * Draws an image mirrored horizontally and/or vertically.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param horizontal Whether to flip horizontally.
	 * @param vertical Whether to flip vertically.
	 */
	public static function drawFlipped(graphics:Graphics, image:Image, x:Float, y:Float, horizontal:Bool, vertical:Bool)
	{
		var centerX = x + image.width / 2;
		var centerY = y + image.height / 2;
		graphics.pushTranslation(-centerX, -centerY);
		graphics.pushScale(horizontal ? -1 : 1, vertical ? -1 : 1);
		graphics.pushTranslation(centerX, centerY);
		try
		{
			graphics.drawImage(image, x, y);
		}
		catch (error:Dynamic)
		{
			graphics.popTransformation();
			graphics.popTransformation();
			graphics.popTransformation();
			throw error;
		}
		graphics.popTransformation();
		graphics.popTransformation();
		graphics.popTransformation();
	}
	
	/**
	 * Draws an image with a temporary tint, restoring the previous graphics color afterward.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param tint The temporary tint color.
	 */
	public static function drawTinted(graphics:Graphics, image:Image, x:Float, y:Float, tint:Color)
	{
		var previousColor = graphics.color;
		graphics.color = tint;
		try
		{
			graphics.drawImage(image, x, y);
		}
		catch (error:Dynamic)
		{
			graphics.color = previousColor;
			throw error;
		}
		graphics.color = previousColor;
	}
	
	/**
	 * Draws an image only during the visible half of a blink cycle.
	 * A non-positive frequency draws the image continuously.
	 * @param graphics The graphics context used for drawing.
	 * @param image The image to draw.
	 * @param x The horizontal position.
	 * @param y The vertical position.
	 * @param elapsedTime The elapsed time in seconds.
	 * @param frequency The blink frequency in cycles per second.
	 */
	public static inline function blink(graphics:Graphics, image:Image, x:Float, y:Float, elapsedTime:Float, frequency:Float)
	{
		if (frequency <= 0 || Math.floor(elapsedTime * frequency * 2) % 2 == 0) graphics.drawImage(image, x, y);
	}
	
	static inline function clampUnit(value:Float):Float
	{
		return value < 0 ? 0 : (value > 1 ? 1 : value);
	}
}
#end
