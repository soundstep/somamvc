package com.soma.commands {
	
	import com.soma.events.TemplateEvent;
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
	
	public class TemplateCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TemplateCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case TemplateEvent.TEMPLATE_DISPLAYED:
					TemplateEvent(event).page.templateDisplayed();
					break;
				case TemplateEvent.TEMPLATE_REMOVED:
					TemplateEvent(event).page.templateRemoved();
					break;
			}
		}
	}
}
