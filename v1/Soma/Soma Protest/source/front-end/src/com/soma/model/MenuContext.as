package com.soma.model {
	
	import com.soma.events.MenuEvent;	
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	import com.soma.Soma;	
	import com.soma.events.PageEvent;

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
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function MenuContext() {
			if (cm) throw new Error("Context is Singleton");
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
				new PageEvent(PageEvent.SHOW_PAGE, id).dispatch();
				new MenuEvent(MenuEvent.FORCE_OPEN_MENU, id).dispatch();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		static public function start():void {
			buildMenu();
		}
		
	}
	
}