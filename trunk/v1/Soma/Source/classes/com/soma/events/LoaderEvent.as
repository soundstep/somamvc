package com.soma.events {
	
	import com.soma.model.LoaderManager;	
	import com.soma.vo.LoaderItemVO;	
	import flash.events.Event;	
	import com.soma.control.CairngormEvent;
	
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
	
	public class LoaderEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const ADD_ITEM: String = "addItem";
		public static const START_LOADING:String = "startLoading";
		public static const STOP_LOADING:String = "stopLoading";
		
		public var loader:LoaderManager;
		public var loaderItem:LoaderItemVO;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function LoaderEvent(type:String, loader:LoaderManager, loaderItem:LoaderItemVO = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.loaderItem = loaderItem;
			this.loader = loader;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new LoaderEvent(type, loader, loaderItem, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("LoaderEvent", "loader", "loaderItem", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
