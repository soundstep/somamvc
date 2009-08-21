package com.soma.events {

	import flash.events.Event;	
	import com.soma.control.CairngormEvent;
	
	/**
     * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0<br/>
     * <b>Actionscript version:</b> 3.0</p>
     * <p><b>Copyright:</b></p>
     * <p>The contents of this file are subject to the Mozilla Public License<br />
     * Version 1.1 (the "License"); you may not use this file except in compliance<br />
     * with the License. You may obtain a copy of the License at<br /></p>
     * 
     * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>
     * 
     * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />
     * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />
     * See the License for the specific language governing rights and<br />
     * limitations under the License.<br /></p>
     * 
     * <p>The Original Code is Soma.<br />
     * The Initial Developer of the Original Code is Romuald Quantin.<br />
     * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>
     * 
     * <p><b>Usage:</b><br/>
     * Framework events dispatched through a single dispatcher related to the BackgroundManager (Soma.getInstance().background).<br/><br/>
     * The type SHOW and HIDE are commands:
     * </p>
     * <listing version="3.0">
	 * new BackgroundEvent(BackgroundEvent.SHOW, "myBackground").dispatch();
	 * new BackgroundEvent(BackgroundEvent.HIDE, "myBackground").dispatch();
     * </listing>
     * <p>The type TRANSITION_IN and TRANSITION_OUT are not commands and the listeners can be added on the Soma class (can be default prevented):</p>
     * <listing version="3.0">
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_IN, eventHandler);
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_OUT, eventHandler);
     * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.model.BackgroundManager BackgroundManager
     * @see com.soma.commands.BackgroundCommand BackgroundCommand
     */
	
	public class BackgroundEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Soma command to display a background using the id from the XML Site Definition, use from anywhere in the code:<br/><br/>
		 * The parameter should the ID of the background (id attribute in the XML Site Definition)<br/><br/>
		 * new BackgroundEvent(BackgroundEvent.SHOW, "myBackground").dispatch();
	     */
		public static const SHOW: String = "com.soma.events.BackgroundEvent.SHOW";
		/** Soma command to display a background using the id from the XML Site Definition, use from anywhere in the code:<br/><br/>
		 * The parameter should the ID of the background (id attribute in the XML Site Definition)<br/><br/>
		 * new BackgroundEvent(BackgroundEvent.HIDE, "myBackground").dispatch();
	     */
		public static const HIDE:String = "com.soma.events.BackgroundEvent.HIDE";
		/** Indicates when a background is about to be displayed by the BackgroundManager instance (Soma.getInstance().background).<br/><br/>
		 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_IN, eventHandler);
	     */
		public static const TRANSITION_IN: String = "com.soma.events.BackgroundEvent.TRANSITION_IN";
		/** Indicates when a background is about to be hidden by the BackgroundManager instance (Soma.getInstance().background).<br/><br/>
		 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_OUT, eventHandler);
	     */
		public static const TRANSITION_OUT: String = "com.soma.events.BackgroundEvent.TRANSITION_OUT";
		
		/**
		 * id of the background (attribute id in a node child of the backgrounds node of the XML Site Definition).
		 * The id is also the DisplayObject name in the container of the backgrounds (Soma.getInstance().background.container).
		 */
		public var id:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a BackgroundEvent instance, the event can dispatch itself using the method dispatch (command).
		 * @param type The type of the event, accessible as BackgroundEvent.type. 
		 * @param id The id of the background.
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function BackgroundEvent(type:String, id:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.id = id;
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Duplicates an instance of an Event subclass.<br/><br/>
		 * Returns a new Event object that is a copy of the original instance of the Event object. You do not normally call clone(); the EventDispatcher class calls it automatically when you redispatch an event—that is, when you call dispatchEvent(event) from a handler that is handling event.<br/><br/>
		 * The new Event object includes all the properties of the original.
 		 * @return A new Event object that is identical to the original. 
		 */
		override public function clone():Event {
			return new BackgroundEvent(type, id, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("BackgroundEvent", "id", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispatch():Boolean {
			return super.dispatch();
		}
	}
}
