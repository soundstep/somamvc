package com.soma.commands {
	
	import com.soma.events.PageEvent;
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
	
	public class PageCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case PageEvent.SHOW_PAGE:
					Soma.getInstance().page.show(PageEvent(event).pageID);
					break;
				case PageEvent.PAGE_DISPLAYED:
					if (Soma.getInstance().ui != null && !Soma.getInstance().page.isRemoving) Soma.getInstance().page.showPages(PageEvent(event));
					break;
				case PageEvent.PAGE_REMOVED:
					if (Soma.getInstance().ui != null) Soma.getInstance().page.removePages(PageEvent(event));
					break;
				case PageEvent.SHOW_EXTERNAL_LINK:
					Soma.getInstance().page.showExternalLink(PageEvent(event).pageExternalLink);
					break;
			}
		}
	}
}
