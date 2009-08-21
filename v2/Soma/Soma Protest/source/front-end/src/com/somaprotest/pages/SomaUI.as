package com.somaprotest.pages {
	import caurina.transitions.Tweener;

	import com.soma.Soma;
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.loader.SomaLoaderEvent;
	import com.somaprotest.pages.core.CanvasPage;

	import flash.display.Sprite;

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
	
	public class SomaUI extends CanvasPage implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _screenshotList:XMLList;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaUI() {
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function createElements(e:PageEvent = null):void {
			loadScreenshots();
		}
		
		private function loadScreenshots():void {
			Soma.getInstance().loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
			_screenshotList = pageXML.content..*.(name() == "image" && String(@id).indexOf("somaui screnshot") != -1);
			for each (var screenshot:XML in _screenshotList) {
				Soma.getInstance().loader.add(screenshot.@file, new Sprite);
			}
			Soma.getInstance().loader.start();
		}
		
		private function itemComplete(e:SomaLoaderEvent):void {
			var screenshot:Sprite = canvas.addChild(e.item.container as Sprite) as Sprite;
			screenshot.alpha = 0;
			screenshot.y = posY;
			posY += screenshot.height + 20;
			Tweener.addTween(screenshot, {time:2, alpha:1});
			canvas.refresh();
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
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
	
	}
}
