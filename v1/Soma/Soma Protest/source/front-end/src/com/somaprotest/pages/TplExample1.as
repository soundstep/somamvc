package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.soma.tween.SomaTween;	
	import com.soma.view.SomaText;		import flash.display.DisplayObject;	
	import com.somaprotest.templates.TemplateExample;		import com.soma.events.TemplateEvent;	
	import com.soma.Soma;	
	import com.soma.view.Page;	
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
	
	public class TplExample1 extends Page implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _text1:SomaText;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TplExample1() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			Soma.getInstance().addEventListener(TemplateEvent.TEMPLATE_DISPLAYED, templateDisplayedHandler);
			super.init();
		}

		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
		}
		
		private function templateDisplayedHandler(e:TemplateEvent):void {
			var templateElements:Array = TemplateExample(template).elements;
			var lastTemplateElement:DisplayObject = templateElements[templateElements.length-1];
			// text1
			_text1 = new SomaText(content.*.(@id == "text1"), "body");
			_text1.width = 300;
			_text1.alpha = 0;
			_text1.visible = false;
			_text1.x = 170;
			_text1.y = lastTemplateElement.y + lastTemplateElement.height;
			addChild(_text1);
			SomaTween.start(_text1, null, {time:.5, _autoAlpha:1, onComplete:super.dispatchDisplay});
		}
		
		override protected function dispatchDisplay():void {
			// the default behavior is dispatch PageEvent.PAGE_DISPLAYED when the template is displayed (TemplateEvent.TEMPLATE_DISPLAYED)
			// we override the dispatchDisplay function not to dispatch PageEvent.PAGE_DISPLAYED
			// and dispatch it when the page is completely displayed using super.dispatchDisplay
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			SomaTween.start(_text1, null, {time:.7, _autoAlpha:0});
			super.remove();
		}
		
		override public function dispose(e:Event = null):void {
			Soma.getInstance().removeEventListener(TemplateEvent.TEMPLATE_DISPLAYED, templateDisplayedHandler);
			super.dispose();
		}
	
	}
}
