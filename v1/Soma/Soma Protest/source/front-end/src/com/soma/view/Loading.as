package com.soma.view {
	
	import com.soma.interfaces.IComplete;	
	import com.soma.interfaces.ILoading;	
	import com.soma.tween.SomaTween;	
	import com.soma.model.TransitionManager;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import flash.display.MovieClip;
	import com.soma.interfaces.IDisplayable;

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
	
	public class Loading extends MovieClip implements IDisplayable, ILoading {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Loading() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function init():void {
			alpha = 0;
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function progress(e:QueueLoaderEvent):void {
			
		}

		public function show(complete:IComplete = null):void {
			SomaTween.start(this, TransitionManager.SHOW);
		}

		public function hide(complete:IComplete = null):void {
			SomaTween.start(this, TransitionManager.HIDE);
		}
		
	}
	
}
