package com.soma.events {
	import flash.text.StyleSheet;	
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
	
	public class StyleSheetEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const LOADED: String = "styleSheetLoaded";
		
		public var stylesheet:StyleSheet;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function StyleSheetEvent(type:String, stylesheet:StyleSheet = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.stylesheet = stylesheet;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new StyleSheetEvent(type, stylesheet, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("StyleSheetEvent", "stylesheet", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
