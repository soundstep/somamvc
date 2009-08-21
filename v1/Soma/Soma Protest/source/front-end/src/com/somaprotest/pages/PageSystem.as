package com.somaprotest.pages {
	
	import flash.events.Event;	
	import flash.display.Bitmap;	
	import com.soma.Soma;	
	import com.soma.events.LoaderEvent;	
	import com.soma.vo.LoaderItemVO;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import com.soma.interfaces.IRemovable;
	import com.somaprotest.pages.core.CanvasPage;

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
	
	public class PageSystem extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageSystem() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, imageComplete);
			var imageNode:XML = content.*.(@id == "pageShowing")[0];
			var loaderItemVO:LoaderItemVO = new LoaderItemVO(imageNode.@path + imageNode.@file, canvas, {title:imageNode.@id, smoothing:true});
			new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, loaderItemVO).dispatch();
			new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();
		}
		
		private function imageComplete(e:QueueLoaderEvent):void {
			var pageShowing:Bitmap = e.file as Bitmap;
			pageShowing.y = posY;
			posY = pageShowing.y + pageShowing.height + 7;
			canvas.refresh();
		}
		
		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			super.remove(e);
		}
		
		override public function dispose(e:Event = null):void {
			Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, imageComplete);
			super.dispose(e);
		}
	
	}
}
