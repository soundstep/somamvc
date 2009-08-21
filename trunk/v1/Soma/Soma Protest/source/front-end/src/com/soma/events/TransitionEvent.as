package com.soma.events {
	
	import com.soma.vo.TransitionVO;	
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
	
	public class TransitionEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const ADD: String = "addTransition";
		public static const REMOVE: String = "removeTransition";
		public static const REMOVE_ALL: String = "removeAllTransitions";
		
		public static const START: String = "startTransition";
		public static const STOP: String = "stopTransition";
		public static const STOP_ALL: String = "stopAllTransitions";
		
		public static const STARTED: String = "transitionStarted";
		
		public static const STOPPED: String = "transitionStopped";
		public static const ALL_STOPPED: String = "allTransitionsStopped";
		
		public var item:Object;
		public var id:String;
		public var transition:TransitionVO;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TransitionEvent(type:String, item:Object = null, id:String = null, transition:TransitionVO = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.item = item;
			this.id = id;
			this.transition = transition;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new TransitionEvent(type, item, id, transition, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("TransitionEvent", "item", "id", "transition", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
