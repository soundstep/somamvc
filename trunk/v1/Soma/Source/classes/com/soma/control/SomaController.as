package com.soma.control {
	import com.soma.events.TransitionEvent;	
	import com.soma.commands.TransitionCommand;	
	import com.soma.events.ContentEvent;	
	import com.soma.events.LoaderEvent;	
	import com.soma.events.PageEvent;	
	import com.soma.events.TemplateEvent;	
	import com.soma.events.BackgroundEvent;	
	import com.soma.events.MenuEvent;	
	import com.soma.control.FrontController;
	import com.soma.commands.PageCommand;
	import com.soma.commands.TemplateCommand;
	import com.soma.commands.BackgroundCommand;
	import com.soma.commands.MenuCommand;
	import com.soma.commands.LoaderCommand;	
	import com.soma.commands.ContentCommand;	

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> BETA 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 05-2008<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
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
		
		public function SomaController() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public static function init():void {
			//content
			addCommand(ContentEvent.LOADED, ContentCommand);
			//page
			addCommand(PageEvent.SHOW_PAGE, PageCommand);
			addCommand(PageEvent.PAGE_DISPLAYED, PageCommand);
			addCommand(PageEvent.PAGE_REMOVED, PageCommand);
			addCommand(PageEvent.SHOW_EXTERNAL_LINK, PageCommand);
			//page
			addCommand(TemplateEvent.TEMPLATE_DISPLAYED, TemplateCommand);
			addCommand(TemplateEvent.TEMPLATE_REMOVED, TemplateCommand);
			//background
			addCommand(BackgroundEvent.SHOW, BackgroundCommand);
			addCommand(BackgroundEvent.HIDE, BackgroundCommand);
			//menu
			addCommand(MenuEvent.FORCE_OPEN_MENU, MenuCommand);
			//loader
			addCommand(LoaderEvent.ADD_ITEM, LoaderCommand);
			addCommand(LoaderEvent.START_LOADING, LoaderCommand);
			addCommand(LoaderEvent.STOP_LOADING, LoaderCommand);
			//transitions
			addCommand(TransitionEvent.ADD, TransitionCommand);			addCommand(TransitionEvent.REMOVE, TransitionCommand);			addCommand(TransitionEvent.REMOVE_ALL, TransitionCommand);			addCommand(TransitionEvent.START, TransitionCommand);
			addCommand(TransitionEvent.STOP, TransitionCommand);
			addCommand(TransitionEvent.STOP_ALL, TransitionCommand);
		}
		
		public static function addCommand(commandName:String, commandRef:Class, useWeakReference:Boolean = true):void {
			FrontController.addCommand(commandName, commandRef, useWeakReference);
		}
		
		public static function removeCommand(commandName:String):void {
			FrontController.removeCommand(commandName);
		}
		
		protected static function executeCommand(event:CairngormEvent):void {
			FrontController.executeCommand(event);
		}
		
		protected static function getCommand(commandName:String):Class {
			return FrontController.getCommand(commandName);
		}
		
	}
}
