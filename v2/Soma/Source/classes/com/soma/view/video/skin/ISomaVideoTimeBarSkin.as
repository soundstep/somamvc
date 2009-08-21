package com.soma.view.video.skin {
	import com.soma.view.video.controls.ISomaVideoSkin;

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
     * Interface meant to implemented by a DisplayObject class (such as Sprite) to skin a buffer/preloading/time bar skin and be added to the SomaVideoControls (somaVideoPlayerInstance.controls).
     * 
     * See the <a href="SomaVideoTimeBarSkin.html">SomaVideoTimeBarSkin</a> documentation to create your own buffer/preloading/time skin and the <a href="controls/SomaVideoControls.html">SomaVideoControls</a> documentation to add or create your own controls.
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.view.video.SomaVideo SomaVideo
     * @see com.soma.view.video.SomaVideoPlayer SomaVideoPlayer
     * @see com.soma.view.video.events.SomaVideoEvent SomaVideoEvent
     * @see com.soma.view.video.controls.SomaVideoControls SomaVideoControls
     * @see com.soma.view.video.skin.SomaVideoPlaySkin SomaVideoPlaySkin
     * @see com.soma.view.video.skin.SomaVideoTimeBarSkin SomaVideoTimeBarSkin
     * @see com.soma.view.video.skin.SomaVideoMuteSkin SomaVideoMuteSkin
     * @see com.soma.view.video.skin.SomaVideoFullscreenSkin SomaVideoFullscreenSkin
     */
	
	public interface ISomaVideoTimeBarSkin extends ISomaVideoSkin {
		
		/** Methods called whenever the video playhead is updated to display the current time and duration in seconds of the video.
		 * @param time A Number indicating the current time of the video playhead in seconds.
		 * @param duration A Number indicating the duration of the video (time length) in seconds.
		 */
		function timeCallBack(time:Number, duration:Number):void;
		/** Methods called whenever the video is preloading.
		 * @param bytesLoaded A Number indicating the number of bytes loaded.
		 * @param bytesTotal A Number indicating the total number of bytes to load.
		 */
		function preloadingCallBack(bytesLoaded:Number, bytesTotal:Number):void;
		/** Methods called whenever the video is buffering.
		 * @param length A Number indicating the current length of the buffer, this value must reach the time (max value) of the buffer to start to play.
		 * @param time A Number indicating the time of the buffer to reach in seconds (you can set this buffer time property with the SomaVideoPlayer instance property: bufferTime).
		 */
		function bufferCallBack(length:Number, time:Number):void;
		
	}
}
