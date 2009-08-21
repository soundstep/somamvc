package com.somaprotest {
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import com.soma.events.ContentEvent;
	import com.soma.events.SomaEvent;
	import com.somaprotest.core.model.SomaExtended;

	import flash.display.Sprite;
	import flash.events.Event;

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
	 
	public class Main extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			init();
		}
		
		private function init():void {
			MacMouseWheel.setup(stage);
			// SomaExtended is extending Soma to initialize our own Soma Protest controller: com.somaprotest.core.control.SomaProtestController
			// Demo in the custom MVC page in Soma Protest 
			// start Soma, usual syntax:
			// Soma.getInstance().start(this, "data/site.xml", new Config());
			// listeners
			SomaExtended.getInstance().addEventListener(ContentEvent.LOADED, contentLoaded);
			SomaExtended.getInstance().addEventListener(SomaEvent.INITIALIZED, initialized);
			// stylesheet
			SomaExtended.getInstance().registerGloBalStyleSheet("css/flash_global.css");
			// start
			SomaExtended.getInstance().start(this, "data/site.xml", new Config());
		}
		
		private function contentLoaded(e:ContentEvent = null):void {
			// XML and Stylesheet loaded
			// The classes that don't need the XML to be initialized have been initialized 
		}

		private function initialized(e:SomaEvent = null):void {
			// Soma is fully initialized
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
	}
}

