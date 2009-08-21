package com.soma.events {

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
	
	public class PageEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const SHOW_PAGE: String = "showPage";
		public static const PAGE_STARTED:String = "pageStarted";
		public static const PAGE_DISPLAYED:String = "pageDisplayed";
		public static const PAGE_REMOVED:String = "pageRemoved";
		public static const SHOW_EXTERNAL_LINK: String = "showExternalLink";
		public static const GET_EXCLUDED_PAGE: String = "getExcludedPage";		public static const GET_EXCLUDED_PAGE_PARENT: String = "getExcludedPageParent";
		
		public var pageID:String;
		public var pageExternalLink:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function PageEvent(type:String, pageID:String = "", pageExternalLink:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.pageID = pageID;
			this.pageExternalLink = pageExternalLink;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function clone():Event {
			return new PageEvent(type, pageID, pageExternalLink, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("PageEvent", "pageID", "pageExternalLink", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
