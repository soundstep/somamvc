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
     * Framework events dispatched through a single dispatcher related to the MenuManager (Soma.getInstance().menu).<br/><br/>
	 * Soma command that will be received by the user's custom menu (IMenu) to update the state of this menu when a new page is about to be displayed.<br/><br/>
	 * This event is automatically dispatched by the PageManager instance in some case, such as a URL change (Soma.getInstance().page).<br/><br/>
	 * Can also be used as a command from anywhere in the code, the parameter should be the ID of the page (id attribute in the XML Site Definition):<br/><br/>
     * <p>The type OPEN_MENU can be used as a command and the listener can be added on the Soma class:</p>
     * <listing version="3.0">
     * // command
     * new MenuEvent(MenuEvent.OPEN_MENU, "myPageID").dispatch();
     * // listener
	 * Soma.getInstance().addEventListener(MenuEvent.OPEN_MENU, eventHandler);
     * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.model.MenuManager MenuManager
     * @see com.soma.commands.MenuCommand MenuCommand
     */
	
	public class MenuEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Soma command to update a user's menu state. */
		public static const OPEN_MENU: String = "com.soma.events.MenuEvent.OPEN_MENU";
		
		/** id that will be used to update a menu state, ideally it should be the id of a page (id attribute in the XML Site Definition). */
		public var id:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a MenuEvent instance, the event can dispatch itself using the method dispatch (command).
		 * @param type The type of the event, accessible as ContentEvent.type. 
		 * @param id The id of the background (ideally id of a page but can be custom).
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function MenuEvent(type:String, id:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
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
			return new MenuEvent(type, id, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("MenuEvent", "id", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispatch():Boolean {
			return super.dispatch();
		}
		
	}
}
