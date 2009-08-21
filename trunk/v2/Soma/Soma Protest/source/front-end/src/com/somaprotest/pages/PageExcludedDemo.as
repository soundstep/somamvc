package com.somaprotest.pages {
	import caurina.transitions.Tweener;

	import com.soma.Soma;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.loader.SomaLoader;
	import com.soma.loader.SomaLoaderEvent;
	import com.somaprotest.pages.core.CanvasPage;
	import com.somaprotest.pages.core.Image;

	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 05-2008<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class PageExcludedDemo extends CanvasPage implements IPage {

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
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
			_images = [];
			Soma.getInstance().addEventListener(PageEvent.EXCLUDED, pageExcludedHandler, false, 0, false);
			Soma.getInstance().addEventListener(PageEvent.EXCLUDED_PARENT, pageExcludedHandler, false, 0, false);
			buildPortfolio();
		}
		
		private function buildPortfolio():void {
			var pageNode:XML = content.parent();
			_imageList = pageNode..*.(name() == "page" && attribute("exclude") == "true");
			if (_imageList.length() > 0) {
				var loader:SomaLoader = Soma.getInstance().loader;
				loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
				for each (var image:XML in _imageList) {
					var img:Image = new Image();
					img.name = image.@id;
					img.id = image.@id;
					img.file = image.@file;
					canvas.addChild(img);
					_images.push(img);
					loader.add(image.@file, img);
				}
				loader.start();
			}
		}
		
		private function itemComplete(e:SomaLoaderEvent):void {
			// center image in sprite
			var b:Bitmap = e.item.file as Bitmap;
			b.x = -(b.width * .5);
			b.y = -(b.height * .5);
			// reduce scale and set position
			var img:Image = e.item.container as Image;
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
			new PageEvent(PageEvent.SHOW, targetID).dispatch();
		}

		private function pageExcludedHandler(e:PageEvent):void {
			if (_images.length == 0) _imageToShow = e.id;
			_currentImage = null;
			for each (var image:Image in _images) {
				if (image.id == e.id) {
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
			Tweener.addTween(target, {time:1, scaleX:.7, scaleY:.7, x:canvas.width * .5, y:posY + 230});
		}
		
		private function hideImage(target:Image):void {
			Tweener.addTween(target, {time:1, scaleX:.2, scaleY:.2, x:target.initPos.x, y:target.initPos.y});
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionIn():void {
			super.transitionIn();
		}

		override public function transitionInComplete():void {
			super.transitionInComplete();
		}
		
		override public function transitionOut():void {
			super.transitionOut();
		}
		
		override public function transitionOutComplete():void {
			removeEventListener(PageEvent.INITIALIZED, createElements, false);
			Soma.getInstance().loader.removeEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
			Soma.getInstance().removeEventListener(PageEvent.EXCLUDED, pageExcludedHandler, false);
			Soma.getInstance().removeEventListener(PageEvent.EXCLUDED_PARENT, pageExcludedHandler, false);
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
	
	}
}
