package com.somaprotest.templates {
	
	import com.soma.Soma;
	import com.soma.view.Template;
	import com.soma.view.Page;
	import com.soma.tween.SomaTween;	
	import com.soma.model.LoaderManager;	
	import com.soma.model.TemplateManager;	
	import com.soma.interfaces.ITemplateable;	
	import com.soma.interfaces.IRemovable;	
	import com.hydrotik.utils.QueueLoaderEvent;
	import flash.display.DisplayObjectContainer;	
	import flash.display.DisplayObject;	
	import flash.utils.Timer;	
	import flash.events.Event;	
	import flash.events.TimerEvent;	

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
	
	public class TemplateParser extends Template implements IRemovable, ITemplateable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _elements:Array;
		private var _timer:Timer;

		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TemplateParser(page:Page, containerTarget:DisplayObjectContainer) {
			super(page, containerTarget);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			_elements = [];
		}
		
		override protected function startTemplate():void {
			_elements = Soma.getInstance().template.parse(page.baseUI, page.content.children());
			if (hasExternalAsset && Soma.getInstance().loader != null) {
				Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, elementComplete, false, 0, true);
			}
			for each (var element:DisplayObject in _elements) {
				element.alpha = 0;
				element.visible = false;
			}
			if (!hasExternalAsset) show();
		}
		
		private function elementComplete(e:QueueLoaderEvent):void {
			var child:XMLList = page.content..*.(attribute('id') == e.title);
			if (child.length() > 0) {
				Soma.getInstance().template.setBaseUI(e.targ, page.baseUI, XML(child));
				e.targ['alpha'] = 0;
				if (e.length == 0 && !Soma.getInstance().page.isRemoving) show();
			}
		}
		
		override protected function showTemplate():void {
			for (var i:int=0; i<_elements.length; i++) SomaTween.start(_elements[i], null, {time:1, _autoAlpha:1, delay:i*.5});
			SomaTween.start(this, null, {time:0, delay:(i*.5), onComplete:endDisplay});
		}
		
		override protected function endDisplay():void {
			super.endDisplay();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function show():void {
			super.show();
		}

		override public function start():void {
			super.start();
		}
		
		override public function remove(e:Event = null):void {
			for (var i:int=0; i<_elements.length; i++) {
				SomaTween.start(_elements, null, {time:.7, _autoAlpha:0});
			}
			_timer = new Timer(700, 1);
			_timer.addEventListener(TimerEvent.TIMER, dispose);
			_timer.start();
			if (hasExternalAsset && Soma.getInstance().loader != null) {
				if (Soma.getInstance().loader.queue != null) {
					Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, elementComplete, false);
				}
				Soma.getInstance().loader.stop();
			}
		}
		
		override public function dispose(e:Event = null):void {
			_timer.removeEventListener(TimerEvent.TIMER, dispose);
			_timer = null;
			super.dispose();
		}
		
	}
	
}