package states;

import flixel.FlxG;
import openfl.display.Sprite;
import openfl.events.AsyncErrorEvent;
import openfl.events.MouseEvent;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;

import vlc.VideoHandler;

class VideoState extends MusicBeatState
{
	var video:VideoHandler;

	var finishCallback:Void->Void;

	public static var seenVideo:Bool = false;

	override function create()
	{
		super.create();

		seenVideo = true;

		FlxG.save.data.seenVideo = true;
		FlxG.save.flush();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		video = new VideoHandler();
		video.playVideo(Paths.file('assets/preload/videos/kickstarterTrailer.mp4'));
		video.finishCallback = function()
		{
			FlxG.switchState(new TitleState());
		};
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
			video.finishCallback();

		super.update(elapsed);
	}
}