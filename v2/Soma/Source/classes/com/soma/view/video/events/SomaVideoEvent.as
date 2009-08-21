package com.soma.view.video.events {
	import com.soma.view.video.SomaVideo;

	import flash.events.Event;
	import flash.events.NetStatusEvent;

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
     * NetStatusEvent and SomaVideo events related to the NetConnection, NetStream and SomaVideo class. 
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.view.video.SomaVideo SomaVideo
     * @see com.soma.view.video.SomaVideoPlayer SomaVideoPlayer
     */
	
	public class SomaVideoEvent extends Event {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Indicates if the connection attempt succeeded (NetStatusEvent: NetConnection.Connect.Success). */
		public static const CONNECTION_SUCCESS: String = "com.soma.events.SomaVideoEvent.CONNECTION_SUCCESS";
		/** Indicates if the connection attempt failed (NetStatusEvent: NetConnection.Connect.Failed). */
		public static const CONNECTION_FAILED: String = "com.soma.events.SomaVideoEvent.CONNECTION_FAILED";
		/** Indicates if the connection attempt did not have permission to access the application (NetStatusEvent: NetConnection.Connect.Rejected). */
		public static const CONNECTION_REJECTED: String = "com.soma.events.SomaVideoEvent.CONNECTION_REJECTED";
		/** Indicates if playback has started (NetStatusEvent: NetStream.Play.Start). */
		public static const STREAM_STARTED: String = "com.soma.events.SomaVideoEvent.STREAM_STARTED";
		/** Indicates if playback has stopped (NetStatusEvent: NetStream.Play.Stop). */
		public static const STREAM_STOPPED: String = "com.soma.events.SomaVideoEvent.STREAM_STOPPED";
		/** Indicates if the seek operation is complete (NetStatusEvent: NetStream.Seek.Notify). */
		public static const SEEK_NOTIFY: String = "com.soma.events.SomaVideoEvent.SEEK_NOTIFY";
		/** Indicates if Data is not being received quickly enough to fill the buffer. Data flow will be interrupted until the buffer refills, at which time a NetStream.Buffer.Full message will be sent and the stream will begin playing again. (NetStatusEvent: NetStream.Buffer.Empty). */
		public static const BUFFER_EMPTY: String = "com.soma.events.SomaVideoEvent.BUFFER_EMPTY";
		/** Indicates if the buffer is full and that the stream will begin playing (NetStatusEvent: NetStream.Buffer.Full). */
		public static const BUFFER_FULL: String = "com.soma.events.SomaVideoEvent.BUFFER_FULL";
		/** Indicates if Data has finished streaming, and if the remaining buffer will be emptied (NetStatusEvent: NetStream.Buffer.Flush). */
		public static const BUFFER_FLUSH: String = "com.soma.events.SomaVideoEvent.BUFFER_FLUSH";
		/** Indicates if the FLV passed to the play() method can't be found (NetStatusEvent: NetStream.Play.StreamNotFound). */
		public static const STREAM_NOT_FOUND: String = "com.soma.events.SomaVideoEvent.STREAM_NOT_FOUND";
		/** Indicates a playhead time update while playing, the time value can be retrieve using the time property of the stream (somaVideoInstance.stream.time). */
		public static const PLAYHEAD_UPDATE: String = "com.soma.events.SomaVideoEvent.PLAYHEAD_UPDATE";
		/** Indicates a metaData object has been received, the information can be retrieved via different properties of the SomaVideo instance, or via the metaDataObject property. */
		public static const METADATA_UPDATE: String = "com.soma.events.SomaVideoEvent.METADATA_UPDATE";
		/** Indicates that the Video instance has been resized after receiving the metaData event, the resize process can be bypass using the enableAutoResizeOnMetaData property of the SomaVideo instance. */
		public static const ORIGINAL_SIZE_UPDATED: String = "com.soma.events.SomaVideoEvent.ORIGINAL_SIZE_UPDATED";
		/** Indicates an XMP data object has been received, the information can be retrieved the xmpDataObject property of the SomaVideo instance. */
		public static const XMPDATA_UPDATE: String = "com.soma.events.SomaVideoEvent.METADATA_UPDATE";
		
		/** Indicate when the video starts to play. */
		public static const PLAY: String = "com.soma.events.SomaVideoEvent.PLAY";
		/** Indicate when the video enter in a pause state. */
		public static const PAUSE: String = "com.soma.events.SomaVideoEvent.PAUSE";
		/** Indicate when the video is resumed. */
		public static const RESUME: String = "com.soma.events.SomaVideoEvent.RESUME";
		/** Indicates when the video is stopped. */
		public static const STOP: String = "com.soma.events.SomaVideoEvent.STOP";
		/** Indicates when the volume changed. */
		public static const VOLUME_CHANGED: String = "com.soma.events.SomaVideoEvent.VOLUME_CHANGED";
		/** Indicates when the fullscreen state changed. */
		public static const FULLSCREEN_CHANGED: String = "com.soma.events.SomaVideoEvent.FULLSCREEN_CHANGED";
		
		/** Indicates that the video starts preloading, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bytesLoaded, bytesTotal, preloadingPercentage). */
		public static const PRELOADING_START:String = "com.soma.events.SomaVideoEvent.PRELOADING_START";
		/** Indicates that the video is currently preloading, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bytesLoaded, bytesTotal, preloadingPercentage). */
		public static const PRELOADING_PROGRESS:String = "com.soma.events.SomaVideoEvent.PRELOADING_PROGRESS";
		/** Indicates that the preloading of the video is complete, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bytesLoaded, bytesTotal, preloadingPercentage). */
		public static const PRELOADING_COMPLETE:String = "com.soma.events.SomaVideoEvent.PRELOADING_COMPLETE";
		
		/** Indicates that the video starts buffering, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bufferLength, bufferTime, bufferPercentage). */
		public static const BUFFERING_START:String = "com.soma.events.SomaVideoEvent.BUFFERING_START";
		/** Indicates that the video is currently buffering, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bufferLength, bufferTime, bufferPercentage). */
		public static const BUFFERING_PROGRESS:String = "com.soma.events.SomaVideoEvent.BUFFERING_PROGRESS";
		/** Indicates that the buffering of the video is complete, you can retrieve the values from the SomaVideo or SomaVideoPlayer instance (bufferLength, bufferTime, bufferPercentage). */
		public static const BUFFERING_COMPLETE:String = "com.soma.events.SomaVideoEvent.BUFFERING_COMPLETE";
		
		/** Current SomaVideo instance that has dispatched the event. */
		public var player:SomaVideo;
		/** Current NetStatusEvent if the SomaVideoEvent is related to it. */
		public var netStatusEvent:NetStatusEvent;

		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a SomaVideoEvent instance.
		 * @param type The type of the event, accessible as ParserEvent.type. 
		 * @param player current SomaVideo instance.
		 * @param netStatusEvent current NetStatusEvent.
		 * @param bubbles Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false. 
		 * @param cancelable Determines whether the Event object can be canceled. The default values is false. 
	     * @inheritDoc
		 */
		public function SomaVideoEvent(type:String, player:SomaVideo, netStatusEvent:NetStatusEvent, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.player = player;
			this.netStatusEvent = netStatusEvent;
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
			return new SomaVideoEvent(type, player, netStatusEvent, bubbles, cancelable);
		}
		
		/** Returns a formatted string to display event information.
		 * @return A String.
		 */
		override public function toString():String {
			return formatToString("SomaVideoEvent", "player", "netStatusEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}
