package com.soma.view.video.skin {
	import com.soma.view.video.SomaVideoPlayer;
	import com.soma.view.video.skin.ISomaVideoFullscreenSkin;

	import flash.display.Sprite;
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
     * Default control skin for a SomaVideoPlayer fullscreen button, automatically instantiated by the SomaVideoControls class if you dont specify one in the SomaVideoPlayer instance.<br/><br/>
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
     * Now you know to add controls to the player, you can build your own fullscreen skin. The base will be a DisplayObject class, such as Sprite, implementing ISomaVideoMuteSkin.<br/><br/>
     * <b>Custom mute class</b>
     * <listing version="3.0">
package {
    import com.soma.view.video.SomaVideoPlayer;
    import com.soma.view.video.skin.ISomaVideoFullscreenSkin;
    
    import flash.display.Sprite;
    
    public class CustomFullscreenSkin extends Sprite implements ISomaVideoFullscreenSkin {
        
        private var _player:SomaVideoPlayer;
        
        public function CustomFullscreenSkin() {
            createSkinElements();
        }
        
        private function createSkinElements():void {
            // create fullcreen buttons here and use:
            // _player.fullscreen = false;
            // _player.fullscreen = true;
        }
        
        public function registerPlayer(player:SomaVideoPlayer):void {
            _player = player;
        }
        
        public function dispose():void {
            // remove skin elements and events listeners for cleaning when the SomaVideoPlayer instance is disposed.
        }
        
        public function fullscreenCallBack(value:Boolean):void {
            // here the controllers will indicate when the fullscreen state has changed.
            trace("Fullscreen state: ", value);
        }
        
    }
}
 	 * </listing> 
     * Add the CustomFullscreenSkin to the SomaVideoControls instead of the default one:
     * <listing version="3.0">
var controls:SomaVideoControls = new SomaVideoControls();
controls.addControl(new CustomFullscreenSkin());
var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv", controls);
addChild(player);
     * </listing>
     * <b>Get a skin</b><br/><br/>
     * <listing version="3.0">
var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");
addChild(player);
var skin:SomaVideoFullscreenSkin = player.controls.getControl(SomaVideoFullscreenSkin) as SomaVideoFullscreenSkin;
skin.backgroundColor = 0xFF0000;
skin.backgroundAlpha = .5;
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
     * @see com.soma.view.video.skin.SomaVideoTimeBarSkin SomaVideoTimeBarSkin
     * @see com.soma.view.video.skin.SomaVideoMuteSkin SomaVideoMuteSkin
     */
	
	public class SomaVideoFullscreenSkin extends Sprite implements ISomaVideoFullscreenSkin {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _fullscreenButtonOn:Sprite;
		private var _fullscreenButtonOff:Sprite;
		
		private var _player:SomaVideoPlayer;
		
		private var _isOn:Boolean;
		
		private var _backgroundColor:uint = 0x000000;
		private var _backgroundAlpha:Number = 0;
		private var _buttonColor:uint = 0xFFFFFF;
		private var _buttonAlpha:Number = 1;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a SomaVideoFullscreenSkin instance.  */
		public function SomaVideoFullscreenSkin() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		protected function init():void {
			buttonMode = true;
			mouseChildren = false;
			addEventListener(MouseEvent.CLICK, clickHandler);
			create();
			draw();
			setDefault();
		}
		
		/** @private */
		protected function create():void {
			_fullscreenButtonOn = addChild(new Sprite) as Sprite;
			_fullscreenButtonOff = addChild(new Sprite) as Sprite;
		}
		
		/** @private */
		protected function draw():void {
			graphics.clear();
			graphics.beginFill(_backgroundColor, _backgroundAlpha);
			graphics.drawRect(0, 0, 20, 20);
			graphics.endFill();
			// fullscreen on
			_fullscreenButtonOn.graphics.clear();
			_fullscreenButtonOn.graphics.beginFill(_buttonColor, _buttonAlpha);
			_fullscreenButtonOn.graphics.drawRect(0, 0, 12, 8);
			_fullscreenButtonOn.graphics.drawRect(1, 1, 10, 6);
			_fullscreenButtonOn.graphics.drawRect(2, 2, 8, 4);
			_fullscreenButtonOn.graphics.endFill();
			// fullscreen off
			_fullscreenButtonOff.graphics.clear();
			_fullscreenButtonOff.graphics.beginFill(_buttonColor, _buttonAlpha);
			_fullscreenButtonOff.graphics.drawRect(0, 0, 12, 8);
			_fullscreenButtonOff.graphics.drawRect(1, 1, 10, 6);
			_fullscreenButtonOff.graphics.drawRect(1, 1, 6, 3);
			_fullscreenButtonOff.graphics.endFill();
			
		}
		
		/** @private */
		protected function setDefault():void {
			_fullscreenButtonOn.x = 4;
			_fullscreenButtonOn.y = 6;
			_fullscreenButtonOn.visible = false;
			_fullscreenButtonOff.x = 4;
			_fullscreenButtonOff.y = 6;
		}
		
		/** @private */
		protected function clickHandler(e:MouseEvent):void {
			_player.fullscreen = !_isOn;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Register the SomaVideoPlayer instance that will be used with the skin class
		 * @param player A SomaVideoPlayer instance.
		 */
		public function registerPlayer(player:SomaVideoPlayer):void {
			_player = player;
		}
		
		/** Method that receives information from the FullscreenController.
		 * @param value A Boolean indicating whether the current display state is fullscreen.
		 */
		public function fullscreenCallBack(value:Boolean):void {
			_isOn = value;
			_fullscreenButtonOn.visible = _isOn;
			_fullscreenButtonOff.visible = !_isOn;
		}
		
		/** This method is internally called when you dispose a SomaVideoPlayer to remove children, the event listeners or whatever that needs to be destroyed to free the memory (make the instance elligible to the Garbage Collection). */
		public function dispose():void {
			addEventListener(MouseEvent.CLICK, clickHandler);
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		
		/** Get the fullscreen on button.
		 * @return A Sprite.
		 */
		public function get fullscreenButtonOn():Sprite {
			return _fullscreenButtonOn;
		}
		
		/** Get the fullscreen off button.
		 * @return A Sprite.
		 */
		public function get fullscreenButtonOff():Sprite {
			return _fullscreenButtonOff;
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
		
		/** Specifies the default color of the buttons (default is white). */
		public function get buttonColor():uint {
			return _buttonColor;
		}
		
		public function set buttonColor(buttonColor:uint):void {
			_buttonColor = buttonColor;
			draw();
		}
		
		/** Specifies the default transparency of the buttons (default alpha 1). */
		public function get buttonAlpha():Number {
			return _buttonAlpha;
		}
		
		public function set buttonAlpha(buttonAlpha:Number):void {
			_buttonAlpha = buttonAlpha;
			draw();
		}
	}
}
