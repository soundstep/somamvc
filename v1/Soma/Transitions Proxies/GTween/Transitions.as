package com.YOURPACKAGE {
	
	import com.soundstep.utils.Easing;	
	import flash.geom.ColorTransform;	
	import com.gskinner.motion.MultiTween;	
	import com.gskinner.motion.GTweenFilter;	
	import flash.utils.Dictionary;	
	import com.gskinner.motion.GTween;	
	import com.soma.Soma;	
	import com.soma.interfaces.ITransition;	
	import com.soma.model.TransitionManager;	
	import com.soma.vo.TransitionVO;import flash.utils.describeType;	
	
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
		
		private var listTweenProperties:Dictionary;
		
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
			GTween.defaultEase = Easing.ExpoOut;
			Transitions.TIME_ON = true;
			Transitions.DELAY_ON = true;
			Transitions.GLOBAL_TIME = 0;
			Transitions.GLOBAL_DELAY = 0;
		}
		
		private function setTweenProperties():void {
			listTweenProperties = new Dictionary();
			var list:XMLList = describeType(GTween)..*.((name() == "variable") || (name() == "accessor" && attribute("access") == "readwrite"));
			for each(var prop:XML in list) {
				listTweenProperties[String(prop.@name)] = String(prop.@name);
			}
			var listFilter:XMLList = describeType(GTweenFilter)..*.((name() == "variable") || (name() == "accessor" && attribute("access") == "readwrite"));
			for each(var propFilter:XML in listFilter) {
				listTweenProperties[String(propFilter.@name)] = String(propFilter.@name);
			}
			listTweenProperties["activateListener"] = "activateListener";
			listTweenProperties["initListener"] = "initListener";			listTweenProperties["completeListener"] = "completeListener";			listTweenProperties["progressListener"] = "progressListener";			listTweenProperties["changeListener"] = "changeListener";		}
		
		private function executeTransition(item:Object, id:String = null, transition:TransitionVO = null):Object {
			// build to work with GTween, the framework use the following properties
			// if you need to changes them for another Tween library:
			// _autoAlpha = 0 - 1, set visible to true or false after/before the tween
			// _color = hex, used in BasicMenuItem
			// onComplete = Function executed at the end of the tween
			if (listTweenProperties == null) setTweenProperties();
			var tran:TransitionVO = (id != null) ? Soma.getInstance().transition.getTransition(id) : transition;
			var prop:Object = {};
			var tweenProp:Object = {};
			var time:Number;
			var isTweenFilter:Boolean = false;
			var hasColorTween:Boolean = false;
			for (var s:String in tran.vars) {
				if (s == "filterIndex") isTweenFilter = true; // wether we should use GTween or GTweenFilter 
				switch (s) {
					case "time":
						time = tran.vars[s];
						break;
					case "_autoAlpha":
						tweenProp["_autoHide"] = Boolean(tran.vars[s]);
						if (tweenProp["_autoHide"]) prop['alpha'] = 1;
						else prop['alpha'] = 0;
						break;
					case "onComplete":
						tweenProp["completeListener"] = tran.vars[s];						break;
					case "_color":
						hasColorTween = true;
						tweenProp["autoPlay"] = false;
						break;
					default:
						if (listTweenProperties[s] != undefined) {
							tweenProp[s] = tran.vars[s];
						}
						else {
							prop[s] = tran.vars[s];
						}
						break;
				}
			}
			time = (tran.vars['time']!= null && Transitions.TIME_ON) ? tran.vars['time'] : Transitions.GLOBAL_TIME;
			tweenProp['delay'] = (tran.vars['delay']!= null && Transitions.DELAY_ON) ? tran.vars['delay'] : Transitions.GLOBAL_DELAY;
			var objReturn:Object;
			if (item is Array) {
				// array tween
				return new MultiTween(item as Array, prop, new GTween(null, time, null, tweenProp));
			}
			else {
				if (isTweenFilter) objReturn = new GTweenFilter(item, time, prop, tweenProp);
				else {
					// normal tween
					if (getLength(prop) > 0) objReturn = new GTween(item, time, prop, tweenProp);
					// tween color
					if (hasColorTween) {
						var color:ColorTransform = new ColorTransform();
						color.color = tran.vars['_color'];
						var colorProp:Object = {
							alphaOffset:color.alphaOffset,
							redOffset:color.redOffset,
							greenOffset:color.greenOffset,
							blueOffset:color.blueOffset,
							redMultiplier:color.redMultiplier,
							greenMultiplier:color.greenMultiplier,
							blueMultiplier:color.blueMultiplier,
							alphaMultiplier: color.alphaMultiplier
						};
						var colTrans:GTween = new GTween(item['transform'].colorTransform.color, time, colorProp, tweenProp);
						colTrans.setAssignment(item['transform'], "colorTransform");
						if (objReturn == null) {
							objReturn = colTrans;
							colTrans.play();
						}
						else {
							var tween:GTween = objReturn as GTween;
							tween.addChild(colTrans, GTween.DURATION);
							tween.play();
						}
					}
				}
			}
			return objReturn; 
		}
		
		private function getLength(obj:Object):Number {
			var count:Number = 0;
			for (var i:String in obj) {
				i;
				count++;
			}
			return count;
		}

		private function stopTransition(item:Object):void {
			if (item is Array) {
				for (var i:int=0; i<item.length; i++) {
					var arrayTween:GTween = item as GTween;
					arrayTween.paused = true;
				}
			}
			else {
				var singleTween:GTween = item as GTween;
				singleTween.paused = true;
			}
		} 

		private function stopAllTransitions():void {
			GTween.pauseAll = true;
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
