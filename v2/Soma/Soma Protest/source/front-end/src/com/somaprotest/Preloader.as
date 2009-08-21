package com.somaprotest {
	import com.soma.utils.BasicLoader;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

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

	public class Preloader extends Sprite {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Preloader() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 41;
			// textformat
			var tf:TextFormat = new TextFormat();
			tf.font = "FFF Star Condensed";
			tf.color = 0x000000;
			tf.size = 8;
			// loader
			var loader:BasicLoader = new BasicLoader("Main.swf", 0x000000, "Main", false);
			loader.textFormat = tf;
			loader.embedFont = true;
			loader.text.autoSize = TextFieldAutoSize.NONE;
			loader.text.width = 75;
			loader.text.height = 18;
			addChild(loader);
			loader.start();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
		
	}
	
}