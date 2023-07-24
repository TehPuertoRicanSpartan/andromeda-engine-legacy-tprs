package states;

import flixel.FlxG;
import openfl.display.Sprite;
import openfl.events.AsyncErrorEvent;
import openfl.events.MouseEvent;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;

import hxcodec.flixel.FlxVideo;

class VideoState extends MusicBeatState
{
	var video:FlxVideo;

	public static var seenVideo:Bool = false;

	override function create()
	{
		super.create();

		seenVideo = true;

		FlxG.save.data.seenVideo = true;
		FlxG.save.flush();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		video = new FlxVideo();
		video.play(Paths.file('assets/preload/videos/kickstarterTrailer.mp4'));
		video.onEndReached.add(function()
		{
			finishCallback();
			return;
		}, true);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
			finishCallback();

		super.update(elapsed);
	}

	function finishCallback() {
		video.dispose();
		FlxG.switchState(new TitleState());
	}
}