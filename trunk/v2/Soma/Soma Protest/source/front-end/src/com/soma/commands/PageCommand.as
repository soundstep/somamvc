package com.soma.commands {
	import com.soma.Soma;
	import com.soma.control.CairngormEvent;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.ICommand;	

	/**
     * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0<br/>
     * <b>Actionscript version:</b> 3.0</p>
     * <p><b>Copyright:</b></p>
     * <p>The contents of this file are subject to the Mozilla Public License<br />
     * Version 1.1 (the "License"); you may not use this file except in compliance<br />
     * with the License. You may obtain a copy of the License at<br /></p>
     * 
     * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>
     * 
     * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />
     * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />
     * See the License for the specific language governing rights and<br />
     * limitations under the License.<br /></p>
     * 
     * <p>The Original Code is Soma.<br />
     * The Initial Developer of the Original Code is Romuald Quantin.<br />
     * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>
     * 
     * <p><b>Usage:</b><br/>
     * PageCommand is executed by the SomaController instance and can be used to command the PageManager instance to display a page.<br/><br/>
     * Some commands are internally used in the PageManager and shouldn't be used by the user.<br/><br/>
     * Here is the command to show a page, the parameter should the ID of the page (id attribute in the XML Site Definition):
     * <listing version="3.0">new PageEvent(PageEvent.SHOW, "myPageID").dispatch();</listing>
     * <br/><br/>
     * The command to show an external page is:<br/><br/>
     * <listing version="3.0">new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, null, "http://www.soundstep.com/").dispatch();</listing>
     * <listing version="3.0">new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, myPage.&#64;id, myPage.&#64;externalLink).dispatch();</listing>
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.PageEvent PageEvent
     * @see com.soma.model.PageManager PageManager
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
		
		/** Creates a PageCommand instance */
		public function PageCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Executes a command.
		 * @param event Cairngorm event.
		 */
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case PageEvent.SHOW:
					Soma.getInstance().page.show(PageEvent(event).id);
					break;
				case PageEvent.SHOW_EXTERNAL_LINK:
					Soma.getInstance().page.showExternalLink(PageEvent(event).externalLink);
					break;
				case PageEvent.TRANSITION_IN_COMPLETE:
					if (Soma.getInstance().ui != null && !Soma.getInstance().page.isRemoving) Soma.getInstance().page.showPages(PageEvent(event));
					break;
				case PageEvent.TRANSITION_OUT_COMPLETE:
					if (Soma.getInstance().ui != null) Soma.getInstance().page.removePages(PageEvent(event));
					break;
			}
		}
	}
}
