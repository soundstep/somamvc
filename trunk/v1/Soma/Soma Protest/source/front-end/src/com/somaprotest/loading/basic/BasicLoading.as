package com.somaprotest.loading.basic {
	
	import com.soma.interfaces.IComplete;	
	import com.soma.interfaces.ILoading;	
	import com.soma.interfaces.IDisplayable;	
	import com.soma.view.SomaText;	
	import com.soma.view.Loading;
	import com.hydrotik.utils.QueueLoaderEvent;	
	import flash.display.Sprite;
	
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
	
	public class BasicLoading extends Loading implements IDisplayable, ILoading {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var info:SomaText;
		public var line:Sprite;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicLoading() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
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
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function progress(e:QueueLoaderEvent):void {
			info.htmlText = "Loading " + Math.round(e.queuepercentage * 100) + "%";
			line.width = 160 * e.queuepercentage;
		}
		
		override public function show(complete:IComplete = null):void {
			super.show();
		}
		
		override public function hide(complete:IComplete = null):void {
			super.hide();
		}
		
	}
	
}
