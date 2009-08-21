package com.soma.view {
	
	import flash.events.Event;	
	import com.soma.events.PageEvent;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import flash.system.ApplicationDomain;	
	import flash.system.LoaderContext;	
	import com.soma.model.LoaderManager;	
	import com.soma.vo.LoaderItemVO;	
	import com.soma.events.LoaderEvent;	
	import com.soma.Soma;	
	import com.soma.interfaces.IRemovable;
	import flash.utils.getQualifiedClassName;

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

	public class PageExternal extends Page implements IRemovable {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _targetID:String;
		private var _pageNode:XML;
		private var _path:String;
		private var _file:String;
		private var _loader:LoaderManager;
		private var _isLoaded:Boolean;
		private var _page:Page;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageExternal(targetID:String) {
			_targetID = targetID;
			_pageNode = Soma.getInstance().content.getPage(targetID);
			_file = _pageNode.@type;
			_path = _pageNode.@path;
			setLoader();
		}

		//
		// PRIVATE
		//________________________________________________________________________________________________
		
		override protected function init():void {
			
		}
		
		override protected function start():void {
			
		}
		
		override protected function startContent():void {
			
		}
		
		private function setLoader():void {
			_isLoaded = false;
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			_loader = new LoaderManager();
			_loader.loaderContext = context;
			_loader.addLoading(Soma.getInstance().config.loadingClass);
			_loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, completeHandler, false, 0, true);
			new LoaderEvent(LoaderEvent.ADD_ITEM, _loader, new LoaderItemVO(_path+_file+".swf", this)).dispatch();
			new LoaderEvent(LoaderEvent.START_LOADING, _loader).dispatch();
		}
		
		private function completeHandler(e:QueueLoaderEvent):void {
			_isLoaded = true;
			ApplicationDomain.currentDomain.getDefinition(getQualifiedClassName(e.file));
			if (e.file is Page) {
				_page = e.file as Page;
				_page.id = id;
				_page.type = type;
				_page.depth = depth;
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			_loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, completeHandler, false);
			_loader.stop();
			if (_page != null) _page.remove();
			else {
				while (numChildren > 0) {
					removeChildAt(numChildren-1);
				}
				new PageEvent(PageEvent.PAGE_REMOVED, id).dispatch();
			}
		}
		
		override public function dispose(e:Event = null):void {
			
		}
		
		public function get loader():LoaderManager {
			return _loader;
		}
		
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
		
		public function get page():Page {
			return _page;
		}
	}
}