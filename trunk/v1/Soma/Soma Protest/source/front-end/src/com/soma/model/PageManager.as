package com.soma.model {
	
	import com.soma.Soma;
	import flash.net.URLRequest;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import com.soma.events.MenuEvent;	
	import com.soma.view.Page;
	import com.soma.view.PageExternal;
	import com.soma.events.PageEvent;
	import com.soma.events.BackgroundEvent;
	import flash.display.Sprite;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.net.navigateToURL;

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
	
	public class PageManager {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------

		private var _pages:Sprite;
		private var _targetPageID:String;
		private var _targetPageType:String;
		private var _targetPageDepth:int;
		private var _currentPage:Page;
		private var _pageShow:Array;
		private var _pageRemove:Array;
		private var _byPassSetAddress:Boolean = false;
		private var _actualURL:String = "";
		private var _dispatchExcludedPage:String = "";
		private var _dispatchExcludedPageParent:String = "";
		private var _isRemoving:Boolean;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageManager() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_pages = new Sprite();
			_pages.name = "pages";
			_pageShow = [];
			Soma.getInstance().container.addChild(_pages);
		}
		
		private function displayPage():void {
			try {
				var pageID:String = _pageShow[0];
				var pageType:String = getPageType(pageID);
				var pageDepth:int = getPageDepth(pageID);
				showBackground(pageID);
				var page:Page;
				if (isExternalPage(pageID)) {
					page = new PageExternal(pageID);
				}
				else {
					var PageClass:Class = Soma.getInstance().config.getClass(pageType);
					page = new PageClass();
				}
				_currentPage = page;
				page.id = pageID;
				page.name = pageID;
				page.type = pageType;
				page.depth = pageDepth;
				_pages.addChild(page);
				_pageShow.splice(0, 1);
				// excluded page
				if (_dispatchExcludedPage != "") {
					if (pageID == getParentNonExcluded(_dispatchExcludedPage)) {
						new PageEvent(PageEvent.GET_EXCLUDED_PAGE, _dispatchExcludedPage).dispatch();
						_dispatchExcludedPage = "";
					}
				}
				// excluded page parent
				if (_dispatchExcludedPageParent != "") {
					if (pageID == _dispatchExcludedPageParent) {
						new PageEvent(PageEvent.GET_EXCLUDED_PAGE_PARENT, _dispatchExcludedPageParent).dispatch();
						_dispatchExcludedPageParent = "";
					}
				}
			}
			catch (err:Error) {
				throw new CairngormError(CairngormMessage.PAGE_CLASS_NOT_FOUND, _targetPageType);
			};
		}
		
		private function showBackground(id:String):void {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			var bg:String = target.@background;
			if (bg == "") {
				process(target.parent());
				function process(x:XML):void {
					if (x.name() == "page") {
						var bg:String = x.@background;
						if (bg == "") process(x.parent());
						else new BackgroundEvent(BackgroundEvent.SHOW, bg).dispatch();
					}
				}
			}
			else new BackgroundEvent(BackgroundEvent.SHOW, bg).dispatch();
		}
		
		public function isPageChild(targetID:String, refID:String):Boolean {
			var ref:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == refID);
			var target:XMLList = ref..*.(name() == "page" && @id == targetID);
			if (target.toXMLString() != "") return true;
			return false;
		}
		
		private function checkPageToShow(arr:Array, currentPageID:Page = null):Array {
			// remove the beginning of the list
			if (currentPage != null) {
				for (var i:uint=0; i<arr.length; i++) {
					if (arr[i] == currentPageID) {
						arr.splice(0, i+1);
						break;
					}
				}
			}
			// check depth
			for (var j:uint=0; j<arr.length; j++) {
				if (j < arr.length-1) {
					if (getPageDepth(arr[j]) >= getPageDepth(arr[j+1])) {
						arr.splice(j, 1);
						j--;
					}
				}
			}
			return arr;
		}
		
		public function getUrlFriendly(id:String):String {
			var list:Array = [];
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			if (target.toXMLString() == "") trace("Error: Page not found in PageManager.getURLFriendly - " + id);
			list.push(target.@urlfriendly);
			if (target.parent() != null) process(target.parent());
			function process(x:XML):void {
				if (x.name() == "page") {
					list.push(x.@urlfriendly);
					process(x.parent());
				}
			}
			list.reverse();
			return "/" + list.join("/") + "/";
		}
		
		public function getTitle(id:String):String {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			return target['title'];
		}
			
		private function getPageShow(id:String, currentPage:Page = null):Array {
			var list:Array = [];
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			list.push(target.@id);
			process(target.parent());
			function process(x:XML):void {
				if (x.name() == "page") {
					if (_pages.getChildByName(x.@id) == null) {
						list.push(x.@id);
						process(x.parent());
					}
				}
			}
			list.reverse();
			list = checkPageToShow(list, currentPage);
			return list;
		}
			
		private function isSuperiorOrEqualDepth(depth:int, arr:Array):Boolean {
			for (var j:uint=0; j<arr.length; j++) {
				if (depth >= getPageDepth(arr[j])) return true;
			}
			return false;
		}
		
		private function startPageProcess(e:PageEvent):void {
			_dispatchExcludedPage = "";
			_dispatchExcludedPageParent = "";
			var id:String = e.pageID;
			// test if the page has children excluded 
			if (hasExcludedChildren(id)) {
				if (_currentPage != null && _currentPage.id == id) {
					// displayed
					new PageEvent(PageEvent.GET_EXCLUDED_PAGE_PARENT, id).dispatch();
				}
				else {
					// not displayed
					_dispatchExcludedPageParent = id;
				}
			}
			// test if the page is excluded 
			if (isExcluded(id)) {
				setAddress(id);
				if (_currentPage != null && _currentPage.id == getParentNonExcluded(id)) {
					// current page is parent non excluded
					new PageEvent(PageEvent.GET_EXCLUDED_PAGE, id).dispatch();
					return;
				}
				else {
					// parent non excluded is not displayed
					_dispatchExcludedPage = id;
					_byPassSetAddress = true;
					id = getParentNonExcluded(id);
				}
			}
			_targetPageID = id;
			_targetPageType = getPageType(id);
			_targetPageDepth = getPageDepth(id);
			_pageShow = getPageShow(_targetPageID, _currentPage);
			if (_currentPage != null) {
				if (!isPageChild(_targetPageID, _currentPage.id) || isSuperiorOrEqualDepth(_currentPage.depth, _pageShow)) {
					_pageRemove = [];
					for (var i:int=_pages.numChildren-1; i>=0; i--) {
						var pageID:String = Page(_pages.getChildAt(i)).id;
						// the page called has been found in the display list: we stop the process
						if (pageID == _targetPageID) {
							_currentPage = Page(_pages.getChildAt(i));
							break;
						}
						else if (isPageChild(_targetPageID, pageID) && Page(_pages.getChildAt(i)).depth < getPageDepth(_pageShow[0])) {
							_currentPage = Page(_pages.getChildAt(i));
							break;
						}
						else {
							if (Page(_pages.getChildAt(i)).depth >= getPageDepth(_targetPageID) || !isPageChild(pageID, _targetPageID)) {
								_pageRemove.push(_pages.getChildAt(i));
							}
						}
					}
					removePages();
				}
				else {
					showPages();
				}
			}
			else {
				showPages();
			}
			if (!_byPassSetAddress) setAddress(_targetPageID);
			_byPassSetAddress = false;
		}
				
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function setAddress(name:String):void {
			var curLabel:String = "";
			var bTitle:String = "";
			curLabel = getUrlFriendly(name);
			bTitle = Soma.getInstance().config.siteName + " | ";
			var titleNode:String = getTitle(name);
			bTitle = (titleNode == "") ? bTitle + name : bTitle + titleNode;
			if (_actualURL != curLabel) {
				if (curLabel != "") {
					_actualURL = curLabel;
					var value:String = (Soma.getInstance().languageEnabled) ? ("/" + Soma.getInstance().currentLanguage + _actualURL) : _actualURL;
					SWFAddress.setValue(value.toLowerCase());
					SWFAddress.setTitle(bTitle);
				}
			}
		}
		
		public function handleAddress(e:SWFAddressEvent = null):void {
			var val:String = SWFAddress.getValue();
			if (val != "/") {
				//remove language
				var valToProcess:String;
				if (Soma.getInstance().languageEnabled) {
					if (val.substr(0,1) == "/") valToProcess = val.substring(1, val.length); // remove first slash
					valToProcess = valToProcess.substring(valToProcess.indexOf("/"), valToProcess.length);
				}
				else valToProcess = val;
				if (valToProcess != _actualURL.toLowerCase()) {
					if (valToProcess.substr(valToProcess.length-1, valToProcess.length)!="/") valToProcess += "/";
					valToProcess = valToProcess.substr(1, valToProcess.length-1);
					var target:String = getPageID(valToProcess);
					if (target != null) {
						var excludedPage:String = "";
						new MenuEvent(MenuEvent.FORCE_OPEN_MENU, target).dispatch();
						if (isExcluded(target)) {
							excludedPage = target;
							setAddress(excludedPage);
						}
						if (_currentPage == null) new PageEvent(PageEvent.SHOW_PAGE, target).dispatch();
						else show(target);
						if (excludedPage != "") {
							if (target == _currentPage.id) {
								new PageEvent(PageEvent.GET_EXCLUDED_PAGE, excludedPage).dispatch();
							}
							else {
								_dispatchExcludedPage = excludedPage;
							}
						}
					}
					else {
						// page not found 
						new PageEvent(PageEvent.SHOW_PAGE, Soma.getInstance().config.defaultPage).dispatch();
						new MenuEvent(MenuEvent.FORCE_OPEN_MENU, Soma.getInstance().config.defaultPage).dispatch();
					}
				}
			}
			else {
				// first default page
				new PageEvent(PageEvent.SHOW_PAGE, Soma.getInstance().config.defaultPage).dispatch();
				new MenuEvent(MenuEvent.FORCE_OPEN_MENU, Soma.getInstance().config.defaultPage).dispatch();
			}
		}
		
		public function isExcluded(idPage:String):Boolean {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == idPage);
			if (String(target.attribute('exclude')) == "true") return true;
			else return false;
		}
		
		public function hasExcludedChildren(idPage:String):Boolean {
			if (idPage == null || idPage == "") return false;
			var target:XML = Soma.getInstance().content.data..*.(name() == "page" && @id == idPage)[0];
			var excluded:XMLList = target.*.(name() == "page" && attribute('exclude') == "true");
			if (excluded.length() > 0) return true;
			else return false;
		}
		
		public function getParentNonExcluded(idPage:String):String {
			var pageNonExcluded:String = "";
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == idPage);
			process(target.parent());
			function process(x:XML):void {
				if (x.name() == "page") {
					if (isExcluded(x.@id)) process(x.parent());
					else pageNonExcluded = x.@id;
				}
			}
			return pageNonExcluded;
		}

		public function start():void {
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleAddress);
		}
		
		public function showPages(e:PageEvent = null):void {
//			trace("*** show pages method: ", _pageShow)
			if (_pageShow.length > 0 && _pages.getChildByName(_pageShow[0]) == null) displayPage();
		}
		
		public function removePages(e:PageEvent = null):void {
//			trace("*** remove pages method: ", _pageRemove)
//			trace("*** still need to show: ", _pageShow)
//			trace("*** current page ID: ", _currentPage.id)
//			trace("*** target page ID: ", _targetPageID)
//			trace("*** is removing: ", _isRemoving)
			if (e != null) {
				var p:Page = Page(_pages.getChildByName(e.pageID));
				_pages.removeChild(p);
				p = null;
			}
			if (_pageRemove.length > 0) {
				_isRemoving = true;
				var pageToRemove:Page = _pageRemove[0];
				_pageRemove.splice(0, 1);
				pageToRemove.remove();
			}
			else {
				//if (_currentPage.id != _targetPageID) {
				_isRemoving = false;
				showPages();
			}
		}
		
		public function getPageType(id:String):String {
			return Soma.getInstance().content.data..*.(name() == "page" && @id == id).@type;
		}
		
		public function getPageID(urlFriendly:String):String {
			var arr:Array = urlFriendly.split("/");
			var cursor:int = arr.length-2;
			var list:XMLList = Soma.getInstance().content.data..*.(name() == "page" && String(attribute('urlfriendly')).toLowerCase() == String(arr[cursor]).toLowerCase());
			if (list.length() == 1) {
				// only one urlfriendly found
				var id:String = list[0].@id;
				if (id != "") return id;
			}
			else {
				// check urlfriendly recursively
				if (list.length() > 1) {
					for (var i:int=list.length()-1; i>=0; i--) {
						var count:int = cursor;
						var targetID:String;
						if (list[i].parent().name() != "page" && cursor == 0) return list[i].@id;
						else process(list[i].parent());
						function process(x:XML):void {
							count--;
							if (x.name() == "page") {
								if(String(x.@urlfriendly).toLowerCase() == String(arr[count]).toLowerCase()) {
									// parent correct
									if (count == 0) {
										// id found
										targetID = list[i].@id;
									}
									else process(x.parent());
								}
							}
							
						}
						if (targetID != null) {
							return targetID;
						}
					}
				}
			}
			return null;
		}
		
		public function getPageDepth(id:String):int {
			var depth:String = Soma.getInstance().content.data..*.(name() == "page" && @id == id).@depth;
			if (depth != "") return int(depth);
			else return 0;
		}
		
		public function isExternalPage(id:String):Boolean {
			var external:String = Soma.getInstance().content.data..*.(name() == "page" && @id == id).@external;
			if (external == "true") return true;
			return false;
		}
		
		public function show(id:String):void {
			var event:PageEvent = new PageEvent(PageEvent.PAGE_STARTED, id, "", true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				startPageProcess(event);
			}
		}
		
		public function showExternalLink(externalLink:String):void {
			var request:URLRequest = new URLRequest(externalLink);
			navigateToURL(request, "_blank");
		}
		
		public function get currentPage():Page {
			return _currentPage;
		}
		
		public function get currentPageID():String {
			return _currentPage.id;
		}
		
		public function get isRemoving():Boolean {
			return _isRemoving;
		}
		
		public function get pages():Sprite {
			return _pages;
		}
	}
}