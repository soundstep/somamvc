package com.soma.model {
	
	import com.soma.Soma;
	import com.soma.tween.SomaTween;	
	import com.soundstep.ui.BaseUI;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import com.soundstep.ui.ElementUI;	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
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
	
	public class BackgroundManager {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var _arrBg:Array;
		private static var _backgrounds:Sprite;
		private static var _currentBackground:DisplayObject;
		private static var _speed:Number;
		private static var _content:XMLList;
		private static var _loader:LoaderManager;
		private static var _baseUI:BaseUI;

		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BackgroundManager() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_arrBg = [];
			_speed = 2;
			_backgrounds = new Sprite();
			_backgrounds.name = "backgrounds";
			Soma.getInstance().ui.addChild(_backgrounds);
			_baseUI = new BaseUI(_backgrounds);
		}
		
		private function createBackgrounds():void {
			
			_loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, backgroundComplete);
			_arrBg = Soma.getInstance().template.parse(_baseUI, _content.children(), _loader);
			
		}
		
		private function backgroundComplete(e:QueueLoaderEvent):void {
			var el:ElementUI = _baseUI.add(e.targ);
			el.ratio = ElementUI.RATIO_OUT;
			el.alignX = el.alignY = ElementUI.ALIGN_CENTER;
			e.targ['alpha'] = 0;
			if (e.targ == _currentBackground) SomaTween.start(_currentBackground, TransitionManager.SHOW_BACKGROUND);
		}

		// PUBLIC
		//________________________________________________________________________________________________

		public function start():void {
			_content = Soma.getInstance().content.getBackgrounds();
			_loader = new LoaderManager();
			if (_content.children().length() > 0) createBackgrounds();
		}
		
		public function hide():void {
			if (_currentBackground != null) {
				SomaTween.start(_currentBackground, TransitionManager.HIDE_BACKGROUND);
				_currentBackground = null;
			}
		}
		
		public function show(bg:String):void {
			var b:DisplayObject = _backgrounds.getChildByName(bg) as DisplayObject;
			if (bg == "none" || bg == "false" || bg == "") {
				hide();
				_currentBackground = null;
			}
			else if (b != null && b != _currentBackground) {
				hide();
				_currentBackground = b;
				var el:ElementUI = _baseUI.getElement(_currentBackground);
				if (el != null) el.forceRefresh();
				SomaTween.start(_currentBackground, TransitionManager.SHOW_BACKGROUND);
			}
			else if (b == null) throw new CairngormError(CairngormMessage.BACKGROUND_NOT_FOUND, bg);
		}
		
		public function get backgrounds():Sprite {
			return _backgrounds;
		}
		
		public function get currentBackground():DisplayObject {
			return _currentBackground;
		}
	}
}