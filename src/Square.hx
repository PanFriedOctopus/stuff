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
 * @author Vic Antley
 */
class Square extends Sprite
{
	var on:Bool;
	public var value:Int;
	var mouse:Sprite;
	var kitty:Sprite;
	var square:Sprite;
	var xx:Float;
	var yy:Float;
	public function new(width, height, x, y) 
	{
		super();
		
		on = false;
		square = new Sprite();
		var idk = new Bitmap(Assets.getBitmapData("img/square.png"));
		square.addChild(idk);
		square.width = width;
		square.height = height;
		square.x = x;
		square.y = y;
		this.addChild(square);
		xx = x;
		yy = y;
		
		square.addEventListener(MouseEvent.MOUSE_DOWN, markaskitty);
		square.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, markasmouse);
		
		kitty = new Sprite();
		mouse = new Sprite();
		var kittykat = new Bitmap(Assets.getBitmapData("img/CatPrincess.png"));
		var mouserat = new Bitmap(Assets.getBitmapData("img/RatKing.png"));
		kitty.addChild(kittykat);
		mouse.addChild(mouserat);
		kitty.width = width;
		kitty.height = height;
		mouse.width = width;
		mouse.height = height;
		//this.addChild(kitty);
		
		value = 2;
	}
	public function markaskitty(e:MouseEvent) 
	{
		//var tempbool = Main.game.iswaiting();
		if (on == false /*&& tempbool == false*/)
		{
			on = true;
			this.addChild(kitty);
			kitty.x = xx;
			kitty.y = yy;
			value = 1;
		}
	}
	public function markasmouse(e:MouseEvent) 
	{
		//var tempbool = Main.game.iswaiting();
		if (on == false /*&& tempbool == false*/)
		{
			on = true;
			this.addChild(mouse);
			mouse.x = xx;
			mouse.y = yy;
			value = 0;
		}
	}
	
	public function activate(poop)
	{
		///var tempbool = Main.game.iswaiting();
		if (on == false /*&& tempbool == false*/)
		{
			on = true;
			if (poop == "1")
			{
				on = true;
				this.addChild(kitty);
				kitty.x = xx;
				kitty.y = yy;
				value = 1;
			}
			if (poop == "0")
			{
				this.addChild(mouse);
				mouse.x = xx;
				mouse.y = yy;
				value = 0;
			}
		}
	}
}