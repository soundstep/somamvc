package com.soma.events {
	import com.soma.assets.NodeParser;		import flash.events.Event;	
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
     * NodeParser events to announce when the instance will parser XML nodes, when properties will be applied to an asset, when an external asset (external file) has been loaded and when the parser is fully finished with its tasks.<br/><br/>
     * The 4 events type WILL_SET_PROPERTIES, WILL_SET_BASEUI_PROPERTIES, WILL_PARSE and WILL_LOAD can be default prevented.
     * <listing version="3.0">
var parser:NodeParser = new NodeParser(Soma.getInstance().library);
parser.addEventListener(ParserEvent.WILL_PARSE, events);
parser.addEventListener(ParserEvent.WILL_LOAD, events);
parser.addEventListener(ParserEvent.WILL_SET_PROPERTIES, events);
parser.addEventListener(ParserEvent.WILL_SET_BASEUI_PROPERTIES, events);
parser.addEventListener(ParserEvent.ASSET_LOADED, events);
parser.addEventListener(ParserEvent.COMPLETE, events);
     * </listing>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.assets.NodeParser NodeParser
     * @see com.soma.assets.Library Library
     */
	
	public class ParserEvent extends Event {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Indicates when a NodeParser instance is about to apply properties found in the XML node to the asset created.<br/><br/>
		 * Can be default prevented: event.preventDefault().
		 * parser.addEventListener(ParserEvent.WILL_SET_PROPERTIES, eventHandler);
	     */
		public static const WILL_SET_PROPERTIES: String = "com.soma.events.ParserEvent.WILL_SET_PROPERTIES";
		/** Indicates when a NodeParser instance is about to apply BaseUI properties (such as top, right and so on) found in the XML node to the asset created.<br/><br/>
		 * Can be default prevented: event.preventDefault().
		 * parser.addEventListener(ParserEvent.WILL_SET_BASEUI_PROPERTIES, eventHandler);
	     */
		public static const WILL_SET_BASEUI_PROPERTIES: String = "com.soma.events.ParserEvent.WILL_SET_BASEUI_PROPERTIES";
		/** Indicates when a NodeParser instance is about to parse the XML nodes to create assets.<br/><br/>
		 * Can be default prevented: event.preventDefault().
		 * parser.addEventListener(ParserEvent.WILL_PARSE, eventHandler);
	     */
		public static const WILL_PARSE: String = "com.soma.events.ParserEvent.WILL_PARSE";
		/** Indicates when a NodeParser instance is about to load an external asset (external file such as an image).<br/><br/>
		 * Can be default prevented: event.preventDefault().
		 * parser.addEventListener(ParserEvent.WILL_LOAD, eventHandler);
	     */
		public static const WILL_LOAD: String = "com.soma.events.ParserEvent.WILL_LOAD";
		/** Indicates when an external asset (external file such as an image) has been loaded by the SomaLoader instance used with the NodeParser instance.<br/><br/>
		 * parser.addEventListener(ParserEvent.ASSET_LOADED, eventHandler);
	     */
		public static const ASSET_LOADED: String = "com.soma.events.ParserEvent.ASSET_LOADED";
		/** Indicates when a NodeParser instance is fully finished with its tasks (assets instantiated, loaded if necessary and properties applied).<br/><br/>
		 * parser.addEventListener(ParserEvent.COMPLETE, eventHandler);
	     */
		public static const COMPLETE: String = "com.soma.events.ParserEvent.COMPLETE";
		
		/** Instance of the current NodeParser instance that is dispatching the event. */
		public var parser:NodeParser;
		/** Current XML node that is (or will be) parsed. */
		public var node:XML;
		/** Asset instance created, it can be a DisplayObject, a SomaLoaderItem or anything. */
		public var asset:*;
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a ParserEvent instance.
		 * @param type The type of the event, accessible as ParserEvent.type. 
		 * @param parser current NodeParser instance.
		 * @param node current XML node.
		 * @param asset current asset.
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function ParserEvent(type:String, parser:NodeParser, node:XML = null, asset:* = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.parser = parser;			this.node = node;			this.asset = asset;
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
			return new ParserEvent(type, parser, node, asset, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("ParserEvent", "type", "parser", "node", "asset", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
