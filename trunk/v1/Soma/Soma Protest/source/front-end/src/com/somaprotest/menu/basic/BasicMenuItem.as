package com.somaprotest.menu.basic {
	
	import com.soma.Soma;	
	import com.soma.tween.SomaTween;	
	import com.soma.view.SomaText;	
	import flash.text.TextField;	
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;	
	import flash.events.MouseEvent;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> BETA 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 05-2008<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class BasicMenuItem extends Sprite {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _colorOut:int;
		private var _colorOver:int;
		private var _active:Boolean = false;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var txt:SomaText;
		public var id:String;
		public var type:String;
		public var externalLink:String;
		public var children:XMLList;
		public var initY:Number;
		public var posY:Number;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicMenuItem() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			var styleColorOut:String = Soma.getInstance().styles.getGlobalStyle(".colorMenuItemOut")['color'];
			var styleColorOver:String = Soma.getInstance().styles.getGlobalStyle(".colorMenuItemOver")['color'];
			_colorOut = parseInt(String(styleColorOut).substring(1), 16);
			_colorOver = parseInt(String(styleColorOver).substring(1), 16);
			txt = new SomaText("", "menuItem");
			txt.antiAliasType = AntiAliasType.NORMAL;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.textColor = _colorOut;
			addChild(txt);
			addEventListener(MouseEvent.MOUSE_OVER, overHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, outHandler, false, 0, true);
		}
		
		private function overHandler(e:MouseEvent = null):void {
			if (!active) {
				SomaTween.start(this, null, {time:.2, _color:_colorOver});
			}
		}
		
		private function outHandler(e:MouseEvent = null):void {
			if (!active) {
				SomaTween.start(this, null, {time:.2, _color:_colorOut});
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function set text(value:String):void {
			txt.htmlText = value;
		}
		
		public function set active(b:Boolean):void {
			_active = false;
			if (b) overHandler();
			else outHandler();
			_active = b;
		}
		
		public function get active():Boolean {
			return _active;
		}
		
	}
	
}
