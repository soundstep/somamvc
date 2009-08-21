package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.soma.view.SomaText;	
	import com.soma.events.MenuEvent;	
	import com.soma.Soma;	
	import com.soma.interfaces.IRemovable;
	import com.somaprotest.pages.core.CanvasPage;
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
	
	public class CmdMenu extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _pageList:XMLList;
		private var _pages:Array;
		private var _randomPage:String;
		private var _commandText:SomaText;
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function CmdMenu() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			buildForceMenuCommand();
		}
		
		private function getRandomPage():String {
			return _pages[Math.round(Math.random() * (_pages.length-1))];
		}
		
		private function updateCommandText():void {
			_commandText.htmlText = '<a href="event:' + _randomPage + '">new MenuEvent(MenuEvent.FORCE_OPEN_MENU, "' + _randomPage + '").dispatch();</a>';
		}
		
		private function buildForceMenuCommand():void {
			_pageList = Soma.getInstance().content.data..*.(name() == "page");
			_pages = [];
			for each (var page:XML in _pageList) {
				_pages.push(page.@id);
			}
			// command link
			_randomPage = getRandomPage();
			_commandText = new SomaText("", "body");
			_commandText.selectable = false;
			updateCommandText();
			_commandText.x = 30;
			_commandText.y = posY;
			_commandText.width = canvas.width - 25;
			canvas.addChild(_commandText);
			posY = _commandText.y + _commandText.height + 7;
			// listeners
			_commandText.addEventListener(TextEvent.LINK, executeForceMenu, false, 0, true);
			canvas.refresh();
		}
		
		private function executeForceMenu(e:TextEvent):void {
			updateCommandText();
			new MenuEvent(MenuEvent.FORCE_OPEN_MENU, _randomPage).dispatch();
			_randomPage = getRandomPage();
		}

		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			super.remove(e);
		}
		
		override public function dispose(e:Event = null):void {
			super.dispose(e);
		}
	
	}
}
