package com.soma.interfaces {

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
     * A page class that will be used by the PageManager instance must extend com.soma.view.Page and implements IPage.
     * IPage describes the entry point (transitionIn) and exit point (transitionOutComplete) in a page class.<br/><br/>
     * <b>Page display process</b>
     * 1. When the PageManager instantiates a page, it commands the page to be displayed calling the transitionIn method (a PageEvent.TRANSITION_IN is dispatched by the super class), in this method you can display the page elements the way you wish.
     * 2. When the page is fully displayed (display process: transition in), you must call the transitionInComplete and call the super class super.transitionInComplete() to end the display process, a PageEvent.TRANSITION_IN_COMPLETE is dispatched by the super class.<br/><br/>
     * <b>Page removing process</b>
     * 1. When a page is about to be removed, the PageManager will let you the time to do so by calling first a transitionOut method (a PageEvent.TRANSITION_OUT is dispatched by the super class), in this method you can hide and remove the page elements the way you wish. It is also a good place to destroy and remove instances and event listeners.
     * 2. When the elements are hidden or removed (remove process: transition out), you must call the transitionOutComplete and call the super class super.transitionOutComplete() to end the display process and allow the PageManager to display the next page (especially important is you're using pages with depths). A PageEvent.TRANSITION_OUT_COMPLETE is dispatched by the super class.<br/><br/>
     * Note: The proper way to initialize elements in a page is adding a listener PageEvent.INITIALIZED to the page class and build the elements in the Event handler.
     * Here is a simple example to hide and show a page with a tween library:
     * <listing version="3.0">
override public function transitionIn():void {
    Tweener.addTween(this, {time:1, alpha:1, onComplete:transitionInComplete});
}

override public function transitionInComplete():void {
    super.transitionInComplete();
}

override public function transitionOut():void {
    Tweener.addTween(this, {time:1, alpha:0, onComplete:transitionOutComplete});
}
		
override public function transitionOutComplete():void {
    super.transitionOutComplete();
}
     * </listing>
     * </p>
     * 
     * @see com.soma.model.PageManager
     * @see com.soma.view.Page
     * @see com.soma.events.PageEvent
     */
	
	public interface IPage {
		
		/** Called by the PageManager to display a page instantiated. */
		function transitionIn():void;
		/** Must be used to call the super.transitionInComplete() method and finish the display process. */
		function transitionInComplete():void;
		/** Called by the PageManager to remove a page. */
		function transitionOut():void;
		/** Must be used to call the super.transitionOutComplete() method and finish the removing process. */
		function transitionOutComplete():void;
		
	}
}
