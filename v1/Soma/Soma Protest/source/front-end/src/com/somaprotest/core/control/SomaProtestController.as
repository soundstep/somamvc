package com.somaprotest.core.control {
	import com.somaprotest.core.commands.AlertCommand;	
	import com.somaprotest.core.events.AlertEvent;	
	import com.soma.control.FrontController;		/**
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
	 
	public class SomaProtestController extends FrontController {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
				public function SomaProtestController() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public static function init():void {
			addCommand(AlertEvent.SHOW_ALERT, AlertCommand);
			addCommand(AlertEvent.HIDE_ALERT, AlertCommand);
		}
			}
}
