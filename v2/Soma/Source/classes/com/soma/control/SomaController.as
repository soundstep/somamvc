package com.soma.control {
	import com.soma.commands.BackgroundCommand;
	import com.soma.commands.ContentCommand;
	import com.soma.commands.MenuCommand;
	import com.soma.commands.PageCommand;
	import com.soma.control.FrontController;
	import com.soma.events.BackgroundEvent;
	import com.soma.events.ContentEvent;
	import com.soma.events.MenuEvent;
	import com.soma.events.PageEvent;	

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
     * SomaController is the internal controller used by the framework.<br/><br/>
     * The command registered are:
     * <ul>
     *     <li>ContentEvent.LOADED</li>
     *     <li>ContentEvent.UPDATED</li>
     *     <li>PageEvent.SHOW</li>
     *     <li>PageEvent.SHOW_EXTERNAL_LINK</li>
     *     <li>PageEvent.TRANSITION_IN_COMPLETE</li>
     *     <li>PageEvent.TRANSITION_OUT_COMPLETE</li>
     *     <li>BackgroundEvent.SHOW</li>
     *     <li>BackgroundEvent.HIDE</li>
     *     <li>MenuEvent.OPEN_MENU</li>
     * </ul>
     * You can extend the FrontController to create your own controller. 
     * Soma Singleton can be extended to overwrite the initController methods to add your own (not a requirement, you controller class can be initialized anywhere).<br/><br/>
     * The SomaController is a static class and can be used to add your own commands (SomaController.addCommand).
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.control.FrontController FrontController
     */
	
	public class SomaController extends FrontController {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a SomaController instance but makes no sense (static class) */
		public function SomaController() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Initializes the controller and add the commands to the FrontController.
		 */
		public static function init():void {
			//content
			addCommand(ContentEvent.LOADED, ContentCommand);
			addCommand(ContentEvent.UPDATED, ContentCommand);
			//page
			addCommand(PageEvent.SHOW, PageCommand);
			addCommand(PageEvent.SHOW_EXTERNAL_LINK, PageCommand);
			addCommand(PageEvent.TRANSITION_IN_COMPLETE, PageCommand);
			addCommand(PageEvent.TRANSITION_OUT_COMPLETE, PageCommand);
			//background
			addCommand(BackgroundEvent.SHOW, BackgroundCommand);
			addCommand(BackgroundEvent.HIDE, BackgroundCommand);
			//menu
			addCommand(MenuEvent.OPEN_MENU, MenuCommand);
		}
		
		/** @inheritDoc */
		public static function addCommand(commandName:String, commandRef:Class, useWeakReference:Boolean = true):void {
			FrontController.addCommand(commandName, commandRef, useWeakReference);
		}
		
		/** @inheritDoc */
		public static function removeCommand(commandName:String):void {
			FrontController.removeCommand(commandName);
		}
		
		/** @inheritDoc */
		protected static function executeCommand(event:CairngormEvent):void {
			FrontController.executeCommand(event);
		}
		
		/** @inheritDoc */
		protected static function getCommand(commandName:String):Class {
			return FrontController.getCommand(commandName);
		}
		
	}
}
