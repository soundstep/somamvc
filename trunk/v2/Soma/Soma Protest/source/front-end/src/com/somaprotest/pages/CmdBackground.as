package com.somaprotest.pages {
	import com.soma.Soma;
	import com.soma.events.BackgroundEvent;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.view.SomaText;
	import com.somaprotest.core.view.CodeBox;
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
	
	public class CmdBackground extends CanvasPage implements IPage {

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
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
			_backgrounds = [];
			Soma.getInstance().addEventListener(BackgroundEvent.SHOW, getCurrentBackgroundName, false, 0, true);
			Soma.getInstance().addEventListener(BackgroundEvent.HIDE, getCurrentBackgroundName, false, 0, true);
			getBackgroundList();
			buildCommandLinks();
			buildCurrentBackground();
			buildHideBackground();
			buildBackgroundInfoXML();
		}
		
		private function getCurrentBackgroundName(e:BackgroundEvent):void {
			_currentBackgroundField.htmlText = "The current background id is: " + e.id;
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
				var str:String = "Asset type: " + _backgroundList.(@id == id).name() + "<br/>";
				str += '<a href="event:' + id + '">new BackgroundEvent(BackgroundEvent.SHOW, "' + id + '").dispatch();</a>';
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
		
		private function formatHtmlString(value:String):String {
			var pattern:RegExp = new RegExp("(<)([^>]*)(>)", "i");
			return value.replace(pattern, "&lt;$2&gt;");
		}
		
		private function buildBackgroundInfoXML():void {
			// text 3
			var text3:SomaText = new SomaText(content.*.(@id == "text3"), "body");
			text3.width = canvas.width - 25;
			text3.y = posY;
			canvas.addChild(text3);
			posY = text3.y + text3.height + 7;
			// list backgrounds
			var bgList:CodeBox = new CodeBox(300, 165);
			bgList.width = canvas.width - 30;
			bgList.y = posY;
			canvas.addChild(bgList);
			bgList.addCodeLine('&lt;backgrounds&gt;');
			for each (var bg:XML in _backgroundList) {
				bgList.addCodeLine("    " + formatHtmlString(bg.toXMLString()));
			}
			bgList.addCodeLine('&lt;/backgrounds&gt;');
			posY = bgList.y + bgList.height + 7;
			canvas.refresh();
			// text 4
			var text4:SomaText = new SomaText(content.*.(@id == "text4"), "body");
			text4.width = canvas.width - 25;
			text4.y = posY;
			canvas.addChild(text4);
			posY = text4.y + text4.height + 7;
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
			Soma.getInstance().removeEventListener(BackgroundEvent.SHOW, getCurrentBackgroundName, false);
			Soma.getInstance().removeEventListener(BackgroundEvent.HIDE, getCurrentBackgroundName, false);
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
	
	}
}
