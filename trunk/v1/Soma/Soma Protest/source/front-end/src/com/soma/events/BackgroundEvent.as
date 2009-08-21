package com.soma.events {

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
	
	public class BackgroundEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const SHOW: String = "showBackgroung";
		public static const HIDE:String = "hideBackground";
		public var backgroundName:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BackgroundEvent(type:String, backgroundName:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.backgroundName = backgroundName;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new BackgroundEvent(type, backgroundName, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("BackgroundEvent", "backgroundName", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
