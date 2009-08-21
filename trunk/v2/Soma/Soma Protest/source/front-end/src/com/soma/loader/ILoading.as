package com.soma.loader {
	
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
	 * <p><b>Usage:</b><br/>
	 * A loading <code>DisplayObject</code> can be inserted in a <code>SomaLoader</code> instance to show the progress of a loading.<br/>
	 * The loading class must implement <code>ILoading<code> to be accepted by the <code>SomaLoader</code> instance.</p>
	 * @example
	 * <listing version="3.0">
	 * var loader:SomaLoader = new SomaLoader();
	 * var myLoading:MyLoading = new MyLoading();
	 * addChild(myLoading);
	 * loader.loading = myLoading;
	 * </listing>
	 */

	public interface ILoading {
		
		/**
		 * Receives a <code>SomaLoaderEvent.START<code> event when a loading of an item starts.
		 * 
		 * @param event
		 */
		function itemStart(event:SomaLoaderEvent):void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.PROGRESS<code> event when a loading of an item progresses.
		 * 
		 * @param event
		 */
		function itemProgress(event:SomaLoaderEvent):void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.COMPLETE<code> event when a loading of an item is complete.
		 * 
		 * @param event
		 */
		function itemComplete(event:SomaLoaderEvent):void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.QUEUE_START<code> event when the loading of a list of items starts.
		 * 
		 * @param event
		 */
		function queueStart():void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.QUEUE_PROGRESS<code> event when the loading of a list of items progresses.
		 * 
		 * @param event
		 */
		function queueProgress(event:SomaLoaderEvent):void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.QUEUE_COMPLETE<code> event when the loading of a list of items is complete.
		 * 
		 * @param event
		 */
		function queueComplete():void;
		
		/**
		 * Receives a <code>SomaLoaderEvent.ERROR<code> event when an Error is dispatched by the <code>SomaLoader<code> instance.
		 * 
		 * @param event
		 */
		function error(event:SomaLoaderEvent):void;
		
	}

}