package com.soma.model {
	import com.soma.Soma;
	import com.soma.view.Menu;
	
	import flash.utils.Dictionary;		

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
     * The MenuManager allows you to easily register and retrieve your menu class instances for later use.
     * The process for the Main Menu registered in the Config file (Soma.getInstance().config.menuClassName) is automatically done by Soma.
     * The global menu manager instance is accessible using:
     * <listing version="3.0">Soma.getInstance().menu</listing>
     * The main menu registered in the config file can retrieved that way:
     * <listing version="3.0">Soma.getInstance().menu.getMainMenu()</listing>
     * You must cast the Menu instance to your own class if you want to use your own properties and methods:
     * <listing version="3.0">
     * var menu:MyOwnMainMenu = Soma.getInstance().menu.getMainMenu() as MyOwnMainMenu;
     * menu.myMethod();
     * </listing>
     * Here is how to register a second menu (you must at least extend com.soma.view.Menu and, for the main menu, implement com.soma.interfaces.Imenu):
     * <listing version="3.0">
     * Soma.getInstance().registerClass(MySecondMenuClass);
     * mySprite.addChild(Soma.getInstance().menu.add("MySecondMenuClass"));
	 * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.view.Menu Menu
     * @see com.soma.interfaces.IMenu IMenu
     * @see com.soma.events.MenuEvent MenuEvent
     * @see com.soma.model.PageManager PageManager
     */
	
	public class MenuManager {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _menus:Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a MenuManager instance, the global MenuManager instance is accessible using Soma.getInstance().menu.
		 */
		public function MenuManager() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		protected function init():void {
			_menus = new Dictionary();
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Adds a menu to the MenuManager using its class name. The menu class must registered first in Soma: Soma.getInstance().registerClass(MyMenu).
		 * @param menuClass Name of the menu class (for example, the name for a com.project.menu.MyMenu class is MyMenu).
		 * @return A Menu class instance (Menu should be the super class of your own menu).
		 */
		public function add(menuClass:String):Menu {
			if (_menus[menuClass] == null) {
				var MenuClass:Class = Soma.getInstance().getClass(menuClass);
				_menus[menuClass] = new MenuClass();
			}
			return _menus[menuClass];
		}
		
		/**
		 * Get a registered menu using its class name.
		 * @param menuClass Class name of the menu.
		 * @return A Menu instance (Menu should be the super class of your own menu).
		 */
		public function getMenu(menuClass:String):Menu {
			return _menus[menuClass];
		}
		
		/**
		 * Get all the menus.
		 * @return A Dictionary.
		 */
		public function getMenus():Dictionary {
			return _menus;
		}
		
		/**
		 * Get the main menu registered (the main menu class is the one registered in the Config class: Soma.getInstance().config.menuClassName).
		 * @return A Menu instance (Menu should be the super class of your own menu).
		 */
		public function getMainMenu():Menu {
			return _menus[Soma.getInstance().config.menuClassName];
		}
		
	}
}