package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.somaprotest.core.view.CodeBox;	
	import com.soma.view.SomaText;	
	import com.somaprotest.pages.core.CanvasPage;	
	import com.soma.interfaces.IRemovable;

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
	
	public class Stylesheet extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Stylesheet() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			buildCSSBox();
			buildText1();
		}
		
		private function buildCSSBox():void {
			var CSSxample:CodeBox = new CodeBox(300, 150);
			CSSxample.width = canvas.width - 30;
			CSSxample.y = posY;
			canvas.addChild(CSSxample);
			CSSxample.addCodeLine('// basic SomaText');
			CSSxample.addCodeLine('var text:SomaText = new SomaText();');
			CSSxample.addCodeLine('');
			CSSxample.addCodeLine('// SomaText with text value');
			CSSxample.addCodeLine('var text:SomaText = new SomaText("this is my text");');
			CSSxample.addCodeLine('');
			CSSxample.addCodeLine('// SomaText with text value and a style from the global Stylesheet');
			CSSxample.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle");');
			CSSxample.addCodeLine('');
			CSSxample.addCodeLine('// SomaText with text value, a style and a specific Stylesheet');
			CSSxample.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle", Soma.getInstance().styles.getStyleSheet("otherCSS"));');
			CSSxample.addCodeLine('');
			CSSxample.addCodeLine('// SomaText with text value, a style, a global stylesheet and some TextField properties');
			CSSxample.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle", null, {selectable:true, antiAliasType:AntiAliasType.NORMAL, multiline:true, wordWrap:true,});');
			CSSxample.addCodeLine('');
			CSSxample.addCodeLine('// SomaText with html text value, a style and a global stylesheet');
			CSSxample.addCodeLine('var text:SomaText = new SomaText("&lt;p&gt;this is my &lt;span class="otherStyle"&gt;html text&lt;/span>&lt;/p&gt;", "myStyle");');
			CSSxample.addCodeLine('');
			canvas.refresh();
			posY = CSSxample.y + CSSxample.height + 7;
		}
		
		private function buildText1():void {
			var text1:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			text1.y = posY;
			text1.width = canvas.width - 25;
			canvas.addChild(text1);
			posY = text1.y + text1.height + 7;
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
			super.dispose(e);
		}
	
	}
}
