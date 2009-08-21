package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.somaprotest.pages.core.Image;	
	import com.soma.tween.SomaTween;	
	import flash.events.MouseEvent;	
	import flash.geom.Point;	
	import flash.display.Bitmap;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import com.soma.vo.LoaderItemVO;	
	import com.soma.events.LoaderEvent;	
	import com.soma.events.PageEvent;	
	import com.soma.Soma;	
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
	
	public class PageExcludedDemo extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _imageList:XMLList;
		private var _images:Array;
		private var _currentImage:Image;
		private var _imageToShow:String;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageExcludedDemo() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			_images = [];
			Soma.getInstance().addEventListener(PageEvent.GET_EXCLUDED_PAGE, pageExcludedHandler, false, 0, false);
			Soma.getInstance().addEventListener(PageEvent.GET_EXCLUDED_PAGE_PARENT, pageExcludedHandler, false, 0, false);
			super.init();
		}
		
		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
			buildPortfolio();
		}
		
		private function buildPortfolio():void {
			var pageNode:XML = content.parent();
			_imageList = pageNode..*.(name() == "page" && attribute("exclude") == "true");
			if (_imageList.length() > 0) {
				for each (var image:XML in _imageList) {
					var img:Image = new Image();
					img.name = image.@id;
					img.id = image.@id;
					img.file = image.@file;
					canvas.addChild(img);
					_images.push(img);
					Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete);
					var lvo:LoaderItemVO = new LoaderItemVO(image.@file, img, {smoothing:true});
					new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, lvo).dispatch();
				}
				new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();
			}
		}
		
		private function itemComplete(e:QueueLoaderEvent):void {
			// center image in sprite
			var b:Bitmap = e.file as Bitmap;
			b.x = -(b.width * .5);
			b.y = -(b.height * .5);
			// reduce scale and set position
			var img:Image = e.targ as Image;
			img.addEventListener(MouseEvent.CLICK, clickHandler);
			img.scaleX = img.scaleY = .2;
			img.x = (img.width * .5) + ((img.width + 10) * e.count);
			img.y = posY + (img.height * .5);
			img.initPos = new Point(img.x, img.y);
			// show the image when the user access to an image with the URL
			// as the image is not loaded yet when PageEvent.GET_EXCLUDED_PAGE is dispatch
			if (_imageToShow == img.id) {
				showImage(img);
				_imageToShow = null;
			}
		}
		
		private function clickHandler(e:MouseEvent):void {
			// show a image or the page itself to reset the selection (in case the user click on a selected picture)
			var image:Image = e.currentTarget as Image;
			var targetID:String = (image != _currentImage) ? image.id : id; // id is the page of this page (super.id)
			new PageEvent(PageEvent.SHOW_PAGE, targetID).dispatch();
		}

		private function pageExcludedHandler(e:PageEvent):void {
			if (_images.length == 0) _imageToShow = e.pageID;
			_currentImage = null;
			for each (var image:Image in _images) {
				if (image.id == e.pageID) {
					showImage(image);
				}
				else {
					if (image.initPos != null) hideImage(image);
				}
			}
		}
		
		private function showImage(target:Image):void {
			_currentImage = target;
			canvas.setChildIndex(target, canvas.numChildren - 1);
			SomaTween.start(target, null, {time:1, scaleX:.7, scaleY:.7, x:canvas.width * .5, y:posY + 230});
		}
		
		private function hideImage(target:Image):void {
			SomaTween.start(target, null, {time:1, scaleX:.2, scaleY:.2, x:target.initPos.x, y:target.initPos.y});
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			super.remove(e);
		}
		
		override public function dispose(e:Event = null):void {
			Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete);
			Soma.getInstance().removeEventListener(PageEvent.GET_EXCLUDED_PAGE, pageExcludedHandler, false);
			Soma.getInstance().removeEventListener(PageEvent.GET_EXCLUDED_PAGE_PARENT, pageExcludedHandler, false);
			super.dispose(e);
		}
	
	}
}
