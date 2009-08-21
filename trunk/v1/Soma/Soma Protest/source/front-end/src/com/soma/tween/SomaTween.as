package com.soma.tween {
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import com.soma.Soma;	
	import com.soma.vo.TransitionVO;	
	import com.soma.events.TransitionEvent;	

	
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
	
	public class SomaTween {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:SomaTween = new SomaTween();
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaTween() {
			if (_instance != null) throw new Error("You can instantiate SomaTween, use methods like SomaTween.start");
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________

		public static function start(target:Object, id:String = null, vars:Object = null, save:Boolean = false):Object {
			if (id == null && vars == null) throw new CairngormError(CairngormMessage.TRANSITION_NO_DATA, id);
			if (id != null && vars != null && save) {
				new TransitionEvent(TransitionEvent.ADD, null, id, new TransitionVO(id, vars)).dispatch();
			}
			var transition:TransitionVO = (id != null) ? Soma.getInstance().transition.getTransition(id) : new TransitionVO(id, vars);
			new TransitionEvent(TransitionEvent.START, target, id, transition).dispatch();
			return Soma.getInstance().transition.getLastTransitionReturn();
		}
		
		public static function stop(target:Object):void {
			new TransitionEvent(TransitionEvent.STOP, target).dispatch();
		}
		
		public static function stopAll():void {
			new TransitionEvent(TransitionEvent.STOP_ALL).dispatch();
		}
		
	}
}