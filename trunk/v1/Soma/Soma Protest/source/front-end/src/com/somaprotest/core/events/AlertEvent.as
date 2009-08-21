package com.somaprotest.core.events {
	
	import com.somaprotest.core.vo.AlertVO;	
	
	import flash.events.Event;	
	import com.soma.control.CairngormEvent;
	
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
	
	public class AlertEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const SHOW_ALERT: String = "showAlert";
		public static const HIDE_ALERT: String = "hideAlert";
		
		public var alertVO:AlertVO;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function AlertEvent(type:String, alertVO:AlertVO = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.alertVO = alertVO;
			super(type, bubbles, cancelable);
			if (type == SHOW_ALERT && alertVO == null) throw new Error("You need an AlertVO to show an Alert: new AlertEvent(AlertEvent.SHOW_ALERT, alertVO).dispatch();");
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new AlertEvent(type, alertVO, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("AlertEvent", "alertVO", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
