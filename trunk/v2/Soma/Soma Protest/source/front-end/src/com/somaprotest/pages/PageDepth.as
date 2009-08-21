package com.somaprotest.pages {
	import com.soma.Soma;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.loader.SomaLoader;
	import com.soma.loader.SomaLoaderEvent;
	import com.soma.view.SomaText;
	import com.somaprotest.pages.core.CanvasPage;

	import flash.display.Bitmap;

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
	
	public class PageDepth extends CanvasPage implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageDepth() {
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
			Soma.getInstance().loader.removeEventListener(SomaLoaderEvent.COMPLETE, imageComplete);
			var imageNode:XML = content.*.(@id == "pageDepthImage")[0];
			var loader:SomaLoader = Soma.getInstance().loader;
			loader.addEventListener(SomaLoaderEvent.COMPLETE, imageComplete, false, 0, true);
			loader.add(imageNode.@path + imageNode.@file, canvas);
			loader.start();
		}
		
		private function imageComplete(e:SomaLoaderEvent):void {
			var somaContainers:Bitmap = e.item.file as Bitmap;
			somaContainers.y = posY;
			posY = somaContainers.y + somaContainers.height + 7;
			canvas.refresh();
			showText1();
		}
		
		private function showText1():void {
			var text1:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			text1.width = canvas.width - 25;
			text1.y = posY;
			canvas.addChild(text1);
			posY = text1.y + text1.height + 7;
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
			Soma.getInstance().loader.removeEventListener(SomaLoaderEvent.COMPLETE, imageComplete, false);
			super.transitionOut();
		}
		
		override public function transitionOutComplete():void {
			removeEventListener(PageEvent.INITIALIZED, createElements, false);
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
		
	}
}
