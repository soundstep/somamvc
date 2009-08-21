package com.somaprotest.loading.basic {
	import caurina.transitions.Tweener;

	import com.soma.loader.ILoading;
	import com.soma.loader.SomaLoaderEvent;
	import com.soma.view.SomaText;

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
	
	public class BasicLoading extends Sprite implements ILoading {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var info:SomaText;
		public var line:Sprite;
		public var lineItem:Sprite;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicLoading() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function init():void {
//			super.init();
			draw();
		}
		
		private function draw():void {
			graphics.beginFill(0x000000, .7);
			graphics.drawRect(0, 0, 180, 40);
			info = new SomaText("", "body");
			info.x = 10;
			info.y = 7;
			addChild(info);
			line = new Sprite();
			line.x = 10;
			line.y = 30;
			line.graphics.beginFill(0xFFFFFF);
			line.graphics.drawRect(0, 0, 160, 1);
			line.width = 0;
			addChild(line);
			lineItem = new Sprite();
			lineItem.x = 10;
			lineItem.y = 28;
			lineItem.graphics.beginFill(0xFFFFFF);
			lineItem.graphics.drawRect(0, 0, 160, 1);
			lineItem.width = 0;
			addChild(lineItem);
			// set to true to see an item progression
			lineItem.visible = false;
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function itemStart(e:SomaLoaderEvent):void {
			
		}
		
		public function itemProgress(e:SomaLoaderEvent):void {
			lineItem.width = 160 * e.percentItem / 100;
		}
		
		public function itemComplete(e:SomaLoaderEvent):void {
			
		}
		
		public function queueStart():void {
			Tweener.addTween(this, {time: .7, _autoAlpha:1});
		}

		public function queueProgress(e:SomaLoaderEvent):void {
			info.htmlText = "Loading " + Math.round(e.percentQueue) + "%";
			line.width = 160 * e.percentQueue / 100;
		}
		
		public function queueComplete():void {
			Tweener.addTween(this, {time: .7, _autoAlpha:0});
		}
		
		public function error(e:SomaLoaderEvent):void {
			
		}
		
	}
	
}
