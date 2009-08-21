package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.soma.Soma;	
	import com.somaprotest.Transitions;	
	import com.somaprotest.Config;	
	import com.somaprotest.core.view.CodeBox;	
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
	
	public class ExternalSWF extends CanvasPage implements IRemovable {

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
		
		override protected function init():void {
			id = "externalSWF";
			if (!Soma.getInstance().initialized) {
				// called when you compile the external SWF
				// this is not required, it is only for an easier development
				// when you compile this external movie, Soma is not instantiated
				// you can instantiate Soma to be able to see the site when you compile this movie
				// When the Main Movie load this page, Soma doesn't initialized twice because of the condition above
				Soma.getInstance().registerGloBalStyleSheet("css/flash_global.css");
				Soma.getInstance().start(this, "data/site.xml", new Config(), new Transitions());
			}
			super.init();
			if (Soma.getInstance().initialized) showInitFunction();
		}
		
		private function showInitFunction():void {
			var overridenInit:CodeBox = new CodeBox(300, 120);
			overridenInit.width = canvas.width - 30;
			overridenInit.y = posY;
			canvas.addChild(overridenInit);
			overridenInit.addCodeLine('override protected function init():void {');
			overridenInit.addCodeLine('    id = "externalSWF";');
			overridenInit.addCodeLine('    if (!Soma.getInstance().initialized) {');
			overridenInit.addCodeLine('        Soma.getInstance().registerGloBalStyleSheet("css/flash_global.css");');			overridenInit.addCodeLine('        Soma.getInstance().start(this, "data/site.xml", new Config(), new Transitions());');
			overridenInit.addCodeLine('    }');
			overridenInit.addCodeLine('    super.init();');
			overridenInit.addCodeLine('}');
			canvas.refresh();
			posY = overridenInit.y + overridenInit.height + 7;
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
