package com.soma.interfaces {
	
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
     * A menu class that will be used by Soma must extend com.soma.view.Menu and implements IMenu.
     * The only requirement is an openMenu method that will be called by the PageManager in some case (for example a URL change).
     * The id parameter received is the id attribute of an XML page node, you can use this id to update the state  of your custom menu class.<br/><br/>
     * When a menu class is registered in the Config file, the openMenu method can also be called using a Soma command:
     * <listing version="3.0">
     * new MenuEvent(MenuEvent.OPEN_MENU, "myPageID").dispatch();
     * </listing>
     * </p>
     * 
     * @see com.soma.view.Menu Menu
     * @see com.soma.model.MenuManager MenuManager
     * @see com.soma.events.MenuEvent MenuEvent
     * @see com.soma.interfaces.IConfig IConfig
     */

	public interface IMenu {
		
		/**
		 * Called by the PageManager or the MenuEvent.OPEN_MENU command to update a menu state.
		 * @param id Attribute id of an XML page node.
		 */
		function openMenu(id:String):void;
		
	}

}