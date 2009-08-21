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
     * <p>The type SHOW and SHOW_EXTERNAL_LINK are commands:</p>
     * <listing version="3.0">
new PageEvent(PageEvent.SHOW, "myPageID").dispatch();
new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, null, "http://www.soundstep.com/").dispatch();
new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, myPage.&#64;id, myPage.&#64;externalLink).dispatch();
     * </listing>
     * <p>The following types are not commands and the listeners can be added on the Soma class:</p>
     * <listing version="3.0">
Soma.getInstance().addEventListener(PageEvent.STARTED, eventHandler);
Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN, eventHandler);
Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN_COMPLETE, eventHandler);
Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT, eventHandler);
Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, eventHandler);
Soma.getInstance().addEventListener(PageEvent.EXCLUDED, eventHandler);
Soma.getInstance().addEventListener(PageEvent.EXCLUDED_PARENT, eventHandler);
     * </listing>
     * <p>The following types are not commands and are not dispatched by Soma.<br/>
     * The listeners must be added in a Page instance.
     * </p>
     * <listing version="3.0">
this.addEventListener(PageEvent.INITIALIZED, eventHandler);
this.addEventListener(PageEvent.CONTENT_PARSED, eventHandler);
this.addEventListener(PageEvent.CONTENT_LOADED, eventHandler);
     * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.commands.PageCommand PageCommand
     * @see com.soma.assets.NodeParser NodeParser
     */
	
	public class PageEvent extends CairngormEvent {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Soma command to display a page using the id from the XML Site Definition, use from anywhere in the code.<br/><br/>
		 * The parameter should the ID of the page (id attribute in the XML Site Definition)<br/><br/>
		 * new PageEvent(PageEvent.SHOW, "myPageID").dispatch();
	     */
		public static const SHOW:String = "com.soma.events.PageEvent.SHOW";
		/** Soma command to open a new browser window in case the page in the XML Site Definition is an external link, example:<br/><br/>
		 * &lt;page id="soundstep" externalLink="http://www.soundstep.com/"&gt;<br/>
		 *     &lt;title&gt;&lt;![CDATA[Soundstep]]&gt;&lt;/title&gt;<br/>
		 * &lt;/page&gt;<br/><br/>
		 * This event can be automatically dispatched by the Singleton MenuContext (right-click menu).<br/>
		 * Can also be used as a command from anywhere in the code:<br/><br/>
		 * new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, null, "http://www.soundstep.com/").dispatch();<br/>
		 * new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, myPage.&#64;id, myPage.&#64;externalLink).dispatch();
	     */
		public static const SHOW_EXTERNAL_LINK: String = "com.soma.events.PageEvent.SHOW_EXTERNAL_LINK";
		/** Indicates when a page is about to be instantiated by the PageManager instance (Soma.getInstance().page).<br/><br/>
		 * This event can be default prevented to stop the page manager to display and hide pages.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.STARTED, eventHandler);
	     */
		public static const STARTED:String = "com.soma.events.PageEvent.STARTED";
		/** Indicates when a page has been instantiated and is about to be displayed.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN, eventHandler);
	     */
		public static const TRANSITION_IN:String = "com.soma.events.PageEvent.TRANSITION_IN";
		/** Indicates when a page has been displayed.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN_COMPLETE, eventHandler);
	     */
		public static const TRANSITION_IN_COMPLETE:String = "com.soma.events.PageEvent.TRANSITION_IN_COMPLETE";
		/** Indicates when a page is about to be hidden.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT, eventHandler);
	     */
		public static const TRANSITION_OUT:String = "com.soma.events.PageEvent.TRANSITION_OUT";
		/** Indicates when a page has been hidden.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, eventHandler);
	     */
		public static const TRANSITION_OUT_COMPLETE:String = "com.soma.events.PageEvent.TRANSITION_OUT_COMPLETE";
		/** Indicates when an excluded page has been called.<br/><br/>
		 * See <a href=http://www.soundstep.com/somaprotest/www/#/page-system/excluded/"" target="_blank">Soma Protest Page Excluded</a> section.<br/><br/>
		 * Soma.getInstance().addEventListener(PageEvent.EXCLUDED, eventHandler);
	     */
		public static const EXCLUDED: String = "com.soma.events.PageEvent.EXCLUDED";
		/** Indicates when a page that contains excluded page children has been called.
		 * See <a href=http://www.soundstep.com/somaprotest/www/#/page-system/excluded/"" target="_blank">Soma Protest Page Excluded</a> section.<br/>
		 * Soma.getInstance().addEventListener(PageEvent.EXCLUDED_PARENT, eventHandler);
	     */
		public static const EXCLUDED_PARENT: String = "com.soma.events.PageEvent.EXCLUDED_PARENT";
		/** Indicates when a page bas been initialized (page added to stage and variables initialized).
		 * See <a href=http://www.soundstep.com/somaprotest/www/#/page-system/excluded/"" target="_blank">Soma Protest Page Excluded</a> section.<br/>
		 * this.addEventListener(PageEvent.INITIALIZED, eventHandler);
	     */
		public static const INITIALIZED:String = "com.soma.events.PageEvent.INITIALIZED";
		/** Indicates when the assets (in the content node of the page) have been parsed (assets that don't need to be loaded are ready).
		 * this.addEventListener(PageEvent.CONTENT_PARSED, eventHandler);
	     */
		public static const CONTENT_PARSED:String = "com.soma.events.PageEvent.CONTENT_PARSED";
		/** Indicates when the assets (in the content node of the page) have been loaded (assets instantiation and assets loading fully finished).
		 * this.addEventListener(PageEvent.CONTENT_PARSED, eventHandler);
	     */
		public static const CONTENT_COMPLETE:String = "com.soma.events.PageEvent.CONTENT_COMPLETE";
		
		/** id of the page (attribute id in a page node of the XML Site Definition).
		 * The id is also the Page name in the container of the pages (Soma.getInstance().page.container).
		 */
		public var id:String;
		/** Value of the link that will be open in a new browser window. */
		public var externalLink:String;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a PageEvent instance, the event can dispatch itself using the method dispatch (command).
		 * @param type The type of the event, accessible as PageEvent.type. 
		 * @param id The id of the background.
		 * @param externalLink The value of the link that will be open in a new browser window.
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function PageEvent(type:String, id:String = "", externalLink:String = "", bubbles:Boolean = true, cancelable:Boolean = false) {
			this.id = id;
			this.externalLink = externalLink;
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
			return new PageEvent(type, id, externalLink, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("PageEvent", "id", "externalLink", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispatch():Boolean {
			return super.dispatch();
		}
		
	}
}
