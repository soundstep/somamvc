package com.somaprotest.pages {
	import com.soma.Soma;
	import com.soma.events.MenuEvent;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.view.SomaText;
	import com.somaprotest.pages.core.CanvasPage;

	import flash.events.TextEvent;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 05-2008<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class CmdMenu extends CanvasPage implements IPage {

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
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
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
			new MenuEvent(MenuEvent.OPEN_MENU, _randomPage).dispatch();
			_randomPage = getRandomPage();
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionIn():void {
			super.transitionIn();
		}

		override public function transitionInComplete():void {
			super.transitionInComplete();
		}
		
		override public function transitionOut():void {
			super.transitionOut();
		}
		
		override public function transitionOutComplete():void {
			removeEventListener(PageEvent.INITIALIZED, createElements, false);
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
		
	}
}
