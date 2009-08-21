package com.soma.view.video.skin {
	import com.soma.view.video.SomaVideoPlayer;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0<br/>
     * <b>Actionscript version:</b> 3.0</p>
     * <p><b>Copyright:</b></p>
     * <p>The contents of this file are subject to the Mozilla Public License<br />
     * Version 1.1 (the "License"); you may not use this file except in compliance<br />
     * with the License. You may obtain a copy of the License at<br /></p>
     * 
     * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>
     * 
     * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />
     * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />
     * See the License for the specific language governing rights and<br />
     * limitations under the License.<br /></p>
     * 
     * <p>The Original Code is Soma.<br />
     * The Initial Developer of the Original Code is Romuald Quantin.<br />
     * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>
     * 
     * <p><b>Usage:</b><br/>
     * Default control skin for a SomaVideoPlayer time/preloading/buffering bar, automatically instantiated by the SomaVideoControls class if you dont specify one in the SomaVideoPlayer instance.<br/><br/>
     * <b>How to add controls to the player</b><br/><br/>
     * The following code is reproducing how the default controls are added in the SomaVideoControls class (by default).
     * <listing version="3.0">
var controls:SomaVideoControls = new SomaVideoControls();
controls.addControl(new SomaVideoPlaySkin());
controls.addControl(new SomaVideoTimeBarSkin());
controls.addControl(new SomaVideoMuteSkin());
controls.addControl(new SomaVideoFullscreenSkin());
var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv", controls);
addChild(player);
     * </listing>
     * Now you know to add controls to the player, you can build your own time/preloading/buffering bar skin. The base will be a DisplayObject class, such as Sprite, implementing SomaVideoTimeBarSkin.<br/><br/>
     * <b>Custom time/preloading/buffering bar class</b>
     * <listing version="3.0">
package {
    import com.soma.view.video.SomaVideoPlayer;
	import com.soma.view.video.skin.ISomaVideoTimeBarSkin;

	import flash.display.Sprite;
    
    public class CustomTimeBarSkin extends Sprite implements ISomaVideoTimeBarSkin {
        
        private var _player:SomaVideoPlayer;
        
        public function CustomTimeBarSkin() {
            createSkinElements();
        }
        
        private function createSkinElements():void {
            // create elements here and use:
            // _player.seek(10);
        }
        
        public function registerPlayer(player:SomaVideoPlayer):void {
            _player = player;
        }
        
        public function dispose():void {
            // remove skin elements and events listeners for cleaning when the SomaVideoPlayer instance is disposed.
        }
        
        public function timeCallBack(time:Number, duration:Number):void {
            // here the controller will indicate when the time and duration of the video.
            trace("TIME > time: ", time, ", duration: ", duration);
        }
        
        public function preloadingCallBack(bytesLoaded:Number, bytesTotal:Number):void {
            // here the controller will indicate when the bytes loaded and the bytes total of the video .
            trace("PRELOADING > bytesLoaded: ", bytesLoaded, ", bytesTotal: ", bytesTotal);
        }
        
        public function bufferCallBack(length:Number, time:Number):void {
            // here the controller will indicate the current length of the buffer and the time it has to reach.
            trace("BUFFERING > length: ", length, ", time: ", time);
        }
        
    }
}
 	 * </listing> 
     * Add the CustomTimeBarSkin to the SomaVideoControls instead of the default one:
     * <listing version="3.0">
var controls:SomaVideoControls = new SomaVideoControls();
controls.addControl(new CustomTimeBarSkin());
var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv", controls);
addChild(player);
     * </listing>
     * <b>Get a skin</b><br/><br/>
     * <listing version="3.0">
var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");
addChild(player);
var skin:SomaVideoTimeBarSkin = player.controls.getControl(SomaVideoTimeBarSkin) as SomaVideoTimeBarSkin;
skin.backgroundColor = 0xFF0000;
skin.backgroundAlpha = .5;
skin.barHeight = 3;
     * </listing>
     * See the <a href="controls/SomaVideoControls.html">SomaVideoControls</a> documentation to add or create your own controls.
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.view.video.SomaVideo SomaVideo
     * @see com.soma.view.video.SomaVideoPlayer SomaVideoPlayer
     * @see com.soma.view.video.events.SomaVideoEvent SomaVideoEvent
     * @see com.soma.view.video.controls.SomaVideoControls SomaVideoControls
     * @see com.soma.view.video.skin.SomaVideoPlaySkin SomaVideoPlaySkin
     * @see com.soma.view.video.skin.SomaVideoMuteSkin SomaVideoMuteSkin
     * @see com.soma.view.video.skin.SomaVideoFullscreenSkin SomaVideoFullscreenSkin
     */
	
	public class SomaVideoTimeBarSkin extends Sprite implements ISomaVideoTimeBarSkin {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _player:SomaVideoPlayer;
		
		private var _durationBar:Sprite;
		private var _preloadingBar:Sprite;
		private var _timeBar:Sprite;
		private var _hitAreaBar:Sprite;
		
		private var _margin:Number;
		private var _barHeight:Number;
		
		private var _isDragging:Boolean;
		private var _wasPlaying:Boolean;
		
		private var _backgroundColor:uint = 0x000000;
		private var _backgroundAlpha:Number = 0;
		private var _durationBarColor:uint = 0xFFFFFF;
		private var _durationBarAlpha:Number = .2;
		private var _preloadingBarColor:uint = 0xFFFFFF;
		private var _preloadingBarAlpha:Number = .4;
		private var _timeBarColor:uint = 0xFFFFFF;
		private var _timeBarAlpha:Number = 1;
		
		private var _width:Number;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a SomaVideoPlaySkin instance.  */
		public function SomaVideoTimeBarSkin() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		private function init():void {
			_margin = 5;
			_barHeight = 2;
			_width = 20;
			_isDragging = false;
			create();
			draw();
			setDefault();
		}
		
		/** @private */
		protected function create():void {
			_durationBar = addChild(new Sprite) as Sprite;
			_preloadingBar = addChild(new Sprite) as Sprite;
			_timeBar = addChild(new Sprite) as Sprite;
			_hitAreaBar = addChild(new Sprite) as Sprite;
		}
		
		/** @private */
		private function draw():void {
			graphics.clear();
			graphics.beginFill(_backgroundColor, _backgroundAlpha);
			graphics.drawRect(0, 0, _width + (_margin << 1), 20);
			graphics.endFill();
			// duration bar
			_durationBar.graphics.clear();
			_durationBar.graphics.beginFill(_durationBarColor, _durationBarAlpha);
			_durationBar.graphics.drawRect(0, Math.floor(10-(_barHeight*.5)), _width, _barHeight);
			_durationBar.graphics.endFill();
			// duration bar
			_preloadingBar.graphics.clear();
			_preloadingBar.graphics.beginFill(_preloadingBarColor, _preloadingBarAlpha);
			_preloadingBar.graphics.drawRect(0, Math.floor(10-(_barHeight*.5)), _width, _barHeight);
			_preloadingBar.graphics.endFill();
			// time bar
			_timeBar.graphics.clear();
			_timeBar.graphics.beginFill(_timeBarColor, _timeBarColor);
			_timeBar.graphics.drawRect(0, Math.floor(10-(_barHeight*.5)), _width, _barHeight);
			_timeBar.graphics.endFill();
			// hit area
			_hitAreaBar.graphics.clear();
			_hitAreaBar.graphics.beginFill(0x0000FF, 0);
			_hitAreaBar.graphics.drawRect(0, 1, _width, 18);
			_hitAreaBar.addEventListener(MouseEvent.MOUSE_DOWN, seekTimeHandler);
			_hitAreaBar.graphics.endFill();
		}
		
		/** @private */
		protected function setDefault():void {
			_durationBar.x = _margin;
			_preloadingBar.x = _margin;
			_preloadingBar.scaleX = 0;
			_timeBar.x = _margin;
			_timeBar.scaleX = 0;
			_hitAreaBar.x = _margin;
		}
		
		/** @private */
		protected function seekTimeHandler(e:MouseEvent):void {
			if (stage == null) return;
			_wasPlaying = _player.video.isPlaying;
			_isDragging = true;
			_player.pause();
			addEventListener(Event.ENTER_FRAME, updateTimeHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseTimeHandler);
		}
		
		/** @private */
		protected function updateTimeHandler(e:Event):void {
			var barMouseX:Number = _hitAreaBar.mouseX;
			if (barMouseX < 0) barMouseX = 0;
			if (barMouseX > _width) barMouseX = _width;
			if (barMouseX / _width > _preloadingBar.scaleX) barMouseX = _preloadingBar.scaleX * width;
			var timebarValue:Number = barMouseX / _width;
			_timeBar.scaleX = timebarValue;
			_player.seek(barMouseX * _player.duration / _width);
		}
		
		/** @private */
		protected function releaseTimeHandler(e:Event):void {
			_isDragging = false;
			removeEventListener(Event.ENTER_FRAME, updateTimeHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseTimeHandler);
			if (_timeBar.scaleX == 0) {
				_player.stop();
				if (_wasPlaying) _player.play();
			}
			else if (_timeBar.scaleX == 1) {
				if (_wasPlaying) _player.play();
				else _player.stop();
			}
			else {
				if (_wasPlaying) _player.resume();
			}
		}
		

		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Register the SomaVideoPlayer instance that will be used with the skin class
		 * @param player A SomaVideoPlayer instance.
		 */
		public function registerPlayer(player:SomaVideoPlayer):void {
			_player = player;
		}
		
		/** Methods called whenever the video playhead is updated to display the current time and duration in seconds of the video.
		 * @param time A Number indicating the current time of the video playhead in seconds.
		 * @param duration A Number indicating the duration of the video (time length) in seconds.
		 */
		public function timeCallBack(time:Number, duration:Number):void {
			if (!_isDragging) {
				_timeBar.scaleX = time / duration;
			}
		}
		
		/** Methods called whenever the video is preloading.
		 * @param bytesLoaded A Number indicating the number of bytes loaded.
		 * @param bytesTotal A Number indicating the total number of bytes to load.
		 */
		public function preloadingCallBack(bytesLoaded:Number, bytesTotal:Number):void {
			_preloadingBar.scaleX = bytesLoaded / bytesTotal;
		}
		
		/** Methods called whenever the video is buffering.
		 * @param length A Number indicating the current length of the buffer, this value must reach the time (max value) of the buffer to start to play.
		 * @param time A Number indicating the time of the buffer to reach in seconds (you can set this buffer time property with the SomaVideoPlayer instance property: bufferTime).
		 */
		public function bufferCallBack(length:Number, time:Number):void {
			// not used
		}
		
		/** This method is internally called when you dispose a SomaVideoPlayer to remove children, the event listeners or whatever that needs to be destroyed to free the memory (make the instance elligible to the Garbage Collection). */
		public function dispose():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		
		/** @private  */
		override public function set width(value:Number):void {
			 _width = value - (_margin << 1);
			draw();
		}
		
		/** Get the duration bar.
		 * @return A Sprite.
		 */
		public function get durationBar():Sprite {
			return _durationBar;
		}
		
		/** Get the time bar.
		 * @return A Sprite.
		 */
		public function get timeBar():Sprite {
			return _timeBar;
		}
		
		/** Get the preloading bar.
		 * @return A Sprite.
		 */
		public function get preloadingBar():Sprite {
			return _preloadingBar;
		}
		
		/** Specifies the height of the bars. */
		public function get barHeight():Number {
			return _barHeight;
		}
		
		public function set barHeight(barHeight:Number):void {
			_barHeight = barHeight;
			draw();
		}
		
		/** Specifies the background color of the skin (default is black). */
		public function get backgroundColor():uint {
			return _backgroundColor;
		}
		
		public function set backgroundColor(backgroundColor:uint):void {
			_backgroundColor = backgroundColor;
			draw();
		}
		
		/** Specifies the background transparency of the skin (default alpha 0). */
		public function get backgroundAlpha():Number {
			return _backgroundAlpha;
		}
		
		public function set backgroundAlpha(backgroundAlpha:Number):void {
			_backgroundAlpha = backgroundAlpha;
			draw();
		}
		
		/** Specifies the color of the duration bar (default is white). */
		public function get durationBarColor():uint {
			return _durationBarColor;
		}
		
		public function set durationBarColor(durationBarColor:uint):void {
			_durationBarColor = durationBarColor;
			draw();
		}
		
		/** Specifies the transparency of the duration bar (default is alpha 0.2). */
		public function get durationBarAlpha():Number {
			return _durationBarAlpha;
		}
		
		public function set durationBarAlpha(durationBarAlpha:Number):void {
			_durationBarAlpha = durationBarAlpha;
			draw();
		}
		
		/** Specifies the color of the time bar (default is white). */
		public function get timeBarColor():uint {
			return _timeBarColor;
		}
		
		public function set timeBarColor(timeBarColor:uint):void {
			_timeBarColor = timeBarColor;
			draw();
		}
		
		/** Specifies the transparency of the time bar (default is alpha 1). */
		public function get timeBarAlpha():Number {
			return _timeBarAlpha;
		}
		
		public function set timeBarAlpha(timeBarAlpha:Number):void {
			_timeBarAlpha = timeBarAlpha;
			draw();
		}
		
		/** Specifies the color of the preloading bar (default is white). */
		public function get preloadingBarColor():uint {
			return _preloadingBarColor;
		}
		
		public function set preloadingBarColor(preloadingBarColor:uint):void {
			_preloadingBarColor = preloadingBarColor;
			draw();
		}
		
		/** Specifies the transparency of the time bar (default is alpha 0.4). */
		public function get preloadingBarAlpha():Number {
			return _preloadingBarAlpha;
		}
		
		public function set preloadingBarAlpha(preloadingBarAlpha:Number):void {
			_preloadingBarAlpha = preloadingBarAlpha;
			draw();
		}
	}
}
