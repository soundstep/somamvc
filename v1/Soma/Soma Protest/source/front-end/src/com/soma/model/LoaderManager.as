package com.soma.model {
	
	import com.soma.Soma;
	import flash.system.LoaderContext;	
	import com.soma.vo.LoaderItemVO;	
	import com.soundstep.ui.ElementUI;	
	import com.soma.view.Loading;	
	import com.hydrotik.utils.QueueLoader;
	import com.hydrotik.utils.QueueLoaderEvent;

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
	
	public class LoaderManager {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _queue:QueueLoader;
		private var _loading:Loading;
		private var _loaderContext:LoaderContext;

		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function LoaderManager() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		private function init():void {
			_queue = new QueueLoader();
			_queue.addEventListener(QueueLoaderEvent.QUEUE_START, onQueueStart, false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.ITEM_START, onItemStart, false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.ITEM_PROGRESS, onItemProgress, false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onItemInit,false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.ITEM_ERROR, onItemError,false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.QUEUE_PROGRESS, onQueueProgress, false, 0, true);
			_queue.addEventListener(QueueLoaderEvent.QUEUE_COMPLETE, onQueueComplete,false, 0, true);
		}
		
		protected function onQueueStart(e:QueueLoaderEvent):void {
        	//trace(e.type);
			if (_loading != null) _loading.show();
		}

		protected function onItemStart(e:QueueLoaderEvent):void {
			//trace(e.type, "item title: "+e.title);
		}
		
		protected function onItemProgress(e:QueueLoaderEvent):void {
			//trace(e.type+": "+[" percentage: "+e.percentage]);
			if (_loading != null) _loading.progress(e); 
		}
		
		protected function onQueueProgress(e:QueueLoaderEvent):void {
			//trace(e.type+": "+[" queuepercentage: "+e.queuepercentage]);
		}
		
		protected function onItemInit(e:QueueLoaderEvent):void {
			//trace(e.message+"\n");
		}
		
		protected function onItemError(e:QueueLoaderEvent):void {
			//trace(e.message+"\n");
		}
		
		protected function onQueueComplete(e:QueueLoaderEvent):void {
			//trace(e.message+"\n");
			if (_loading != null) _loading.hide();
		}

		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function addLoading(loadingClass:String):Loading {
			var LoadingClass:Class = Soma.getInstance().config.getClass(loadingClass);
			_loading = new LoadingClass();
			var el:ElementUI = Soma.getInstance().baseUI.add(loading);
			el.horizontalCenter = el.verticalCenter = 0;
			Soma.getInstance().container.addChild(_loading);
			return _loading as Loading;
		}

		public function add(loaderVO:LoaderItemVO):void {
			if (_queue == null) init();
			_queue.addItem(loaderVO.file, loaderVO.container, loaderVO.objectInfo);
		}
		
		public function start():void {
			if (_queue == null) init();
			if (!_queue.loading) _queue.execute();
		}
	
		public function stop():void {
			if (_loading != null) _loading.hide();
			if (_queue != null) {
				_queue.stop();
				_queue.dispose();
			}
		}
		
		public function get queue():QueueLoader {
			return _queue;
		}
		
		public function get loading():Loading {
			return _loading;
		}
		
		public function set loading(loading:Loading):void {
			_loading = loading;
		}
		
		public function get loaderContext():LoaderContext {
			return _loaderContext;
		}
		
		public function set loaderContext(loaderContext:LoaderContext):void {
			_loaderContext = loaderContext;
			_queue.loaderContext = _loaderContext;
		}
		
	}
}