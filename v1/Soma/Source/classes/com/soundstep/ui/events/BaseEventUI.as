package com.soundstep.ui.events {
	
	import flash.events.Event;
	import com.soundstep.ui.ElementUI;
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 3.0.2<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Creative Commons Attribution-ShareAlike 3.0 Unported License<br /> 
	 * <a href="http://creativecommons.org/licenses/by-sa/3.0/" target="_blank">http://creativecommons.org/licenses/by-sa/3.0/</a><br />
	 * You can use BaseUI in any flash site, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.<br />
	 * <br />
	 * <b>Date:</b> 08-2008<br />
	 */
	
	public class BaseEventUI extends Event {
		
		//------------------------------------
		// private properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/**
		 * Dispatch from a BaseUI instance<br />
	     * Indicates a DisplayObject has been added to the BaseUI instance
	     * @eventType elementAdded
	     */
		public static const ADDED:String = "elementAdded";
		
		/**
		 * Dispatch from a BaseUI instance<br />
	     * Indicates a DisplayObject has been removed from the BaseUI instance
	     * @eventType elementRemoved
	     */
		public static const REMOVED:String = "elementRemoved";
		
		/**
		 * Dispatch from a ElementUI instance<br />
	     * Indicates a DisplayObject has been updated
	     * @eventType elementUpdated
	     */
		public static const UPDATED:String = "elementUpdated";
		
		/**
		 * Dispatch from a ElementUI instance<br />
	     * Object containing the properties of the DisplayObject that will be updated
	     * @eventType beforeUpdate
	     */
		public static const BEFORE_UPDATE:String = "beforeUpdate";
		
		/**
		 * Instance of the ElementUI
	     */
		public var elementUI:ElementUI;
		/**
		 * Object containing the properties of the DisplayObject that will be updated
	     */
		public var properties:Object;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * @param type The event type; indicates the action that triggered the event.
		 * @param elementUI Instance of the ElementUI class
		 * @param bubbles Specifies whether or not the event can bubble up the display list hierarchy.
		 * @param cancelable Specifies whether or not the behavior associated with the event can be prevented.
		 */
		public function BaseEventUI(type:String, elementUI:ElementUI, properties:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this.elementUI = elementUI;
			this.properties = properties;
		}
		
		//
		// PRIVATE
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Create an instance of the BaseEventUI class
		 * @return Event
		 */
		public override function clone():Event {
			return new BaseEventUI(type, elementUI, properties, bubbles, cancelable);
		}
		
		/**
		 * @return String
		 */
		public override function toString():String {
			return formatToString("BaseEventUI", "elementUI", "properties", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}

}