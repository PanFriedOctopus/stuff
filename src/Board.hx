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
import haxe.Timer;
import flash.net.URLLoader;
import flash.net.URLRequest;

/**
 * ...
 * @author Vic Antley
 */
class Board extends Sprite
{
	var sprite:Sprite;
	var wait:Sprite;
	var mousewin:Sprite;
	var kittywin:Sprite;
	
	var One:Square;
	var Two:Square;
	var Three:Square;
	var Four:Square;
	var Five:Square;
	var Six:Square;
	var Seven:Square;
	var Eight:Square;
	var Nine:Square;
	
	var gameover1:Bool;
	var gameover0:Bool;
	public var waiting:Bool;
	
	var player:Player;
	var players:List<Player>;
	
	var kittybool:Bool;
	var mousebool:Bool;
	
	var key:Float;
	
	var checkwait:Bool;
	
	public function new() 
	{
		super();
		sprite = new Sprite();
		wait = new Sprite();
		mousewin = new Sprite();
		kittywin = new Sprite();
		var img4 = new Bitmap(Assets.getBitmapData("img/catwins.png"));
		var img3 = new Bitmap(Assets.getBitmapData("img/mousewins.png"));
		var img2 = new Bitmap(Assets.getBitmapData("img/waiting.png"));
		var img = new Bitmap(Assets.getBitmapData("img/board.png"));
		sprite.addChild(img);
		wait.addChild(img2);
		mousewin.addChild(img3);
		kittywin.addChild(img4);
		//trace("DUMMB");
		this.addChild(sprite);
		this.addChild(wait);
		
		this.x = 0;
		this.y = 0;
		
		One = new Square(126, 104, 157, 65);
		this.addChild(One);
		Two = new Square(222, 103, 267, 72);
		this.addChild(Two);
		Three = new Square(107, 98, 486, 72);
		this.addChild(Three);
		Four = new Square(126, 103, 166, 174);
		this.addChild(Four);
		Five = new Square(209, 101, 284, 170);
		this.addChild(Five);
		Six = new Square(114, 98, 490, 169);
		this.addChild(Six);
		Seven = new Square(120, 102, 171, 271);
		this.addChild(Seven);
		Eight = new Square(204, 100, 293, 269);
		this.addChild(Eight);
		Nine = new Square(109, 86, 491, 267);
		this.addChild(Nine);
		
		gameover1 = false;
		gameover0 = false;
		waiting = true;
		kittybool = false;
		mousebool = false;
		
		key = Math.random();
	}
	
	private function checkIP()
	{
		var urlLoader = new URLLoader();
		urlLoader.load(new URLRequest("http://cse.asmsa.org/multiplayer/get_stat.php?name=vicTTT&statname=IP&rand="+Math.random()));
		urlLoader.addEventListener(Event.COMPLETE, validateIP);
	}

	private function validateIP(e:Event)
	{
		e.target.removeEventListener(Event.COMPLETE, validateIP);
		var data:String = e.target.data;
		//trace(data);
		var ips = data.split("\n");
		for (line in ips)
		{
			var ip = line.split(" ")[0];
			var key = line.split(" ")[1];

			if (key != null && Std.parseFloat(key) == this.key)
			{
				//trace("I MATCHED THE KEY");
				var player = new Player(ip);
			}
		}
		//if (player == null) trace("NULL");
		//trace(player.getIP());
	}
	
	private function addPlayer(ip:String)
	{
		var p = new Player(ip);
		players.add(p);
	}
	
	public function asignplayers()
	{
		for (p in players) 
		{
			if (kittybool = false) 
			{
				p.setValue(1);
				kittybool = true;
			}
			else if (mousebool = false) 
			{
				p.setValue(0);
				mousebool = true;
			}
			
		}
	}
	
	private function processIPs(e:Event)
	{
		e.target.removeEventListener(Event.COMPLETE, processIPs);

		var ipString:String = e.target.data;
		var ipArray = ipString.split("\n");
		for (ip in ipArray) if (ip.length > 0 && !connected(ip) && ip != player.getIP())
		addPlayer(ip);
	}
	
	

