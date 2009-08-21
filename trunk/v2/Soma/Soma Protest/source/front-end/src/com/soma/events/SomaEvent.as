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
     * Framework events dispatched through a single dispatcher.<br/><br/>
     * <listing version="3.0">
Soma.getInstance().addEventListener(SomaEvent.LANGUAGE_CHANGED, eventHandler);
Soma.getInstance().addEventListener(SomaEvent.INITIALIZED, eventHandler);
     * </listing>
     * 
     * @see com.soma.Soma Soma
     */
	
	public class SomaEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Indicates when the Soma language URL string has been changed (see Soma class for more information).<br/><br/>
		 * Soma.getInstance().addEventListener(SomaEvent.LANGUAGE_CHANGED, eventHandler);
	     */
		public static const LANGUAGE_CHANGED:String = "com.soma.events.SomaEvent.LANGUAGE_CHANGED";
		/** Indicates when Soma has been fully initialized (this event will be triggered after the ContentEvent.LOADED).<br/><br/>
		 * Soma.getInstance().addEventListener(SomaEvent.INITIALIZED, eventHandler);
	     */
		public static const INITIALIZED:String = "com.soma.events.SomaEvent.INITIALIZED";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a SomaEvent instance.
		 * @param type The type of the event, accessible as SomaEvent.type. 
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function SomaEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
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
			return new SomaEvent(type, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("SomaEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispatch():Boolean {
			return super.dispatch();
		}
		
	}
}
