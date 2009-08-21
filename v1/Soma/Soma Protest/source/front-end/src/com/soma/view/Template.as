package com.soma.view {
	
	import flash.events.Event;	
	import flash.display.DisplayObjectContainer;	
	import com.soma.view.Page;
	import com.soma.events.TemplateEvent;
	import com.soma.interfaces.IRemovable;	import com.soma.interfaces.ITemplateable;

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
	
	public class Template implements IRemovable, ITemplateable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var page:Page;
		public var containerTarget:DisplayObjectContainer;
		public var elementList:Array;
		public var hasExternalAsset:Boolean;
		public var displayDispatched:Boolean;
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Template(page:Page, containerTarget:DisplayObjectContainer) {
			this.page = page;
			this.containerTarget = containerTarget;
			hasExternalAsset = false;
			displayDispatched = false;
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function init():void {
			elementList = [];
			for each (var element:XML in page.pageXML['content'].children()) {
				elementList.push(element);
				if (element.hasOwnProperty("@external") && element.@external == "true") {
					hasExternalAsset = true;
				}
			}
			
		}
		
		protected function startTemplate():void {
			show();
		}
		
		protected function showTemplate():void {
			endDisplay();
		}
		
		protected function endDisplay():void {
			if (!displayDispatched) {
				displayDispatched = true;
				new TemplateEvent(TemplateEvent.TEMPLATE_DISPLAYED, page).dispatch();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function start():void {
			startTemplate();
		}
		
		public function show():void {
			showTemplate();
		}
		
		public function remove(e:Event = null):void {
			dispose();
		}
		
		public function dispose(e:Event = null):void {
			new TemplateEvent(TemplateEvent.TEMPLATE_REMOVED, page).dispatch();
		}
		
	}
	
}