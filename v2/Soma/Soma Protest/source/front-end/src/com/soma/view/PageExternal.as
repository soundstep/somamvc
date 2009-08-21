package com.soma.view {
	import com.soma.Soma;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.loader.SomaLoader;
	import com.soma.loader.SomaLoaderEvent;

	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getQualifiedClassName;

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
     * PageExternal is not meant to be extended, it is internally used by the PageManager to load external SWF that is going to act as a normal page.
     * Here is a node example, it will load a MovieName.swf at the same location of the current SWF:
     * <listing version="3.0">
&lt;page id="external page id" type="MovieName" urlfriendly="external-page" external="true"&gt;
    &lt;title&gt;&lt;![CDATA[External Page]]&gt;&lt;/title&gt;
&lt;/page&gt;
     * </listing>
     * You can use a path attribute in case your SWF file is located elsewhere, this example will load "assets/swf/MovieName.swf":
     * <listing version="3.0">
&lt;page id="external page id" type="MovieName" path="assets/swf/" urlfriendly="external-page" external="true"&gt;
    &lt;title&gt;&lt;![CDATA[External Page]]&gt;&lt;/title&gt;
&lt;/page&gt;
     * </listing>
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.PageEvent PageEvent
     * @see com.soma.view.Page Page
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.assets.ClassImport ClassImport
     */

	public class PageExternal extends Page implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _targetID:String;
		private var _pageNode:XML;
		private var _path:String;
		private var _file:String;
		private var _loader:SomaLoader;
		private var _isLoaded:Boolean;
		private var _page:Page;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a PageExternal instance
		 * @param targetID id attribute of the page node.
		 */
		public function PageExternal(targetID:String) {
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			_targetID = targetID;
			
		}

		//
		// PRIVATE
		//________________________________________________________________________________________________
		
		/** @private */
		override protected function initialize():void {
			
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			_pageNode = Soma.getInstance().content.getPage(_targetID);
			_file = _pageNode.@type;
			_path = _pageNode.@path;
			loadSWF();
		}
		
		private function loadSWF():void {
			_isLoaded = false;
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			_loader = Soma.getInstance().loader;
			_loader.loaderContext = context;
			_loader.addEventListener(SomaLoaderEvent.COMPLETE, completeHandler, false, 0, true);
			_loader.add(_path+_file+".swf", this);
			_loader.start();
		}
		
		private function completeHandler(e:SomaLoaderEvent):void {
			_loader.removeEventListener(SomaLoaderEvent.COMPLETE, completeHandler, false);
			_isLoaded = true;
			ApplicationDomain.currentDomain.getDefinition(getQualifiedClassName(e.item.file));
			if (e.item.file is Page) {
				_page = e.item.file as Page;
				_page.id = id;
				_page.type = type;
				_page.depth = depth;
				dispatchTransitionIn(_page);
			}
		}
		
		private function dispatchTransitionIn(page:Page):void {
			var event:PageEvent = new PageEvent(PageEvent.TRANSITION_IN, page.id, "", true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				page.transitionIn();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** @private */
		override public function transitionIn():void {
			// not used
		}
		
		/** @private */
		override public function transitionInComplete():void {
			// not used
		}
		
		/** @private */
		override public function transitionOut():void {
			_loader.removeEventListener(SomaLoaderEvent.COMPLETE, completeHandler, false);
			_loader.stop();
			if (_page != null) _page.transitionOut();
			else {
				while (numChildren > 0) {
					removeChildAt(0);
				}
				transitionOutComplete();
			}
		}
		
		/** @private */
		override public function transitionOutComplete():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			_page = null;
			super.transitionOutComplete();
		}
		
		/**
		 * Whether or not the SWF File has been loaded.
		 * @return A Boolean.
		 */
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
		
		/**
		 * Get the SWF file that has been loaded (the Main class of the SWF file must extend a the Page class).
		 * @return A Page instance.
		 */
		public function get page():Page {
			return _page;
		}
	}
}