	private function communicateServer()
	{
		var urlSendIP = new URLLoader();
		urlSendIP.load(new URLRequest("http://cse.asmsa.org/multiplayer/send_ip.php?name=vicTTT"));
		
		var urlLoadIPs = new URLLoader();
		urlLoadIPs.load(new URLRequest("http://cse.asmsa.org/multiplayer/get_ips.php?name=vicTTT&deltaT=1"));
		urlLoadIPs.addEventListener(Event.COMPLETE, processIPs);
		
		var urlLoadclick = new URLLoader();
		urlLoadclick.load(new URLRequest("http://cse.asmsa.org/multiplayer/get_stat.php?name=vicTTT&statname=click&rand=" + Math.random()));
		urlLoadclick.addEventListener(Event.COMPLETE, setBoard);
		
		var urlLoadwin = new URLLoader();
		urlLoadwin.load(new URLRequest("http://cse.asmsa.org/multiplayer/get_stat.php?name=vicTTT&statname=y&rand=" + Math.random()));
		urlLoadwin.addEventListener(Event.COMPLETE, setwin);

	}
	
	private function setBoard(e:Event)
	{
		e.target.removeEventListener(Event.COMPLETE, setBoard);
		var tmp:String = e.target.data;
		trace(tmp);

		var ip = tmp.split(" ")[0];
		var temp1 = tmp.split(" ")[1];
		var temp2 = tmp.split(" ")[2];
		var temp3 = tmp.split(" ")[3];
		var temp4 = tmp.split(" ")[4];
		var temp5 = tmp.split(" ")[5];
		var temp6 = tmp.split(" ")[6];
		var temp7 = tmp.split(" ")[7];
		var temp8 = tmp.split(" ")[8];
		var temp9 = tmp.split(" ")[9];

		One.activate(temp1);
		Two.activate(temp2);
		Three.activate(temp3);
		Four.activate(temp4);
		Five.activate(temp5);
		Six.activate(temp6);
		Seven.activate(temp7);
		Eight.activate(temp8);
		Nine.activate(temp9);
	}
	
	private function setwin(e:Event)
	{
		e.target.removeEventListener(Event.COMPLETE, setwin);
		var tmp:String = e.target.data;
		trace(tmp);

		var ip = tmp.split(" ")[0];
		var temp0 = tmp.split(" ")[1];
		var temp1 = tmp.split(" ")[2];
		
		if (temp0 == "0") gameover0 = false;
		if (temp0 == "1") gameover0 = true;
		if (temp1 == "0") gameover1 = false;
		if (temp1 == "1") gameover1 = true;
	}
	
	public function checkwin()
	{
		if (One.value == 1 && Four.value == 1 && Seven.value == 1) gameover1 = true;
		if (One.value == 0 && Four.value == 0 && Seven.value == 0) gameover0 = true;
		
		if (Two.value == 1 && Five.value == 1 && Eight.value == 1) gameover1 = true;
		if (Two.value == 0 && Five.value == 0 && Eight.value == 0) gameover0 = true;
		
		if (Three.value == 1 && Six.value == 1 && Nine.value == 1) gameover1 = true;
		if (Three.value == 0 && Six.value == 0 && Nine.value == 0) gameover0 = true;
		
		if (One.value == 1 && Two.value == 1 && Three.value == 1) gameover1 = true;
		if (One.value == 0 && Two.value == 0 && Three.value == 0) gameover0 = true;
		
		if (Four.value == 1 && Five.value == 1 && Six.value == 1) gameover1 = true;
		if (Four.value == 0 && Five.value == 0 && Six.value == 0) gameover0 = true;
		
		if (Seven.value == 1 && Eight.value == 1 && Nine.value == 1) gameover1 = true;
		if (Seven.value == 0 && Eight.value == 0 && Nine.value == 0) gameover0 = true;
		
		if (One.value == 1 && Five.value == 1 && Nine.value == 1) gameover1 = true;
		if (One.value == 0 && Five.value == 0 && Nine.value == 0) gameover0 = true;
		
		if (Three.value == 1 && Five.value == 1 && Seven.value == 1) gameover1 = true;
		if (Three.value == 0 && Five.value == 0 && Seven.value == 0) gameover0 = true;
	}
	
	public function win0()
	{
		this.addChild(mousewin);
		checkwait = true;
	}
	public function win1()
	{
		this.addChild(kittywin);
		checkwait = true;
		var enemySpawn: Timer = new haxe.Timer(3500);
		enemySpawn.run = function():Void
		{
			this.addChild(wait);
			enemySpawn.stop();
		}
	}
	
	public function act()
	{	
		if (checkwait == true) 
		if (mousebool == true && kittybool == true)
		{
			checkwait = false;
			this.removeChild(wait);
		}
		
		checkwin();
		if (gameover0 = true)
			win0();
		if (gameover1 = true)
			win1();
		
		//if (gameover == true) trace ("through I mean hi");
	}
	
	private function connected(ip:String):Bool
	{
		for (player in players) if (player.getIP()==ip) return true;
		return false;
	}
	
}