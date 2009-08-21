package com.somaprotest.pages {
	import flash.events.Event;	
	import com.soma.view.SomaText;	
	import com.soma.Soma;	
	import com.soma.interfaces.IRemovable;
	import com.somaprotest.pages.core.CanvasPage;
	import com.soma.events.BackgroundEvent;	
	import flash.events.TextEvent;	

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
	
	public class CmdBackground extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _backgroundList:XMLList;
		private var _backgrounds:Array;
		private var _currentBackgroundField:SomaText;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function CmdBackground() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			_backgrounds = [];
			Soma.getInstance().addEventListener(BackgroundEvent.SHOW, getCurrentBackgroundName, false, 0, true);
			Soma.getInstance().addEventListener(BackgroundEvent.HIDE, getCurrentBackgroundName, false, 0, true);
			getBackgroundList();
			buildCommandLinks();
			buildCurrentBackground();
			buildHideBackground();
		}
		
		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
		}
		
		private function getCurrentBackgroundName(e:BackgroundEvent):void {
			_currentBackgroundField.htmlText = "The current background id is: " + e.backgroundName;
		}

		private function getBackgroundList():void {
			var xml:XML = Soma.getInstance().content.data;
			_backgroundList = xml..*.(name() == "backgrounds").children();
			for each (var bg:XML in _backgroundList) {
				_backgrounds.push(bg.@id);
			}
		}
		
		private function buildCommandLinks():void {
			for each (var id:String in _backgrounds) {
				var str:String = '<a href="event:' + id + '">new BackgroundEvent(BackgroundEvent.SHOW, "' + id + '").dispatch();</a>';
				var command:SomaText = new SomaText(str, "body");
				command.width = canvas.width - 25;
				command.x = 30;
				command.y = posY;
				canvas.addChild(command);
				posY = command.y + command.height;
				// listeners
				command.addEventListener(TextEvent.LINK, executeShowBackground, false, 0, true);
			}
			posY += 7;
		}
		
		private function executeShowBackground(e:TextEvent):void {
			new BackgroundEvent(BackgroundEvent.SHOW, e.text).dispatch();
		}
		
		private function buildCurrentBackground():void {
			// current background text
			var currentBackgroundText:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			currentBackgroundText.width = canvas.width - 25;
			currentBackgroundText.y = posY;
			canvas.addChild(currentBackgroundText);
			posY = currentBackgroundText.y + currentBackgroundText.height + 7;
			// current background
			_currentBackgroundField = new SomaText("The current background id is: " + Soma.getInstance().background.currentBackground.name, "body");
			_currentBackgroundField.x = 30;
			_currentBackgroundField.y = posY;
			_currentBackgroundField.width = canvas.width - 25;
			canvas.addChild(_currentBackgroundField);
			posY = _currentBackgroundField.y + _currentBackgroundField.height + 7;
		}
		
		private function buildHideBackground():void {
			// hide background text
			var hideBackgroundText:SomaText = new SomaText(content.*.(@id == "text2"), "body");
			hideBackgroundText.y = posY;
			hideBackgroundText.width = canvas.width - 25;
			canvas.addChild(hideBackgroundText);
			posY = hideBackgroundText.y + hideBackgroundText.height + 7;
			// hide background
			var str:String = '<a href="event:' + id + '">new BackgroundEvent(BackgroundEvent.HIDE).dispatch();</a>';
			var command:SomaText = new SomaText(str, "body");
			command.width = canvas.width - 25;
			command.x = 30;
			command.y = posY;
			canvas.addChild(command);
			posY = command.y + command.height + 7;
			// listeners
			command.addEventListener(TextEvent.LINK, executeHideBackground, false, 0, true);
		}
		
		private function executeHideBackground(e:TextEvent):void {
			new BackgroundEvent(BackgroundEvent.HIDE).dispatch();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			super.remove(e);
		}
		
		override public function dispose(e:Event = null):void {
			Soma.getInstance().removeEventListener(BackgroundEvent.SHOW, getCurrentBackgroundName, false);
			Soma.getInstance().removeEventListener(BackgroundEvent.HIDE, getCurrentBackgroundName, false);
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.dispose(e);
		}
	
	}
}
