package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;
import motion.Actuate;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

/**
 * ...
 * @author Vic
 */
class Player extends Sprite
{
	public var IP:String;
	public var value:Int;
	public var key:Float;
	public function new(IP) 
	{
		super();
		this.IP = IP;
	}
	public function setValue(value)
	{
		this.value = value;
	}
	
	public function getIP()
	{
		return IP;
	}
	
}