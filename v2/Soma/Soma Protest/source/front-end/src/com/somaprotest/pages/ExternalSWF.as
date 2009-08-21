package com.somaprotest.pages {
	import com.soma.Soma;	import com.soma.interfaces.IPage;	import com.somaprotest.core.view.CodeBox;	import com.somaprotest.pages.core.CanvasPage;		
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
	
	public class ExternalSWF extends CanvasPage implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ExternalSWF() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function initialize():void {
			id = "externalSWF";
			super.initialize();
			if (Soma.getInstance().initialized) showInitFunction();
		}
		
		private function showInitFunction():void {
			var overridenInit:CodeBox = new CodeBox(300, 80);
			overridenInit.width = canvas.width - 30;
			overridenInit.y = posY;
			canvas.addChild(overridenInit);
			overridenInit.addCodeLine('override public function initialize():void {');
			overridenInit.addCodeLine('    id = "externalSWF";');
			overridenInit.addCodeLine('    super.initialize();');
			overridenInit.addCodeLine('    if (Soma.getInstance().initialized) buildMyPage();');			overridenInit.addCodeLine('}');
			canvas.refresh();
			posY = overridenInit.y + overridenInit.height + 7;
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
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.transitionOutComplete();
		}
	
	}
}
