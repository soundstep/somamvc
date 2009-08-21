package com.soma.model {
	import com.soma.Soma;
	import com.soma.errors.CairngormError;
	import com.soma.errors.CairngormMessage;
	import com.soma.events.MenuEvent;
	import com.soma.events.PageEvent;

	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

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
     * The MenuContext class is a Singleton that is creating the right-click menu. The menu is built with the first level of pages from the XML Site Definition.<br/><br/>
     * The process can be disabled by setting the static variable MenuContext.CONTEXTUAL_MENU_ENABLED to false before Soma starts.
     * 
     * @see com.soma.Soma Soma
     */
	
	public class MenuContext {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var cm:MenuContext = new MenuContext();
		private static var contextMenu:ContextMenu;
		private static var externalLinks:Object;
		private static var pageID:Object;

		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Enable or disable the process to build the contextual menu (must be set before Soma starts). */
		public static var CONTEXTUAL_MENU_ENABLED:Boolean = true;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** MenuContext is not meant to be accessed or instantiated. */
		public function MenuContext() {
			if (cm) throw new CairngormError(CairngormMessage.UTILS_SINGLETON_INSTANTIATION_ERROR, this);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		static private function buildMenu():void {
			externalLinks = {};
			pageID = {};
			contextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			Soma.getInstance().ui.contextMenu = contextMenu;
			for each (var item:XML in Soma.getInstance().content.data['page']) {
				var itemContextMenu:ContextMenuItem;
				pageID[String(item['title'])] = item.@id;
				if (item.hasOwnProperty("@type")) {
					itemContextMenu = new ContextMenuItem(String(item['title']));
				}
				else if (item.hasOwnProperty("@externalLink")) {
					itemContextMenu = new ContextMenuItem(String(item['title']));
					externalLinks[String(item['title'])] = item.@externalLink;
				} 
				if (item.hasOwnProperty("@type") || item.hasOwnProperty("@externalLink")) {
					contextMenu.customItems.push(itemContextMenu);
					itemContextMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
				}
			}
		}
		
		static private function menuItemSelectHandler(event:ContextMenuEvent):void {
			var name:String = ContextMenuItem(event.target).caption;
			var id:String = pageID[name];
			if (externalLinks[name] != undefined) {
				var externalLink:String = externalLinks[name];
				new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, id, externalLink).dispatch();
			}
			else {
				new PageEvent(PageEvent.SHOW, id).dispatch();
				new MenuEvent(MenuEvent.OPEN_MENU, id).dispatch();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Build the contextual menu. */
		static public function start():void {
			if (CONTEXTUAL_MENU_ENABLED) buildMenu();
		}
		
	}
	
}