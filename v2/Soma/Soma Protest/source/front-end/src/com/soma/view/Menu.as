package com.soma.view {
	import com.soma.interfaces.IMenu;
	
	import flash.display.MovieClip;	

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
     * The Menu class view must be extended to build your own custom menu, it is a requirement to be able to add the menu to the MenuManager (as well as implement IMenu).
     * <listing version="3.0">
     * Soma.getInstance().registerClass(MySecondMenuClass);
     * mySprite.addChild(Soma.getInstance().menu.add("MySecondMenuClass"));
	 * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.model.MenuManager MenuManager
     * @see com.soma.events.MenuEvent MenuEvent
     * @see com.soma.model.PageManager PageManager
     */
	
	public class Menu extends MovieClip implements IMenu {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a Menu instance, the Menu class should be extended to create your own menu. */
		public function Menu() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * This method should be overridden and will receive information by the PageManager regarding about the state of the application (for example a change in the URL).
		 * You can update the state of your menu from this point, the id received is the attribute id of a page node in the XML Site Definition.
		 * @param id A String (id of a page).
		 */
		public function openMenu(id:String):void {
			
		}
		
	}
	
}