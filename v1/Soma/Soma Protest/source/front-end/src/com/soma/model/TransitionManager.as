package com.soma.model {
	import com.soma.interfaces.ITransition;	
	import com.soma.Soma;	
	import com.soma.events.TransitionEvent;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import com.soma.vo.TransitionVO;	
	import flash.utils.Dictionary;
	
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
	
	public class TransitionManager implements ITransition {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var _transitions:Dictionary;
		
		private var _lastTransitionReturn:Object;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const SHOW:String = "show";
		public static const HIDE:String = "hide";
		public static const SHOW_BACKGROUND:String = "showBackground";
		public static const HIDE_BACKGROUND:String = "hideBackground";
		public static const SHOW_PAGE:String = "showPage";
		public static const HIDE_PAGE:String = "hidePage";
		
		public static var TIME_SHOW:Number = .7;
		public static var TIME_HIDE:Number = .7;
		
		public static var BACKGROUND_TIME_SHOW:Number = 2;
		public static var BACKGROUND_TIME_HIDE:Number = 2;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TransitionManager() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_transitions = new Dictionary();
			add(new TransitionVO(SHOW, {time:TIME_SHOW, _autoAlpha:1}));
			add(new TransitionVO(HIDE, {time:TIME_HIDE, _autoAlpha:0}));
			add(new TransitionVO(SHOW_BACKGROUND, {time:BACKGROUND_TIME_SHOW, _autoAlpha:1}));
			add(new TransitionVO(HIDE_BACKGROUND, {time:BACKGROUND_TIME_HIDE, _autoAlpha:0}));
			add(new TransitionVO(SHOW_PAGE, {time:TIME_SHOW, _autoAlpha:1}));
			add(new TransitionVO(HIDE_PAGE, {time:TIME_HIDE, _autoAlpha:0}));
		}

		private function addTransition(transition:TransitionVO):void {
			_transitions[transition.id] = transition;
		}
		
		private function removeTransition(id:String):void {
			if(_transitions[id] === null) throw new CairngormError(CairngormMessage.TRANSITION_NOT_REGISTERED, id);  
			_transitions[id] = null;
			delete _transitions[id]; 
		}
		
		private function getTransitionItem(id:String):TransitionVO {
			var transition:TransitionVO = _transitions[id];
			return transition;
		} 

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function add(transition:TransitionVO):void {
			addTransition(transition);
		}
		
		public function remove(id:String):void {
			removeTransition(id);
		}
		
		public function removeAll():void {
			init();
		}
		
		public function getTransition(id:String):TransitionVO {
			return getTransitionItem(id);
		}
		
		public function get transitions():Dictionary {
			return _transitions;
		}
		
		public function getLastTransitionReturn():Object {
			return _lastTransitionReturn;
		}
		
		public function execute(item:Object, id:String = null, transition:TransitionVO = null):Object {
			new TransitionEvent(TransitionEvent.STARTED, item, id, transition).dispatch();
			_lastTransitionReturn = Soma.getInstance().userTransition.execute(item, id, transition);
			return _lastTransitionReturn;
		}
		
		public function stop(item:Object):void {
			new TransitionEvent(TransitionEvent.STOPPED, item).dispatch();
			Soma.getInstance().userTransition.stop(item);
		} 

		public function stopAll():void {
			new TransitionEvent(TransitionEvent.ALL_STOPPED).dispatch();
			Soma.getInstance().userTransition.stopAll();
		}  
		
	}
}