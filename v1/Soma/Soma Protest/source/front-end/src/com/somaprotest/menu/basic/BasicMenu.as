package com.somaprotest.menu.basic {
	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	import com.soma.Soma;
	import com.soma.view.Menu;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IMenu;	
	import com.soma.tween.SomaTween;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

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
	
	public class BasicMenu extends Menu implements IMenu {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var countLevel:uint;
		private var dist:Number;
		private var current:BasicMenuItem;
		private var autoOpen:Boolean;
		private var autoOpenArray:Array;
		private var _buildMenuParams:Array;
		private var _timer:Timer;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var xml:XML;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicMenu() {
			name = "basicMenu";
			x = 20;
			y = 20;
			alpha = 0;
			autoOpenArray = [];
			xml = Soma.getInstance().content.data;
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init, false);
			autoOpen = false;
			_buildMenuParams = [Soma.getInstance().content.data.children()];
			buildMenu();
			showMenu();
		}
		
		private function clickMenuHandler(e:MouseEvent):void {
			var m:BasicMenuItem = BasicMenuItem(e.currentTarget);
			if (m.externalLink != null) {
				new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, m.name, m.externalLink).dispatch();
			}
			else clickMenu(m);
		}
		
		private function clickMenu(m:BasicMenuItem):void {
			if (current != null && current != m) removeSubmenu(m);
			current = m;
			deactivateItems(m);
			m.active = true;
			if (m.parent.getChildByName("submenu") == null) openMenu(m);
			if (m.type != "" && !autoOpen) {
				new PageEvent(PageEvent.SHOW_PAGE, m.id).dispatch();
			}
		}
		
		private function openMenu(menuItem:BasicMenuItem):void {
			dist = 0;
			processParent(Sprite(menuItem.parent));
			function processParent(m:Sprite):void {
				var holderName:String = m.name;
				var sel:Boolean = false;
				for (var i:uint = 0; i < m.numChildren; i++) {
					if (m.getChildAt(i).name != "submenu") {
						var item:BasicMenuItem =  BasicMenuItem(m.getChildAt(i));
						item.posY = item.initY;
						if (item.active) {
							sel = true;
							dist += item.height * item.children.length();
						}
						else if (sel) item.posY = item.initY + dist;
						SomaTween.start(item, null, {time:.3, y:item.posY});
					}
				}
				if (holderName != "basicMenu") processParent(Sprite(m.parent));
			}
			_buildMenuParams = [menuItem.children, menuItem];
			_timer = new Timer(300, 1);
			_timer.addEventListener(TimerEvent.TIMER, buildMenu);
			_timer.start();
		}

		private function getLevel(m:Sprite):uint {
			countLevel = 0;
			processParent(m);
			function processParent(m:Sprite):void {
				if (m.parent.getChildByName("submenu") != null) {
					countLevel++;
					if (Sprite(m.parent.parent.getChildByName("submenu")) != null) processParent(Sprite(m.parent.parent.getChildByName("submenu")));
				}
			}
			return countLevel;
		}

		private function deactivateItems(m:BasicMenuItem):void {
			for (var i:uint = 0; i < m.parent.numChildren; i++) {
				if (m.parent.getChildAt(i) is BasicMenuItem) {
					if (BasicMenuItem(m.parent.getChildAt(i)) != m) BasicMenuItem(m.parent.getChildAt(i)).active = false;
				}
			}
		}
		
		private function buildMenu(e:Event = null):void {
			var items:XMLList = _buildMenuParams[0];
			var menuItem:BasicMenuItem = _buildMenuParams[1];
			var arr:Array = [];
			var subMenu:Sprite;
			if (menuItem == null) {
				subMenu = this;
			}
			else {
				subMenu = new Sprite();
				subMenu.name = "submenu";
				subMenu.y = Math.round(menuItem.y + menuItem.height);
				menuItem.parent.addChild(subMenu);
			}
			var posX:Number = getLevel(subMenu) * 7;
			var posY:Number = 0;
			for each (var item:XML in items) {
				if (item.name() == "page") {
					var m:BasicMenuItem = new BasicMenuItem();
					m.alpha = 0;
					m.externalLink = (item.hasOwnProperty("@externalLink")) ? item.@externalLink : null;
					m.id = item.@id;
					m.text = item['title'];
					m.name = item.@id;
					m.type = item.@type;
					m.children = item.children().(name() == "page" && (!hasOwnProperty("@exclude") || !Soma.getInstance().page.isExcluded(@id)));
					m.x = Math.round(posX);
					m.y = Math.round(posY);
					m.initY = m.y;
					m.posY = m.y;
					subMenu.addChild(m);
					posY = Math.round(m.y + m.height);
					m.addEventListener(MouseEvent.CLICK, clickMenuHandler, false, 0, true);
					m.buttonMode = true;
					m.mouseChildren = false;
					arr.push(m);
				}
			}
			for (var i:int=0; i<arr.length; i++) SomaTween.start(arr[i], null, {time:.5, alpha:.8, delay:i*.07});
			if (autoOpen) SomaTween.start(this, null, {time:0, delay:(i*.07)+.5, onComplete:autoOpenMenu});
		}
		
		private function showMenu():void {
			SomaTween.start(this, null, {time:1, alpha:1});
		}
		
		private function removeSubmenu(m:BasicMenuItem):void {
			if (m.parent.getChildByName("submenu") != null) m.parent.removeChild(m.parent.getChildByName("submenu"));
		}
		
		private function autoOpenMenu():void {
			if (autoOpenArray.length > 0) {
				var sub:Sprite = (xml..*.(name() == "page" && @id == autoOpenArray[0]).parent().name() == "site") ? this : Sprite(current.parent.getChildByName("submenu"));
				var item:BasicMenuItem = BasicMenuItem(sub.getChildByName(autoOpenArray[0]));
				clickMenu(item);
				autoOpenArray.splice(0, 1);
				if (autoOpenArray.length == 0) autoOpen = false;
			}
			else autoOpen = false;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function forceMenu(id:String):void {
			if (autoOpenArray.length > 0) {
				SomaTween.stop(this);
				autoOpen = false;
				autoOpenArray = [];
			}
			if (Soma.getInstance().page.isExcluded(id)) id = Soma.getInstance().page.getParentNonExcluded(id);
			if (current != null && current.name == id) return;
			// reset position first items
			for (var i:uint = 0; i < numChildren; i++) {
				if (getChildAt(i).name != "submenu") {
					var item:BasicMenuItem = BasicMenuItem(getChildAt(i));
					item.y = item.initY;
				}
			}
			autoOpen = true;
			autoOpenArray = [];
			if (getChildByName("submenu")) removeChild(getChildByName("submenu"));
			processParent(id);
			function processParent(n:String):void {
				var pageXML:XMLList = xml..*.(name() == "page" && @id == n);
				var pageName:String = pageXML.@id;
				autoOpenArray.push(pageName);
				if (pageXML.parent().name() != "site") processParent(pageXML.parent().@id);
			}
			autoOpenArray.reverse();
			autoOpenMenu();
		}
		
		override public function remove():void {
			super.remove();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
	}
	
}
