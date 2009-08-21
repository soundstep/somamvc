package com.YOURPACKAGE {
	
	import gs.TweenGroup;	
	import gs.TweenMax;	
	import com.soma.Soma;	
	import com.soma.interfaces.ITransition;	
	import com.soma.model.TransitionManager;
	import com.soma.vo.TransitionVO;
	
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
	
	public class Transitions implements ITransition {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static var TIME_ON:Boolean;
		public static var DELAY_ON:Boolean;
		
		public static var GLOBAL_TIME:Number;
		public static var GLOBAL_DELAY:Number;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Transitions() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			Transitions.TIME_ON = true;
			Transitions.DELAY_ON = true;
			Transitions.GLOBAL_TIME = 0;
			Transitions.GLOBAL_DELAY = 0;
		}
		
		private function executeTransition(item:Object, id:String = null, transition:TransitionVO = null):Object {
			// build to work with TweenMax, the framework use the following properties
			// if you need to changes them for another Tween library:
			// _autoAlpha = 0 - 1, set visible to true or false after/before the tween
			// _color = hex, used in BasicMenuItem
			// onComplete = Function executed at the end of the tween
			// optional: if you use BasicMenu, a _color (uint) property is used
			var tran:TransitionVO = (id != null) ? Soma.getInstance().transition.getTransition(id) : transition;
			var time:Number;
			var tweenObj:Object = {};
			for (var s:String in tran.vars) {
				switch (s) {
					case "time":
						time = tran.vars[s];
						break;
					case "_autoAlpha":
						tweenObj["autoAlpha"] = tran.vars[s];
						break;
					case "_color":
						tweenObj["tint"] = tran.vars[s];
						break;
					default:
						tweenObj[s] = tran.vars[s];
						break;
				}
			}
			time = (tran.vars['time']!= null && Transitions.TIME_ON) ? tran.vars['time'] : Transitions.GLOBAL_TIME;
			tweenObj['delay'] = (tran.vars['delay']!= null && Transitions.DELAY_ON) ? tran.vars['delay'] : Transitions.GLOBAL_DELAY;
			var objReturn:Object;
			if (item is Array) {
				var tg:TweenGroup = TweenGroup.allTo(item as Array, time, tweenObj, TweenMax);
				objReturn = tg.tweens;
			}
			else objReturn = TweenMax.to(item, time, tweenObj);
			return objReturn;
		}
		
		private function stopTransition(item:Object):void {
			if (item is Array) {
				for (var i:int=0; i<item.length; i++) {
					var arrayTween:TweenMax = item as TweenMax;
					arrayTween.pause();
				}
			}
			else {
				var singleTween:TweenMax = item as TweenMax;
				singleTween.pause();
			}
		} 

		private function stopAllTransitions():void {
			TweenMax.pauseAll();
		} 
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(item:Object, id:String = null, transition:TransitionVO = null):Object {
			return executeTransition(item, id, transition);
		}
		
		public function stop(item:Object):void {
			stopTransition(item);
		}
		
		public function stopAll():void {
			stopAllTransitions();
		}
		
	}
}
