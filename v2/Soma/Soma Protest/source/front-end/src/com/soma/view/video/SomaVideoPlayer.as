package com.soma.view.video {	import flash.geom.Rectangle;	import com.soma.view.video.controls.SomaVideoControls;	import com.soma.view.video.events.SomaVideoEvent;	import flash.display.Sprite;	import flash.display.StageDisplayState;	import flash.events.FullScreenEvent;	/**	 * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>     * <p><b>Information:</b><br/>     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>     * <b>Class version:</b> 2.0<br/>     * <b>Actionscript version:</b> 3.0</p>     * <p><b>Copyright:</b></p>     * <p>The contents of this file are subject to the Mozilla Public License<br />     * Version 1.1 (the "License"); you may not use this file except in compliance<br />     * with the License. You may obtain a copy of the License at<br /></p>     *      * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>     *      * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />     * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />     * See the License for the specific language governing rights and<br />     * limitations under the License.<br /></p>     *      * <p>The Original Code is Soma.<br />     * The Initial Developer of the Original Code is Romuald Quantin.<br />     * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>     *      * <p><b>Usage:</b><br/>     * SomaVideoPlayer is a wrapper that is containing 2 layers: the video (playerInstance.video) and the skinned controls (playerInstance.controls).     * The controls layers is a instance of the SomaVideoControls and will handle controls such play/pause, timebar, mute, and so on. SomaVideoPlayer is providing basic skinned controls by default but your can add your own. <br/><br/>     * <b>Simple video player with a default skin.</b>     * <listing version="3.0">var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");addChild(player);     * </listing>     * <b>Simple video player with only a mute button and a time bar control.</b>     * <listing version="3.0">var controls:SomaVideoControls = new SomaVideoControls();controls.addControl(new SomaVideoMuteSkin());controls.addControl(new SomaVideoTimeBarSkin());var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv", controls);addChild(player);     * </listing>     * <b>Simple video player with some controls options changed.</b>     * <listing version="3.0">var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");player.controls.alignBottom = false;player.controls.backgroundColor = 0xFF0000;player.controls.backgroundAlpha = .5;player.controls.margin = 5;player.controls.sitOnVideo = false;addChild(player);     * </listing>     * <b>Simple video player with soma controls that does not fit with the video (you have the control of the SomaVideoControls class).</b>     * <listing version="3.0">var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");player.controls.fitToVideo = false;player.controls.backgroundColor = 0xFF0000;player.controls.backgroundAlpha = .5;player.controls.x = 10;player.controls.y = 10;player.controls.width = 200;addChild(player);     * </listing>     * <b>Change a specific default skin option.</b><br/>     * The skin class created by default and you can retrieve using the getControl methods are:     * <ul>     * 	<li>SomaVideoPlaySkin</li>     * 	<li>SomaVideoTimeBarSkin</li>     * 	<li>SomaVideoMuteSkin</li>     * 	<li>SomaVideoFullscreenSkin</li>     * </ul>     * <listing version="3.0">var player:SomaVideoPlayer = new SomaVideoPlayer("video/video.flv");var timebar:SomaVideoTimeBarSkin = player.controls.getControl(SomaVideoTimeBarSkin) as SomaVideoTimeBarSkin;timebar.barHeight = 5;timebar.backgroundColor = 0xFF0000;timebar.backgroundAlpha = .5;timebar.timeBarColor = 0x0000FF;addChild(player);     * </listing>     * See the <a href="controls/SomaVideoControls.html">SomaVideoControls</a> documentation to create your own controls.     *      * @see com.soma.Soma Soma     * @see com.soma.view.video.SomaVideo SomaVideo     * @see com.soma.view.video.events.SomaVideoEvent SomaVideoEvent     * @see com.soma.view.video.controls.SomaVideoControls SomaVideoControls     * @see com.soma.view.video.skin.SomaVideoPlaySkin SomaVideoPlaySkin     * @see com.soma.view.video.skin.SomaVideoTimeBarSkin SomaVideoTimeBarSkin     * @see com.soma.view.video.skin.SomaVideoMuteSkin SomaVideoMuteSkin     * @see com.soma.view.video.skin.SomaVideoFullscreenSkin SomaVideoFullscreenSkin     */		public class SomaVideoPlayer extends Sprite {		//------------------------------------		// private, protected properties		//------------------------------------				private var _url:String;		private var _autoStart:Boolean;		private var _loop:Boolean;		private var _smoothing:Boolean;				private var _video:SomaVideo;		private var _controls:SomaVideoControls;				private var _videoWidth:Number;		private var _videoHeight:Number;		private var _bypassDrawing:Boolean;				private var _fullscreenRect:Rectangle;				private var _videoInitialized:Boolean;				private var _fullscreen:Boolean;				//------------------------------------		// public properties		//------------------------------------				//------------------------------------		// constructor		//------------------------------------				/** Create a SomaVideoPlayer instance.		 * @param url A String (url), video that will be played (you can also use the playerInstance.setSource).		 * @param controls A SomaVideoControlsInstance (an instance with a default skin will be created if you don't pass one in the constructor). 		 * @param autoStart Specifies whether the video will start to play once ready.		 * @param loop Specifies whether the video will replay from the beginning at the end of the video.		 */		public function SomaVideoPlayer(url:String = null, controls:SomaVideoControls = null, autoStart:Boolean = true, loop:Boolean = false) {			_url = url;			_controls = controls;			_autoStart = autoStart;			_loop = loop;			init();		}		//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________				/** @private */		protected function init():void {			_videoInitialized = false;			_video = addChild(new SomaVideo(_url)) as SomaVideo;			_video.addEventListener(SomaVideoEvent.METADATA_UPDATE, videoInitializeHandler, false, 0, true);			_video.loop = _loop;			initControls();			if (_autoStart) _video.play();		}				/** @private */		protected function initControls():void {			if (_controls == null) {				_controls = new SomaVideoControls();				_controls.setDefaultSkin();			}			addChild(_controls);			_controls.initialize(this);			if (!_controls.fitToVideo) _controls.draw();			if (_controls.fitToVideo) _controls.visible = false;		}		/** @private */		protected function videoInitializeHandler(e:SomaVideoEvent):void {			if (_controls.fitToVideo) {				if (!isNaN(_videoWidth) && _videoWidth != 0) {					_controls.width = _videoWidth;				}				else {					_controls.width = _video.width;				}			}			_controls.draw();			_controls.visible = true;		}		/** @private */		protected function fullScreenHandler(e:FullScreenEvent):void {			if (stage != null) {				stage.removeEventListener(FullScreenEvent.FULL_SCREEN, fullScreenHandler);				_fullscreen = false;				dispatchEvent(new SomaVideoEvent(SomaVideoEvent.FULLSCREEN_CHANGED, this.video, null));			}		}				// PUBLIC		//________________________________________________________________________________________________				/** Call this method when you dispose a SomaVideoPlayer to remove children, event listeners or whatever that needs to be destroyed to free the memory (make the instance elligible to the Garbage Collection). */		public function dispose():void {			if (_video != null) {				_video.removeEventListener(SomaVideoEvent.METADATA_UPDATE, videoInitializeHandler, false);				_video.dispose();			}			if (_controls != null) {				_controls.dispose();			}			while (numChildren > 0) {				removeChildAt(0);			}		}				/** Get the SomaVideo instance used to display the video.		 * @return A SomaVideo instance.		 */		public function get video():SomaVideo {			return _video;		}				/** Get the SomaVideoControls instance used to display the controls (play, mute, time bar, and so on).  		 * @return A SomaVideoControls instance;		 */		public function get controls():SomaVideoControls {			return _controls;		}				/** Set the source to play.		 * <listing version="3.0">var player:SomaVideoPlayer = new SomaVideoPlayer();video.setSource("video.flv");		 * </listing>		 * @param url A String (URL).		 */		public function setSource(url:String):void {			_url = url;			_video.setSource(_url);		}				/** Pause the video. */		public function pause():void {			_video.pause();		}				/** Resume the video. */		public function resume():void {			_video.resume();		}				/** Stop the video. */		public function stop():void {			_video.stop();		}				/** Play the video. */		public function play():void {			_video.play();		}				/** Specifies whether the video will replay on its own when it reaches the end. */		public function get loop():Boolean {			return _video.loop;		}				public function set loop(loop:Boolean):void {			_video.loop = loop;		}				/** Get the current position of the playhead.		 * @return A Number (seconds).		 */		public function get time():Number {			return _video.time;		}				/** Get the time length (seconds) of the video, only available after that an event SomaVideoEvent.METADATA_UPDATE has been dispatched.		 * @return A Number (seconds).		 */		public function get duration():Number {			return _video.duration;		}				/** Move the video playhead to a (approximate) time. 		 * @param offset The approximate time value, in seconds, to move to in a video file. 		 */		public function seek(time:Number):void {			_video.seek(time);		}				/** Volume of the video, the range is 0 to 1 and the default is 1. */		public function get volume():Number {			return _video.volume;		}				public function set volume(value:Number):void {			_video.volume = value;		}				/** Pan (panning) of the video, the range is -1 (for left) to 1 (for right) and the default is 0. */		public function get pan():Number {			return _video.pan;		}				public function set pan(value:Number):void {			_video.pan = value;		}				/** Specifies whether the video will automatically start playing once ready. */		public function get autoStart():Boolean {			return _autoStart;		}				/** Get the url of the video.		 * @return A String.		 */		public function get url():String {			return _url;		}				/** State of the fullscreen mode.		 * @return A Boolean.		 */		public function get fullscreen():Boolean {			return _fullscreen;		}				public function set fullscreen(value:Boolean):void {			if (stage == null) return;			try {				_fullscreen = value;				if (_fullscreen) {					stage.fullScreenSourceRect = (_fullscreenRect == null) ? getBounds(stage) : _fullscreenRect;					stage.displayState = StageDisplayState.FULL_SCREEN;					stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullScreenHandler);				}				else {					stage.fullScreenSourceRect = null;					stage.displayState = StageDisplayState.NORMAL;				}				dispatchEvent(new SomaVideoEvent(SomaVideoEvent.FULLSCREEN_CHANGED, this.video, null));			} catch (e:Error) {				if (String(e.message).indexOf("Full screen mode is not allowed") != -1) {					trace("Error in SomaVideoPlayer: ", e.message, " The parameter allowFullScreen='true' is probably missing in the HTML page that is embedding the Flash file.");				}				else trace("Error in SomaVideoPlayer: ", e.message);			}		}				/** Indicates the width of the SomaVideoPlayer instance, in pixels. This methods is overridden to handle the controls and video resize.		 * @param value A Number.		 */		override public function set width(value:Number):void {			_videoWidth = value;			_video.enableAutoResizeOnMetaData = false;			_video.width = value;			if (_controls.fitToVideo) _controls.width = _videoWidth;			if (!_bypassDrawing) _controls.draw();		}				/** Indicates the height of the SomaVideoPlayer instance, in pixels. This methods is overridden to handle the controls and video resize.		 * @param value A Number.		 */		override public function set height(value:Number):void {			_videoHeight = value;			_video.enableAutoResizeOnMetaData = false;			if (!_controls.fitToVideo) _video.height = value;			else if (_controls.sitOnVideo) _video.height = value;			else _video.height = value - _controls.height;			if (!_bypassDrawing) _controls.draw();		}				/** Indicates the width of the video (not the player). */		public function get videoWidth():Number {			return _videoWidth;		}				public function set videoWidth(value:Number):void {			_videoWidth = value;			_video.enableAutoResizeOnMetaData = false;			_video.width = _videoWidth;			if (_controls.fitToVideo) _controls.width = _videoWidth;			if (!_bypassDrawing) _controls.draw();		}				/** Indicates the height of the video (not the player). */		public function get videoHeight():Number {			return _videoHeight;		}				public function set videoHeight(value:Number):void {			_videoHeight = value;			_video.enableAutoResizeOnMetaData = false;			_video.height = _videoHeight;			_controls.draw();		}				/** Set the width of the video (not the player), the height will be updated keeping the ratio of the video source.		 * This action can be performed only when the size of the video source is known, in other words, after receiving the metadata information (SomaVideoEvent.METADATA_UPDATE).		 * <listing version="3.0">_player = new SomaVideoPlayer("video/test.flv");_player.addEventListener(SomaVideoEvent.METADATA_UPDATE, metadataHandler);private function metadataHandler(e:SomaVideoEvent):void {    _player.widthVideoKeepingRatio(100);} 		 * </listing>		 * @param value A Number.		 */		public function widthVideoKeepingRatio(value:Number):void {			if (isNaN(_video.widthVideoSource)) throw new Error("Error in SomaVideoPlayer.widthVideoKeepingRatio: The source video size is unknown at this state, you must use this method after a SomaVideoEvent.METADATA_UPDATE event has been dispatched.");			_videoWidth = value;			var ratio:Number = _video.widthVideoSource / _video.heightVideoSource;            _videoHeight = _videoWidth / ratio;			_video.width = _videoWidth;			_video.height = _videoHeight;			if (_controls.fitToVideo) _controls.width = _videoWidth;			_controls.draw();		}		/** Set the height of the video (not the player), the width will be updated keeping the ratio of the video source.		 * This action can be performed only when the size of the video source is known, in other words, after receiving the metadata information (SomaVideoEvent.METADATA_UPDATE).		 * <listing version="3.0">_player = new SomaVideoPlayer("video/test.flv");_player.addEventListener(SomaVideoEvent.METADATA_UPDATE, metadataHandler);private function metadataHandler(e:SomaVideoEvent):void {    _player.widthVideoKeepingRatio(100);} 		 * </listing>		 * @param value A Number.		 */		public function heightVideoKeepingRatio(value:Number):void {			if (isNaN(_video.widthVideoSource)) throw new Error("Error in SomaVideoPlayer.heightVideoKeepingRatio: The source video size is unknown at this state, you must use this method after a SomaVideoEvent.METADATA_UPDATE event has been dispatched.");			_videoHeight = value;			var ratio:Number = _video.widthVideoSource / _video.heightVideoSource;			_videoWidth = _videoHeight * ratio;			_video.width = _videoWidth;			_video.height = _videoHeight;			if (_controls.fitToVideo) _controls.width = _videoWidth;			_controls.draw();		}				/** Specifies whether the video should be smoothed (interpolated) when it is scaled. */		public function get smoothing():Boolean {			return _video.smoothing;		}				public function set smoothing(value:Boolean):void {			_smoothing = value;			_video.smoothing = _smoothing;		}				/** Get the bytes loaded of the video (preloading), you can get the information on a SomaVideoEvent.PRELOADING_START,  SomaVideoEvent.PRELOADING_PROGRESS and  SomaVideoEvent.PRELOADING_COMPLETE event. */		public function get bytesLoaded():Number {			return _video.bytesLoaded;		}				/** Get the bytes total that the video will preload, you can get the information on a SomaVideoEvent.PRELOADING_START,  SomaVideoEvent.PRELOADING_PROGRESS and  SomaVideoEvent.PRELOADING_COMPLETE event.		 * @return A Number.		 */		public function get bytesTotal():Number {			return _video.bytesTotal;		}				/** Get the percentage of the video that is preloaded (0 to 100), you can get the information on a SomaVideoEvent.PRELOADING_START,  SomaVideoEvent.PRELOADING_PROGRESS and  SomaVideoEvent.PRELOADING_COMPLETE event.		 * @return A Number.		 */		public function get preloadingPercent():Number {			return _video.preloadingPercentage;		}				/** Buffer value in seconds, the default (flash built-in default of the NetStream class) is 0.1 (tenth of a second). */		public function get bufferTime():Number {			return _video.bufferTime;		}				public function set bufferTime(value:Number):void {			_video.bufferTime = value;		}		/** Get the length in seconds of the buffer, the "buffer length" will reach the "buffer time" before playing the video, you can get the information on a SomaVideoEvent.BUFFERING_START,  SomaVideoEvent.BUFFERING_PROGRESS and  SomaVideoEvent.BUFFERING_COMPLETE event.		 * @return A Number.		 */		public function get bufferLength():Number {			return _video.bufferLength;		}				/** Get the percentage of the buffer (seconds loaded), the "buffer length" will reach the "buffer time" before playing the video, you can get the information on a SomaVideoEvent.BUFFERING_START,  SomaVideoEvent.BUFFERING_PROGRESS and  SomaVideoEvent.BUFFERING_COMPLETE event.		 * @return A Number.		 */		public function get bufferPercentage():Number {			return _video.bufferPercentage;		}				/** Rectangle used to display the video in a fullscreen state, the default rectangle is the player itself.  */		public function get fullscreenRect():Rectangle {			return _fullscreenRect;		}				public function set fullscreenRect(fullscreenRect:Rectangle):void {			_fullscreenRect = fullscreenRect;		}	}}