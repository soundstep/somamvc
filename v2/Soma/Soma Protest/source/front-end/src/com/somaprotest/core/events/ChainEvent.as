package com.somaprotest.core.events {
	import com.soma.control.CairngormEvent;
	import com.soma.interfaces.IComplete;
	
	import flash.events.Event;	

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
	
	public class ChainEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const STEP1: String = "com.soma.events.ChainEvent.STEP1";
		public static const STEP2: String = "com.soma.events.ChainEvent.STEP2";
		public static const STEP3: String = "com.soma.events.ChainEvent.STEP3";		public static const STEP4: String = "com.soma.events.ChainEvent.STEP4";
		
		public var complete:IComplete;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ChainEvent(type:String, complete:IComplete = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.complete = complete;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new ChainEvent(type, complete, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("ChainEvent", "complete", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
