package com.soma.model {
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.soma.Soma;
	import com.soma.errors.CairngormError;
	import com.soma.errors.CairngormMessage;
	import com.soma.events.BackgroundEvent;
	import com.soma.events.MenuEvent;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IDisposable;
	import com.soma.view.Page;
	import com.soma.view.PageExternal;

	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getDefinitionByName;

	/**
     * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0.1<br/>
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
     * The PageManager is a big part in Soma and it is not the purpose of the documentation to explain all the options and how it is used by Soma. Instead you can visit the <a href="http://www.soundstep.com/somaprotest/www/#/page-system/" target="_blank">Soma Protest Page Sytem</a> page for more explanation.<br/><br/>
     * The PageManager role is instantiating and removing pages from the XML Site Definition as well as handling the deep-linking URL with the SWFAddress.
     * The first to thing remember is: The PageManager will instantiate Page classes using the String found in the type attribute of the page node (this page class must be registered in the config file using Soma.getInstance().registerClass(MyPageClass)).<br/><br/>
     * Here is an example of a page node:
     * <listing version="3.0">
&lt;page id="home_id" type="Home" urlfriendly="home"&gt;
    &lt;title&gt;&lt;![CDATA[Welcome]]&gt;&lt;/title&gt;
&lt;/page&gt;
     * </listing>
     * This page can be called using the Soma Command:
     * <listing version="3.0">
new PageEvent(PageEvent.SHOW, "home_id").dispatch();
     * </listing>
     * When the PageManager will receive a command to show a page, it will find out what pages have to be removed before showing (if there are depth attributes found), find the attribute type and instantiate the class that will match that name (the page class has to be registered: Soma.getInstance().registerClass(MyPageClass).<br/><br/>
     * The registration is important, the PageManager instantiates classes using String and getDefinitionByName and the classes needs to be imported by the compiler and that's the role of the registration.<br/><br/>
     * The only attribute required in the page node is the id. If there is no "type", no page will instantiated and if there is no "urlfriendly", the will not appear in the URL (note: the title node of a page is a requirement in the XML Site Definition).<br/><br/>
     * Four options attributes are available on the page node:
     * <ul>
     *     <li>exclude (true or false): make the page manager reacting with this page like a normal one, but without instantiate any class (it will dispatch a PageEvent.EXCLUDED and PageEvent.EXCLUDED_PARENT). It is useful to have animations and states in a page driven by the URL.</li>
     *     <li>external (true or false): make the page manager load a SWF file matching that name.</li>
     *     <li>movieclip (true or false): make the page manager instantiate a MovieClip from a Flash IDE library (or SWC)</li>
     *     <li>externalLink (URL): the page manager will open the url in a new browser window.</li>
     * </ul>
     * See the <a href="http://www.soundstep.com/somaprotest/www/#/page-system/" target="_blank">Soma Protest Page System</a> for more information.<br/><br/>
     * A page node can contain a content node (assets) that will be parsed, see the <a href="../view/Page.html">Page</a> documentation.
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.PageEvent PageEvent
     * @see com.soma.view.Page Page
     * @see com.soma.assets.ClassImport ClassImport
     */
	
	public class PageManager implements IDisposable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _started:Boolean;
		
		private var _container:Sprite;
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
		
		/** Enables the deep-linking, the URL is built with the urlfriendly attribute of a page node. */
		public static var DEEPLINKING_ENABLED:Boolean = true;
		/** Enables the PageManager instance to change the title of the browser, the title is built with the site name (Soma.getInstance().config.siteName) and the value of the title or the titleBrowser (priority on titleBrowser) node of a page node. */
		public static var TITLE_BROWSER_ENABLED:Boolean = false;

		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates an PageManager instance */
		public function PageManager() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_started = true;
			if (_container != null) dispose();
			_container = new Sprite();
			_container.name = "pages";
			_pageShow = [];
			Soma.getInstance().container.addChild(_container);
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
				else if (isMovieClipMode(pageID)) {
					var PageMovie:Class = getDefinitionByName(pageType) as Class;
					page = new PageMovie();
				}
				else if (pageType != "") {
					var PageClass:Class = Soma.getInstance().getClass(pageType);
					page = new PageClass();
				}
				if (page != null) {
					_currentPage = page;
					page.id = pageID;
					page.name = pageID;
					page.type = pageType;
					page.depth = pageDepth;
					_container.addChild(page);
					if (!isExternalPage(pageID)) {
						dispatchTransitionIn(page);
					}
				}
				_pageShow.splice(0, 1);
				// excluded page
				if (_dispatchExcludedPage != "") {
					if (pageID == getParentNonExcluded(_dispatchExcludedPage)) {
						new PageEvent(PageEvent.EXCLUDED, _dispatchExcludedPage).dispatch();
						_dispatchExcludedPage = "";
					}
				}
				// excluded page parent
				if (_dispatchExcludedPageParent != "") {
					if (pageID == _dispatchExcludedPageParent) {
						new PageEvent(PageEvent.EXCLUDED_PARENT, _dispatchExcludedPageParent).dispatch();
						_dispatchExcludedPageParent = "";
					}
				}
			}
			catch (err:Error) {
				if (err.errorID == 1007 && pageType != "") throw new CairngormError(CairngormMessage.PAGE_CLASS_NOT_FOUND, _targetPageType, err);
			};
		}
		
		private function dispatchTransitionIn(page:Page):void {
			var event:PageEvent = new PageEvent(PageEvent.TRANSITION_IN, page.id, "", true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				page.transitionIn();
			}
		}
		
		private function dispatchTransitionOut(page:Page):void {
			var event:PageEvent = new PageEvent(PageEvent.TRANSITION_OUT, page.id, "", true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				page.willBeRemoved = true;
				page.transitionOut();
			}
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
		
		private function isPageChild(targetID:String, refID:String):Boolean {
			var ref:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == refID);
			var target:XMLList = ref..*.(name() == "page" && @id == targetID);
			if (target.toXMLString() != "") return true;
			return false;
		}
		
		private function checkPageToShow(arr:Array, targetPage:Page = null):Array {
			// remove the beginning of the list
			if (currentPage != null) {
				for (var i:uint=0; i<arr.length; i++) {
					if (arr[i] == targetPage.id && !_isRemoving) {
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
		
		private function getPageShow(id:String, currentPage:Page = null):Array {
			var list:Array = [];
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			list.push(target.@id);
			process(target.parent());
			function process(x:XML):void {
				if (x.name() == "page") {
					if (_container.getChildByName(x.@id) == null) {
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
		
		private function getLandingPageID():String {
			var id:String = Soma.getInstance().config.landingPageID;
			if (id != null && id != "") {
				return id;
			}
			else {
				return Soma.getInstance().content.data.children().(name() == "page")[0].@id;
			}
		}
		
		private function getSiteName():String {
			var name:String = Soma.getInstance().config.siteName;
			if (name != null && name != "") {
				return name;
			}
			else {
				return "";
			}
		}
		
		private function startPageProcess(e:PageEvent):void {
			_dispatchExcludedPage = "";
			_dispatchExcludedPageParent = "";
			var id:String = e.id;
			// test if the page has children excluded 
			if (hasExcludedChildren(id)) {
				if (_currentPage != null && _currentPage.id == id) {
					// displayed
					new PageEvent(PageEvent.EXCLUDED_PARENT, id).dispatch();
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
					new PageEvent(PageEvent.EXCLUDED, id).dispatch();
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
					for (var i:int=_container.numChildren-1; i>=0; i--) {
						var pageID:String = Page(_container.getChildAt(i)).id;
						// the page called has been found in the display list: we stop the process
						if (pageID == _targetPageID) {
							_currentPage = Page(_container.getChildAt(i));
							break;
						}
						else if (isPageChild(_targetPageID, pageID) && Page(_container.getChildAt(i)).depth < getPageDepth(_pageShow[0])) {
							_currentPage = Page(_container.getChildAt(i));
							break;
						}
						else {
							if (Page(_container.getChildAt(i)).depth >= getPageDepth(_targetPageID) || !isPageChild(pageID, _targetPageID)) {
								_pageRemove.push(_container.getChildAt(i));
							}
						}
					}
					if (_pageRemove.length > 0) {
						removePages();
						setAddress(_targetPageID);
						return;
					}
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
				
		private function handleAddress(e:SWFAddressEvent = null):void {
			if (!DEEPLINKING_ENABLED) {
				if (_currentPage == null) {
					new PageEvent(PageEvent.SHOW, getLandingPageID()).dispatch();
					new MenuEvent(MenuEvent.OPEN_MENU, getLandingPageID()).dispatch();
				}
				return;
			}
			var val:String = SWFAddress.getValue();
			if (val != "/" || _currentPage != null) {
				if (val == "/" && _actualURL.toLowerCase() == "/"+Soma.getInstance().config.landingPageID+"/") return;
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
						new MenuEvent(MenuEvent.OPEN_MENU, target).dispatch();
						if (isExcluded(target)) {
							excludedPage = target;
							setAddress(excludedPage);
						}
						if (_currentPage == null) new PageEvent(PageEvent.SHOW, target).dispatch();
						else show(target);
						if (excludedPage != "") {
							if (target == _currentPage.id) {
								new PageEvent(PageEvent.EXCLUDED, excludedPage).dispatch();
							}
							else {
								_dispatchExcludedPage = excludedPage;
							}
						}
					}
					else {
						// page not found 
						new PageEvent(PageEvent.SHOW, getLandingPageID()).dispatch();
						new MenuEvent(MenuEvent.OPEN_MENU, getLandingPageID()).dispatch();
					}
				}
			}
			else {
				// first default page
				new PageEvent(PageEvent.SHOW, getLandingPageID()).dispatch();
				new MenuEvent(MenuEvent.OPEN_MENU, getLandingPageID()).dispatch();
			}
		}
		
		private function setAddress(name:String):void {
			if (!DEEPLINKING_ENABLED) return;
			var curLabel:String = "";
			var bTitle:String = "";
			curLabel = getUrlFriendly(name);
			bTitle = (getSiteName() == "") ? "" : getSiteName();
			var titleNode:String = getTitle(name);
			var titleBrowserNode:String = getTitleBrowser(name);
			if (titleBrowserNode != "") bTitle = bTitle + " | " + titleBrowserNode;
			else if (titleNode != "") bTitle = bTitle + " | " + titleNode;
			if (_actualURL != curLabel) {
				if (curLabel != "") {
					_actualURL = curLabel;
					var value:String = (Soma.getInstance().languageEnabled) ? ("/" + Soma.getInstance().currentLanguage + _actualURL) : _actualURL;
					if (name == getLandingPageID()) {
						_actualURL = "/";
						SWFAddress.setValue('/');
					}
					else SWFAddress.setValue(value.toLowerCase());
					if (TITLE_BROWSER_ENABLED) setBrowserTitle(bTitle);
				}
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Set the title of the browser window depending of the page. It is internally used by the page manager but you can set the static variable PageManager.TITLE_BROWSER_ENABLED to false (default true) and set a custom value.<br/><br/>
		 * By default, the title is built with the site name (Soma.getInstance().config.siteName) and the value of the title or the titleBrowser (priority on titleBrowser) node of a page node.
		 * @param value Title of the browser window.
		 */
		public function setBrowserTitle(value:String):void {
			SWFAddress.setTitle(value);
		}
		
		/** Get the URL (deep-linking) value for a page.
		 * @param id Attribute id of the page node.
		 * @return A string (string that will be append to the real URL).
		 */
		public function getUrlFriendly(id:String):String {
			var list:Array = [];
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			if (target.toXMLString() == "") trace("Error: Page not found in PageManager.getURLFriendly - " + id);
			if (target.hasOwnProperty("@urlfriendly")) list.push(target.@urlfriendly);
			if (target.parent() != null) process(target.parent());
			function process(x:XML):void {
				if (x.name() == "page") {
					if (x.hasOwnProperty("@urlfriendly")) list.push(x.@urlfriendly);
					process(x.parent());
				}
			}
			list.reverse();
			if (list.length == 0) return "/";
			else return "/" + list.join("/") + "/";
		}
		
		/** Removes the children of the page container and destroys the container. */
		public function dispose():void {
			Soma.getInstance().container.removeChild(_container);
			while (_container.numChildren > 0) {
				_container.removeChildAt(0);
			}
			_container = null;
			_currentPage = null;
		}
		
		/**
		 * Starts the PageManager (called by Soma during initialization process).
		 */
		public function start():void {
			if (!_started) {
				init();
				SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleAddress);
			}
			else {
				if (_currentPage == null) {
					init();
					SWFAddress.setValue("/");
					return;
				}
				var page:XML = Soma.getInstance().content.getPage(currentPage.id);
				if (page == null) {
					init();
					SWFAddress.setValue("/");
				}
				else showBackground(page.@id);
			}
		}
		
		/**
		 * Get the value of the title node of a page node.
		 * @param id Attribute id of the page node.
		 * @return A String.
		 */
		public function getTitle(id:String):String {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			return target['title'];
		}
		
		/**
		 * Get the value of the titleBrowser node of a page node.
		 * @param id Attribute id of the page node.
		 * @return A String.
		 */
		public function getTitleBrowser(id:String):String {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == id);
			return target['titleBrowser'];
		}
		
		/**
		 * Whether or not the page node is excluded (contains the attribute "exclude" set to true).
		 * @param idPage Attribute id of the page node.
		 * @return A Boolean.
		 */
		public function isExcluded(idPage:String):Boolean {
			var target:XMLList = Soma.getInstance().content.data..*.(name() == "page" && @id == idPage);
			if (String(target.attribute('exclude')) == "true") return true;
			else return false;
		}
		
		/**
		 * Whether or not the page has nodes children that are excluded (page node child containing the attribute "exclude" set to true).
		 * @param idPage Attribute id of the page node.
		 * @return A Boolean.
		 */
		public function hasExcludedChildren(idPage:String):Boolean {
			if (idPage == null || idPage == "") return false;
			var target:XML = Soma.getInstance().content.data..*.(name() == "page" && @id == idPage)[0];
			var excluded:XMLList = target.*.(name() == "page" && attribute('exclude') == "true");
			if (excluded.length() > 0) return true;
			else return false;
		}
		
		/**
		 * Get the first parent that is not excluded (first page node parent that is not containing the attribute "exclude" set to true).
		 * @param idPage Attribute id of the page node.
		 * @return A String (id of the page node parent).
		 */
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

		/**
		 * Meant to an internal Soma use: continue the process of showing pages (called at the end of the "transition in complete" event of a page).
		 * @param e PageEvent instance.
		 */
		public function showPages(e:PageEvent = null):void {
			if (_pageShow.length > 0 && _container.getChildByName(_pageShow[0]) == null) displayPage();
		}
		
		/**
		 * Meant to an internal Soma use: continue the process of hiding pages (called at the end of the "transition out complete" event of a page).
		 * @param e PageEvent instance.
		 */
		public function removePages(e:PageEvent = null):void {
			if (e != null) {
				var p:Page = Page(_container.getChildByName(e.id));
				if (p != null) _container.removeChild(p);
				p = null;
			}
			if (_pageRemove.length > 0) {
				_isRemoving = true;
				var pageToRemove:Page = _pageRemove[0];
				_pageRemove.splice(0, 1);
				dispatchTransitionOut(pageToRemove);
			}
			else {
				//if (_currentPage.id != _targetPageID) {
				_isRemoving = false;
				showPages();
			}
		}
		
		/**
		 * Get the type attribute of a page node (the type is the class name that will be instantiated by the PageManager).
		 * @param id Attribute id of the page node.
		 * @return A String (the type attribute).
		 */
		public function getPageType(id:String):String {
			return Soma.getInstance().content.data..*.(name() == "page" && @id == id).@type;
		}
		
		/**
		 * Get the id attribute of a page node using the deep-linking value (URL).
		 * @param urlFriendly String (value of the deep-linking).
		 * @return A String (id of the page).
		 */
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
								if (!x.hasOwnProperty("@urlfriendly")) {
									// no urlfriendly found in this node
									count++;
									process(x.parent());
									return;
								}
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
		
		/**
		 * Get the depth attribute of a page node.
		 * @param id Attribute id of the page node.
		 * @return A int (depth value).
		 */
		public function getPageDepth(id:String):int {
			var depth:String = Soma.getInstance().content.data..*.(name() == "page" && @id == id).@depth;
			if (depth != "") return int(depth);
			else return 0;
		}
		
		/**
		 * Whether or not a page node is an external page (contains the attribute "external" set to true).
		 * @param id Attribute id of the page node.
		 * @return A Boolean.
		 */
		public function isExternalPage(id:String):Boolean {
			var external:String = Soma.getInstance().content.data..*.(name() == "page" && @id == id).@external;
			if (external == "true") return true;
			return false;
		}
		
		/**
		 * Whether or not a page node is a movieclip page (contains the attribute "movieclip" set to true).
		 * @param id Attribute id of the page node.
		 * @return A Boolean.
		 */
		public function isMovieClipMode(id:String):Boolean {
			var movieclip:String = Soma.getInstance().content.data..*.(name() == "page" && @id == id).@movieclip;
			if (movieclip == "true") return true;
			return false;
		}
		
		/**
		 * Show a page (internally used by Soma after a PageEvent.SHOW event dispatched).
		 * @param id Attribute id of the page node.
		 */
		public function show(id:String):void {
			var event:PageEvent = new PageEvent(PageEvent.STARTED, id, "", true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				startPageProcess(event);
			}
		}
		
		/**
		 * Show an external link (open a new browser window).
		 * @param url Strig value of the external link to open.
		 */
		public function showExternalLink(url:String):void {
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, "_blank");
		}
		
		/**
		 * Get the current page displayed (Page). You can cast the class result to your own page:
		 * <listing version="3.0">
		 * MyPage(Soma.getInstance().page.currentPage)
		 * </listing> 
		 */
		public function get currentPage():Page {
			return _currentPage;
		}
		
		/**
		 * Whether or not the PageManager is currently removing pages.
		 */
		public function get isRemoving():Boolean {
			return _isRemoving;
		}
		
		/**
		 * Return the Sprite that contains all the pages.
		 * @return A Sprite.
		 */
		public function get container():Sprite {
			return _container;
		}
		
		/**
		 * Whether or not the PageManager has been started.
		 * @return A Boolean.
		 */
		public function get started():Boolean {
			return _started;
		}
	}
}