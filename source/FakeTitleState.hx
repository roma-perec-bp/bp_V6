package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;

import flixel.addons.effects.FlxTrail;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end

typedef TitleDataFake =
{
	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
	bpm:Int
}

class FakeTitleState extends MusicBeatState
{
	var logotrail:FlxTrail;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	var logo:FlxSprite;

	var white:FlxSprite;
	
	var titleTextColors:Array<FlxColor> = [0xFF00ff12, 0xFFff0000];
	var titleTextAlphas:Array<Float> = [1, .64];

	var noZoom:Bool = false;

	var titleJSON:TitleDataFake;

	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();

		super.create();

		// IGNORE THIS!!!
		titleJSON = Json.parse(Paths.getTextFromFile('images/fake_title/gfDanceTitle.json'));

		FlxG.mouse.visible = false;
		startIntro();
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;
	var textBG:FlxSprite;

	var gfDanceConfuse1:FlxSprite;
	var gfDanceConfuse2:FlxSprite;

	function startIntro()
	{
		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('fake/bp_main'), 0);
		}

		Conductor.changeBPM(titleJSON.bpm);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite(-380, -140);
		bg.antialiasing = ClientPrefs.globalAntialiasing;

		if (titleJSON.backgroundSprite != null && titleJSON.backgroundSprite.length > 0 && titleJSON.backgroundSprite != "none"){
			bg.loadGraphic(Paths.image('fake_title/'+titleJSON.backgroundSprite));
		}else{
			bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		}

		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		logoBl = new FlxSprite(titleJSON.titlex, titleJSON.titley);
		logoBl.frames = Paths.getSparrowAtlas('fake_title/logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logoBl.animation.play('bump');
		logoBl.scale.set(1.2, 1.2);
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		if(ClientPrefs.shaders) swagShader = new ColorSwap();
		gfDance = new FlxSprite(0, titleJSON.gfy);
		gfDance.antialiasing = ClientPrefs.globalAntialiasing;
		gfDance.frames = Paths.getSparrowAtlas('fake_title/gfDanceTitle');
		gfDance.animation.addByPrefix('japDance', 'dance', 24, false);
		gfDance.scale.set(0.45,0.45);
		gfDance.screenCenter(X);

		gfDanceConfuse1 = new FlxSprite(0, titleJSON.gfy);
		gfDanceConfuse1.antialiasing = ClientPrefs.globalAntialiasing;
		gfDanceConfuse1.frames = Paths.getSparrowAtlas('fake_title/cutscene_1');
		gfDanceConfuse1.animation.addByPrefix('anim', 'cutscene', 24, false);
		gfDanceConfuse1.scale.set(0.45,0.45);
		gfDanceConfuse1.screenCenter(X);

		gfDanceConfuse2 = new FlxSprite(0, titleJSON.gfy);
		gfDanceConfuse2.antialiasing = ClientPrefs.globalAntialiasing;
		gfDanceConfuse2.frames = Paths.getSparrowAtlas('fake_title/cutscene_2');
		gfDanceConfuse2.animation.addByPrefix('anim', 'cutscene_2', 24, false);
		gfDanceConfuse2.scale.set(0.45,0.45);
		gfDanceConfuse2.screenCenter(X);

		logotrail = new FlxTrail(gfDance, null, 3, 6, 0.3, 0.002);
		//logotrail.blend = ADD;
		logotrail.color = 0xffff0000;
		add(logotrail);

		add(gfDance);

		add(gfDanceConfuse1);
		add(gfDanceConfuse2);

		gfDanceConfuse1.alpha = 0.0001;
		gfDanceConfuse2.alpha = 0.0001;

		add(logoBl);
		if(swagShader != null)
		{
			gfDance.shader = swagShader.shader;
			logoBl.shader = swagShader.shader;
		}

		titleText = new FlxSprite(titleJSON.startx, titleJSON.starty);
		titleText.frames = Paths.getSparrowAtlas('fake_title/titleEnter');
		var animFrames:Array<FlxFrame> = [];
		@:privateAccess {
			titleText.animation.findByPrefix(animFrames, "ENTER IDLE");
			titleText.animation.findByPrefix(animFrames, "ENTER FREEZE");
		}
		
		if (animFrames.length > 0) {
			newTitle = true;
			
			titleText.animation.addByPrefix('idle', "ENTER IDLE", 24);
			titleText.animation.addByPrefix('press', ClientPrefs.flashing ? "ENTER PRESSED" : "ENTER FREEZE", 24);
		}
		else {
			newTitle = false;
			
			titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
			titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		}

		textBG = new FlxSprite(0, FlxG.height - 97).makeGraphic(FlxG.width, 200, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);
		
		//titleText.scale.set(0.45,0.45);
		titleText.animation.play('idle');
		titleText.updateHitbox();
		titleText.screenCenter(X);
		titleText.antialiasing = ClientPrefs.globalAntialiasing;

		add(titleText);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('fake_title/basementLogo'));
		add(ngSpr);
		ngSpr.alpha = 0.0001;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.5));
		ngSpr.updateHitbox();
		ngSpr.screenCenter();
		ngSpr.antialiasing = ClientPrefs.globalAntialiasing;

		logo = new FlxSprite(0, 0).loadGraphic(Paths.image('fake_title/logo'));
		add(logo);
		logo.visible = false;
		logo.scale.set(0.01,0.01);
		logo.updateHitbox();
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.globalAntialiasing;

		white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFffffff);
		white.alpha = 0.00001;
		add(white);

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		// credGroup.add(credTextShit);
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;
	
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		
		if (newTitle) {
			titleTimer += FlxMath.bound(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		// EASTER EGG

		if (!transitioning && skippedIntro)
		{
			if (newTitle && !pressedEnter)
			{
				var timer:Float = titleTimer;
				if (timer >= 1)
					timer = (-timer) + 2;
				
				timer = FlxEase.quadInOut(timer);
				
				titleText.color = FlxColor.interpolate(titleTextColors[0], titleTextColors[1], timer);
				titleText.alpha = FlxMath.lerp(titleTextAlphas[0], titleTextAlphas[1], timer);
			}
			
			if(pressedEnter)
			{
				titleText.color = FlxColor.WHITE;
				titleText.alpha = 1;
				
				if(titleText != null) titleText.animation.play('press');

				FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1, true);
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				noZoom = true;
				transitioning = true;
				FlxG.sound.music.stop();

				FlxG.sound.play(Paths.sound('budget_xd'), 1, false, null, true, function() {
					TitleState.initialized = false;

					ClientPrefs.saveSettings();

					FlxG.sound.music.fadeOut(0.3);
					if(FreeplayState.vocals != null)
					{
						FreeplayState.vocals.fadeOut(0.3);
						FreeplayState.vocals = null;
					}
					FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
				});

				FlxTween.cancelTweensOf(FlxG.camera);
				FlxTween.tween(textBG, {alpha: 0}, 0.7, {ease: FlxEase.linear});
				FlxTween.tween(titleText, {alpha: 0}, 0.7, {ease: FlxEase.linear});
				FlxTween.tween(logoBl, {alpha: 0}, 0.7, {ease: FlxEase.linear});

				gfDanceConfuse1.alpha = 1;
				gfDance.alpha = 0;

				remove(logotrail);
				

				gfDanceConfuse1.animation.play('anim', true);
				gfDanceConfuse1.animation.finishCallback = function(pog:String)
				{
					gfDanceConfuse1.alpha = 0.00001;
					gfDanceConfuse2.alpha = 1;
					gfDanceConfuse2.animation.play('anim', true);
				}

				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true);
			money.screenCenter(X);
			money.alpha = 0.0001;
			money.y += (i * 60) + 200 + offset;
			if(credGroup != null && textGroup != null) {
				credGroup.add(money);
				textGroup.add(money);
			}
			FlxTween.tween(money, {alpha: 1}, 0.5, {ease: FlxEase.linear});
		}
	}

	function addMoreText(text:String, ?offset:Float = 0)
	{
		if(textGroup != null && credGroup != null) {
			var coolText:Alphabet = new Alphabet(0, 0, text, true);
			coolText.screenCenter(X);
			coolText.y += (textGroup.length * 60) + 200 + offset;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(skippedIntro) 
			if(!noZoom)
				if(ClientPrefs.camZooms)
					FlxTween.tween(FlxG.camera, {zoom:1.03}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});

		if(!transitioning)
		{
			if(logoBl != null)
				logoBl.animation.play('bump', true);
	
			if(gfDance != null)
				gfDance.animation.play('japDance', true);
		}

		if(!closedState) {
			sickBeats++;
			switch (sickBeats)
			{
				case 1:
					//FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('fake/bp_main'), 0);
					FlxTween.tween(ngSpr, {alpha: 1}, 0.5, {ease: FlxEase.linear});
					FlxG.sound.music.fadeIn(4, 0, 0.7);
					createCoolText(['Those BP guys presents'], 350);
				case 5:
					FlxTween.tween(ngSpr, {alpha: 0}, 0.3, {ease: FlxEase.linear});
					logo.visible = true;
					FlxTween.tween(logo.scale, {x: 0.25, y: 0.25}, 0.5, {ease: FlxEase.backOut});
				case 7:
					logo.angle = 17;
					FlxTween.tween(logo, {angle: 0}, 0.3, {ease: FlxEase.quadOut});
					logo.scale.set(0.55, 0.55);
					FlxTween.tween(logo.scale, {x: 0.45, y: 0.45}, 0.5, {ease: FlxEase.quadOut});
					if(ClientPrefs.flashing) FlxTween.tween(white, {alpha: 1}, 0.8, {ease: FlxEase.linear});
					if(!skippedIntro) FlxTween.tween(FlxG.camera, {zoom: 1.9}, 1.2, {ease: FlxEase.quadIn});
				case 8:
					logo.angle = -17;
					FlxTween.tween(logo, {angle: 0}, 0.3, {ease: FlxEase.quadOut});
					FlxTween.tween(logo.scale, {x: 1, y: 1}, 0.5, {ease: FlxEase.backInOut});
				case 9:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);
			remove(credGroup);
			FlxG.camera.flash(FlxColor.WHITE, 4, true);
			skippedIntro = true;
			white.visible = false;
			logo.alpha = 0;
			logoBl.scale.set(3, 3);
			FlxTween.tween(logoBl.scale, {x: 1.2, y: 1.2}, 1, {ease: FlxEase.bounceOut});
			FlxTween.cancelTweensOf(FlxG.camera);
			FlxG.camera.zoom = 1.0;
			if(!skippedIntro) FlxTween.tween(FlxG.camera, {zoom:1.03}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
		}
	}
}
