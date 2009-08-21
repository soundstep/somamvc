package com.somaprotest.pages {
	
	import flash.events.Event;	
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
	
	public class CustomMVC extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _commandText:SomaText;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function CustomMVC() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			buildAlertCommand();
			buildText();
			buildAlertCommand();
		}
		
		private function buildAlertCommand():void {
			// command link
			_commandText = new SomaText('<a href="event:showAlert">new AlertEvent(AlertEvent.SHOW_ALERT, alertVO).dispatch();</a>', "body");
			_commandText.x = 30;
			_commandText.y = posY;
			_commandText.width = canvas.width - 25;
			canvas.addChild(_commandText);
			posY = _commandText.y + _commandText.height + 7;
			// listeners
			_commandText.addEventListener(TextEvent.LINK, executeShowAlert, false, 0, true);
			canvas.refresh();
		}
		
		private function buildText():void {
			var text1:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			text1.width = canvas.width - 25;
			text1.y = posY;
			canvas.addChild(text1);
			posY = text1.y + text1.height + 7;
			canvas.refresh();
		}
		
		private function executeShowAlert(e:TextEvent):void {
			var alertVO:AlertVO = new AlertVO("Information", content.*.(@id == "alertMessage"));
			new AlertEvent(AlertEvent.SHOW_ALERT, alertVO).dispatch();
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
