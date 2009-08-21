package com.somaprotest {
	
	import com.somaprotest.core.model.SomaExtended;	
	import com.soundstep.ui.BaseUI;	
	import com.soundstep.ui.ElementUI;	
	import com.somaprotest.commons.Footer;	
	import com.soma.events.ContentEvent;	
	import com.soma.Soma;	
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
	public class Main extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var footer:Footer;
		public var commons:Sprite;
		public var baseUI:BaseUI;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Main() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			// SomaExtended is extending Soma to initialize our own Soma Protest controller: com.somaprotest.core.control.SomaProtestController
			// Demo in the custom MVC page in Soma Protest 
			// start Soma, usual syntax:
			// Soma.getInstance().start(this, "data/site.xml", new Config(), new Transitions());
			
			// listener
			SomaExtended.getInstance().addEventListener(ContentEvent.INITIALIZED, contentInitialized);
			// stylesheet
			SomaExtended.getInstance().registerGloBalStyleSheet("css/flash_global.css");
			// start
			SomaExtended.getInstance().start(this, "data/site.xml", new Config(), new Transitions());
		}

		private function contentInitialized(e:ContentEvent = null):void {
			initCommons();
		}

		private function initCommons():void {
			//BaseUI
			baseUI = new BaseUI(this);
			//container
			commons = new Sprite();
			addChild(commons);
			//footer
			footer = new Footer();
			commons.addChild(footer);
			var el:ElementUI = baseUI.add(footer);
			el.horizontalCenter = 0;
			el.verticalCenter = Soma.getInstance().content.data.@height * .5 + 8;
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
	}
}
