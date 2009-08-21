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
	
	public class MenuEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const FORCE_OPEN_MENU: String = "forceOpenMenu";
		public var pageName:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function MenuEvent(type:String, pageName:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.pageName = pageName;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new MenuEvent(type, pageName, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("MenuEvent", "pageName", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
