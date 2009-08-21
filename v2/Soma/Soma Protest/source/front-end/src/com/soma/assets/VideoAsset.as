package com.soma.assets {
	import com.soma.view.video.SomaVideo;
	import com.soma.view.video.events.SomaVideoEvent;
	import com.soma.interfaces.IAsset;
	import com.soma.utils.SomaUtils;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	
	import flash.display.DisplayObject;		

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
     * Used by the NodeParser class to instantiate a SomaText instance.<br/><br/>
	 * <b>node name: video</b> creates a SomaVideo instance.<br/>
	 * &lt;video id="myVideo" url="video.flv" x="50" alpha=".5" verticalCenter="0" volume="0" /&gt;<br/><br/>
     * </p>
     * 
     * @see com.soma.assets.Library Library
     * @see com.soma.assets.NodeParser NodeParser
     * @see com.soma.assets.AssetFactory AssetFactory
     * @see com.soma.view.SomaVideo SomaVideo
     * @see com.soma.interfaces.IAsset IAsset
    */
	
	public class VideoAsset implements IAsset {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		// SomaVideo instance created
		private var _video:SomaVideo;
		// node used to create the SomaVideo instance
		private var _node:XML;
		// baseUI instance used to handle layout properties
		private var _baseUI:BaseUI;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates an VideoAsset instance, it should not be used as it should be instantiated by a NodeParser class. */
		public function VideoAsset() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private */
		protected function started(e:SomaVideoEvent):void {
			_video.removeEventListener(SomaVideoEvent.STREAM_STARTED, started);
			var video:SomaVideo = e.currentTarget as SomaVideo;
			SomaUtils.setBaseUIProperties(video, _baseUI, _node);
		}
		
		/** @private */
		private function originalSizeUpdated(e:SomaVideoEvent):void {
			_video.removeEventListener(SomaVideoEvent.ORIGINAL_SIZE_UPDATED, originalSizeUpdated);
			if (_baseUI != null && _baseUI.contains(_video)) {
				var el:ElementUI = _baseUI.getElement(_video);
				el.initialWidth = e.player.widthVideoSource;
				el.initialHeight = e.player.heightVideoSource;
				el.useInitialSize = true;
				el.forceRefresh();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Parse a XML node to create and return a SomaVideo instance. Class specific properties (such as volume for a SomaVideo instance) and BaseUI properties (such as horizontalCenter) will also be parsed and applied to the asset.
		 * @param node node XML describing the asset.
		 * @param baseUI BaseUI instance (if existing) that will handle the asset.
		 */
		public function instantiate(node:XML, baseUI:BaseUI = null):DisplayObject {
			_node = node;
			_baseUI = baseUI;
			_video = new SomaVideo(_node.@url);
			_video.name = _node.@id;
			_video.addEventListener(SomaVideoEvent.STREAM_STARTED, started);
			_video.addEventListener(SomaVideoEvent.ORIGINAL_SIZE_UPDATED, originalSizeUpdated);
			SomaUtils.setProperties(_video, _node, ["url"]);
			return _video;
		}
		
	}
}