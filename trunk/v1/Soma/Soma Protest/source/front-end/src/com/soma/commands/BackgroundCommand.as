package com.soma.commands {
	
	import com.soma.events.BackgroundEvent;	
	import com.soma.control.CairngormEvent;
	import com.soma.interfaces.ICommand;
	import com.soma.Soma;
	
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
	
	public class BackgroundCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BackgroundCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case BackgroundEvent.SHOW:
					Soma.getInstance().background.show(BackgroundEvent(event).backgroundName);
					break;
				case BackgroundEvent.HIDE:
					Soma.getInstance().background.hide();
					break;
			}
		}
		
	}
}
