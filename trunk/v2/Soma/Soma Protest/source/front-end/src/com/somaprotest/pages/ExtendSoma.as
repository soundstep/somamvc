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
	
	public class ExtendSoma extends CanvasPage implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ExtendSoma() {
			addEventListener(PageEvent.INITIALIZED, createElements, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function createElements(e:PageEvent):void {
			buildSomaExtendExample();
			buildText1();
		}
		
		private function buildSomaExtendExample():void {
			var somaExtended:CodeBox = new CodeBox(300, 150);
			somaExtended.width = canvas.width - 30;
			somaExtended.y = posY;
			canvas.addChild(somaExtended);
			somaExtended.addCodeLine('package com.site {');
			somaExtended.addCodeLine('');
			somaExtended.addCodeLine('    import com.soma.Soma;');
			somaExtended.addCodeLine('');
			somaExtended.addCodeLine('    public class SomaExtended extends Soma {');
			somaExtended.addCodeLine('');
			somaExtended.addCodeLine('        private static var _instance:SomaExtended = new SomaExtended();');
			somaExtended.addCodeLine('');
			somaExtended.addCodeLine('        public function SomaExtended() {');
			somaExtended.addCodeLine('            if (_instance != null) throw new Error("SomaExtended is Singleton");');
			somaExtended.addCodeLine('        }');
			somaExtended.addCodeLine('');
			somaExtended.addCodeLine('        public static function getInstance():SomaExtended {');
			somaExtended.addCodeLine('            Soma.getInstance().updateInstance(_instance);');
			somaExtended.addCodeLine('            return _instance;');
			somaExtended.addCodeLine('        }');
			somaExtended.addCodeLine('    }');
			somaExtended.addCodeLine('}');
			canvas.refresh();
			posY = somaExtended.y + somaExtended.height + 7;
		}
		
		private function buildText1():void {
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
