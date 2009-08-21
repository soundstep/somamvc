package com.somaprotest.pages {
	import com.soma.events.PageEvent;
	import com.soma.interfaces.IPage;
	import com.soma.view.SomaText;
	import com.somaprotest.core.view.CodeBox;
	import com.somaprotest.pages.core.CanvasPage;

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
	
	public class Stylesheet extends CanvasPage implements IPage {

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
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
			buildCSSBox();
			buildText1();
		}
		
		private function buildCSSBox():void {
			var exampleCSS:CodeBox = new CodeBox(300, 150);
			exampleCSS.width = canvas.width - 30;
			exampleCSS.y = posY;
			canvas.addChild(exampleCSS);
			exampleCSS.addCodeLine('// basic SomaText');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText();');
			exampleCSS.addCodeLine('');
			exampleCSS.addCodeLine('// SomaText with text value');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText("this is my text");');
			exampleCSS.addCodeLine('');
			exampleCSS.addCodeLine('// SomaText with text value and a style from the global Stylesheet');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle");');
			exampleCSS.addCodeLine('');
			exampleCSS.addCodeLine('// SomaText with text value, a style and a specific Stylesheet');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle", Soma.getInstance().styles.getStyleSheet("otherCSS"));');
			exampleCSS.addCodeLine('');
			exampleCSS.addCodeLine('// SomaText with text value, a style, a global stylesheet and some TextField properties');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText("this is my text", "myStyle", null, {selectable:true, antiAliasType:AntiAliasType.NORMAL, multiline:true, wordWrap:true,});');
			exampleCSS.addCodeLine('');
			exampleCSS.addCodeLine('// SomaText with html text value, a style and a global stylesheet');
			exampleCSS.addCodeLine('var text:SomaText = new SomaText("&lt;p&gt;this is my &lt;span class="otherStyle"&gt;html text&lt;/span>&lt;/p&gt;", "myStyle");');
			exampleCSS.addCodeLine('');
			canvas.refresh();
			posY = exampleCSS.y + exampleCSS.height + 7;
		}
		
		private function buildText1():void {
			var text1:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			text1.y = posY;
			text1.width = canvas.width - 25;
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
