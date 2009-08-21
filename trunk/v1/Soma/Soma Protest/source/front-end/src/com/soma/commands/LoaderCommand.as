package com.soma.commands {
	
	import com.soma.events.LoaderEvent;	
	import com.soma.control.CairngormEvent;
	import com.soma.interfaces.ICommand;

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
	
	public class LoaderCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function LoaderCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case LoaderEvent.ADD_ITEM:
					LoaderEvent(event).loader.add(LoaderEvent(event).loaderItem);
					break;
				case LoaderEvent.START_LOADING:
					LoaderEvent(event).loader.start();
					break;
				case LoaderEvent.STOP_LOADING:
					LoaderEvent(event).loader.stop();
					break;
			}
		}
	}
}
