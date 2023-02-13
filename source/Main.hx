package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import openfl.display.BlendMode;
import openfl.text.TextFormat;
import openfl.display.Application;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

using StringTools;

class Main extends Sprite
{
	public static var game = {
		width: 1280,
		height: 720,
		initialState: states.InitState,
		zoom: -1.0,
		framerate: 60,
		#if HAXEFLIXEL_LOGO
		skipSplash: false,
		#else
		skipSplash: true,
		#end
		startFullscreen: false
	};

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / game.zoom);
			gameHeight = Math.ceil(stageHeight / game.zoom);
		}

		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.skipSplash, game.startFullscreen));

		#if !mobile
		addChild(new ui.FPSMem(10, 3, 0xFFFFFF));
		#end
	}

	public static function setFPSCap(cap:Int)
	{
		Main.game.framerate=cap;
		updateFramerate();
	}

	// thank u forever engine
	// https://github.com/Yoshubs/Forever-Engine/blob/master/source/Main.hx

	public static function updateFramerate(){
		if (Main.game.framerate > FlxG.updateFramerate)
		{
			FlxG.updateFramerate = Main.game.framerate;
			FlxG.drawFramerate = Main.game.framerate;
		}
		else
		{
			FlxG.drawFramerate = Main.game.framerate;
			FlxG.updateFramerate = Main.game.framerate;
		}
	}

	public static function adjustFPS(num:Float):Float{
		return FlxG.elapsed / (1/60) * num;
	}

	public static function getFPSCap():Float
	{
		return FlxG.drawFramerate;
	}
}
