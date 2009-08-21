package com.somaprotest.pages {
	
	import flash.events.Event;		
	import com.somaprotest.Transitions;	
	import flash.events.TextEvent;	
	import com.soma.view.SomaText;	
	import com.somaprotest.core.vo.AlertVO;	
	import com.somaprotest.core.events.AlertEvent;	
	import com.soma.interfaces.IRemovable;
	import com.somaprotest.pages.core.CanvasPage;

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
	
	public class SomaTweenPage extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _timeDelaylink:SomaText;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaTweenPage() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			buildTimeDelayDemo();
			buildText();
			//buildAlertCommand();
		}
		
		private function buildTimeDelayDemo():void {
			_timeDelaylink = new SomaText("", "body");
			updateTextLink();
			_timeDelaylink.width = canvas.width - 25;
			_timeDelaylink.y = posY;
			canvas.addChild(_timeDelaylink);
			_timeDelaylink.addEventListener(TextEvent.LINK, linkHandler);
			posY = _timeDelaylink.y + _timeDelaylink.height + 7;
		}
		
		private function updateTextLink():void {
			var str:String = (Transitions.TIME_ON && Transitions.DELAY_ON) ? "DISABLE" : "ENABLE";
			_timeDelaylink.htmlText = '<a href="event:' + str + '">Click here to ' + str + '</a> the time and delay for all the transitions in Soma Protest.';
		}
		
		private function linkHandler(e:TextEvent):void {
			switch (e.text) {
				case "ENABLE":
					Transitions.TIME_ON = true;
					Transitions.DELAY_ON = true;
					break;
				case "DISABLE":
					Transitions.TIME_ON = false;
					Transitions.DELAY_ON = false;
					break;
			}
			updateTextLink();
			var alertVO:AlertVO = new AlertVO("Time and Delay", "All the time and delay in SomaProtest are now " + e.text.toLowerCase() + ". Click on some pages as a demo, you can come back on this page to revert this setting.");
			new AlertEvent(AlertEvent.SHOW_ALERT, alertVO).dispatch();
		}

		private function buildText():void {
			var text1:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			text1.width = canvas.width - 25;
			text1.y = posY;
			canvas.addChild(text1);
			posY = text1.y + text1.height + 7;
			canvas.refresh();
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
