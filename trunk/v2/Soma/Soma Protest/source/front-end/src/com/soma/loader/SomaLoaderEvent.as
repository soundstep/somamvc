package com.soma.loader {
	import flash.events.Event;	import flash.media.ID3Info;	
	/**
	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
	 * <b>Project host: </b><a href="http://code.google.com/p/somaloader/" target="_blank">http://code.google.com/p/somaloader/</a><br/>
	 * <b>Class version:</b> 1.0.2<br/>
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
	 * <p>The Original Code is SomaLoader.<br />
	 * The Initial Developer of the Original Code is Romuald Quantin.<br />
	 * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>
	 * 
	 * <p><b>Date:</b> 20 Feb 2009<br /></p>
	 * 
	 */
	
	public class SomaLoaderEvent extends Event {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Indicates a change in the queue.
	     * @eventType com.soma.loader.SomaLoaderEvent.QUEUE_CHANGED */
		public static const QUEUE_CHANGED: String = "com.soma.loader.SomaLoaderEvent.QUEUE_CHANGED";
		
		/** Indicates a status change in the SomaLoader instance (loading, paused, stopped).
	     * @eventType com.soma.loader.SomaLoaderEvent.STATUS_CHANGED */
		public static const STATUS_CHANGED: String = "com.soma.loader.SomaLoaderEvent.STATUS_CHANGED";
		
		/** Indicates a change in the cache.
	     * @eventType com.soma.loader.SomaLoaderEvent.CACHE_CHANGED */
		public static const CACHE_CHANGED: String = "com.soma.loader.SomaLoaderEvent.CACHE_CHANGED";
		
		/** Indicates an ID3 information is available when a mp3 starts to load.
	     * @eventType com.soma.loader.SomaLoaderEvent.ID3_COMPLETE */
		public static const ID3_COMPLETE: String = "com.soma.loader.SomaLoaderEvent.ID3_COMPLETE";
		
		/** Dispatched when an error has been found in the SomaLoader instance.
	     * @eventType com.soma.loader.SomaLoaderEvent.ERROR */
		public static const ERROR: String = "com.soma.loader.SomaLoaderEvent.ERROR";
		
		/** Dispatched when a loading of an item starts.
	     * @eventType com.soma.loader.SomaLoaderEvent.START */
		public static const START: String = "com.soma.loader.SomaLoaderEvent.START";
		
		/** Dispatched when a loading of an item progresses.
	     * @eventType com.soma.loader.SomaLoaderEvent.PROGRESS */
		public static const PROGRESS: String = "com.soma.loader.SomaLoaderEvent.PROGRESS";
		
		/** Dispatched when a loading of an item is complete.
	     * @eventType com.soma.loader.SomaLoaderEvent.COMPLETE */
		public static const COMPLETE: String = "com.soma.loader.SomaLoaderEvent.COMPLETE";
		
		/** Dispatched when the loading of a list of items starts.
		 * @eventType com.soma.loader.SomaLoaderEvent.QUEUE_START */
		public static const QUEUE_START: String = "com.soma.loader.SomaLoaderEvent.QUEUE_START";
		
		/** Dispatched when the loading of a list of items progresses.
		 * @eventType com.soma.loader.SomaLoaderEvent.QUEUE_PROGRESS */
		public static const QUEUE_PROGRESS: String = "com.soma.loader.SomaLoaderEvent.QUEUE_PROGRESS";
		
		/** Dispatched when the loading of a list of items is complete.
		 * @eventType com.soma.loader.SomaLoaderEvent.QUEUE_COMPLETE */
		public static const QUEUE_COMPLETE: String = "com.soma.loader.SomaLoaderEvent.QUEUE_COMPLETE";
		
		/** SomaLoader instance that has dispatched the current event. */
		public var loader:SomaLoader;
		
		/** Percentage value of the progress of the queue. */
		public var percentQueue:Number;
		
		/** Percentage value of the progress of the current item. */
		public var percentItem:Number;
		
		/** SomaLoaderItem instance that is currently loading. */
		public var item:SomaLoaderItem;
		
		/** Error message information. */
		public var errorMessage:String;
		
		/** Number of items loaded. */
		public var count:int;
				/** Number of items to load. */
		public var length:int;
		
		/** ILoading instance used in the SomaLoader instance to show the progress. */
		public var loading:ILoading;
		
		/** The number or bytes loaded when the listener processes the event. */
		public var bytesLoaded:Number;
		
		/** The total number of items or bytes that will be loaded if the loading process succeeds. */
		public var bytesTotal:Number;
		
		/** ID3Info instance dispatched when the current item is a MP3 and when the information is available. */
		public var id3Info:ID3Info;
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a SomaLoaderEvent object to pass as a parameter to event listeners.
		 * 
		 * @param type The type of event.
		 * @param bubbles Indicates whether an event is a bubbling event.
		 * @param cancelable Indicates whether the behavior associated with the event can be prevented.
		 */
		public function SomaLoaderEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Duplicates an instance of an SomaLoaderEvent.
		 */
		override public function clone():Event {
			var event:SomaLoaderEvent = new SomaLoaderEvent(type, bubbles, cancelable);
			event.loader = loader;
			event.percentQueue = percentQueue;			event.percentItem = percentItem;
			event.item = item;
			event.errorMessage = errorMessage;			event.count = count;			event.length = length;			event.loading = loading;			event.bytesLoaded = bytesLoaded;			event.bytesTotal = bytesTotal;			event.id3Info = id3Info;
			return event;
		}
		
		/**
		 * Returns a string containing all the properties of the SomaLoaderEvent object.
		 */
		override public function toString():String {
			return formatToString(
				"SomaLoaderEvent",
				"type",
				"loader",
				"percentQueue",
				"percentItem",
				"item",
				"errorMessage",
				"count",
				"length",
				"loading",
				"bytesLoaded",
				"bytesTotal",				"id3Info",
				"bubbles",
				"cancelable",
				"eventPhase"
			);
		}
		
	}
}
