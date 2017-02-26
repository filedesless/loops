package;

import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.math.FlxMath;

/**
 * Looping gif.
 *
 * @author aiglebleu
 * @link https://hightechlowlife.eu
 */
class PlayState extends FlxState
{
	private static inline var DURATION:Float = 1;
	
	private var _first:FlxSprite;
	private var _second:FlxSprite;

	private var i:Float = 0;
	private var _goingUp:Bool = true;
	private var s:Float = 0;
	private var c:Float = 0;
	
	override public function create():Void
	{
		FlxG.autoPause = false;
		
		var title = new FlxText(0, 0, FlxG.width, "High Tech Low Life", 42);
		title.alignment = CENTER;
		title.screenCenter();
		title.alpha = 0.15;
		add(title);
		
		// Create the sprite to tween (flixel logo)
		_first = new FlxSprite();
		_first.loadGraphic(FlxGraphic.fromClass(GraphicLogo), true);
		_first.antialiasing = true;
		_first.pixelPerfectRender = false;
		_first.color = FlxColor.WHITE;
		_first.alpha = 0.8; // Lowered alpha looks neat
		_first.screenCenter(FlxAxes.XY);

		_second = new FlxSprite();
		_second.loadGraphic(FlxGraphic.fromClass(GraphicLogo), true);
		_second.antialiasing = true;
		_second.pixelPerfectRender = false;
		_second.color = FlxColor.WHITE;
		_second.alpha = 0.8; // Lowered alpha looks neat
		_second.screenCenter(FlxAxes.XY);

		add(new FlxTrail(_first, FlxGraphic.fromClass(GraphicLogo), 12, 0, 0.4, 0.02));
		add(_first);

		add(new FlxTrail(_second, FlxGraphic.fromClass(GraphicLogo), 12, 0, 0.4, 0.02));
		add(_second);

		FlxG.watch.add(this, "i");
		FlxG.watch.add(this, "_goingUp");
		FlxG.watch.add(this, "s");
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (_goingUp) {
			i += 2;
			if (i == 500)
				_goingUp = false;
		} else {
			i -= 2;
			if (i == 0)
				_goingUp = true;
		}

		s = Math.sin(i / 100) * 1000; // from -1000 to 1000
		c = Math.cos(i / 100) * 1000;

		_first.angularVelocity = s;
		_second.angularVelocity = s;

		_first.x = (FlxG.width / 2 - _first.width / 2) +
					(s > 0 ? -1 : 1) *
					(FlxG.width - _first.width * 4) * 
					(s > 0 ? s : -s) / 2000;

		_first.y = (FlxG.height / 2 - _first.height / 2) +
					(c > 0 ? 1 : -1) *
					(FlxG.height - _first.height * 4) *
					(c > 0 ? c : -c) / 2000;

		_second.x = Math.abs(_first.x - FlxG.width + _first.width);
		_second.y = Math.abs(_first.y - FlxG.height + _first.height);
	}
}