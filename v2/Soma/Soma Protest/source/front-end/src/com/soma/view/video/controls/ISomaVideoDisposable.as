package com.soma.view.video.controls {

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
     * This interface is meant to be implemented by a controller.
     * 
     * See the <a href="controls/SomaVideoControls.html">SomaVideoControls</a> documentation to add or create your own controls.
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
    
	public interface ISomaVideoDisposable {
		
		/** This method is internally called when you dispose a SomaVideoPlayer to remove children, the event listeners or whatever that needs to be destroyed to free the memory (make the instance elligible to the Garbage Collection). */
		function dispose():void;
		
	}
}
