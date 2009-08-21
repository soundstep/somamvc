package com.soma.commands {
	import com.soma.Soma;
	import com.soma.control.CairngormEvent;
	import com.soma.events.ContentEvent;
	import com.soma.interfaces.ICommand;	

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
     * ContentCommand is executed by the SomaController instance and is the second Soma initialization step that needs the XML Site Definition.<br/><br/>
     * This is an internal command, it can be caught with an event listener but shouldn't be dispatched by other class than Soma.
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.ContentEvent ContentEvent
     * @see com.soma.model.ContentManager ContentManager
     */
	
	public class ContentCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a ContentCommand instance */
		public function ContentCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Executes a command.
		 * @param event Cairngorm event.
		 */
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case ContentEvent.LOADED:
					if (!Soma.getInstance().initialized) Soma.getInstance().contentLoaded();
					break;
			}
		}
		
	}
}
