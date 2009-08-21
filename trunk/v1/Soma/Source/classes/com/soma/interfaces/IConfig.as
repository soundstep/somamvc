package com.soma.interfaces {
	
	import flash.text.StyleSheet;	

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

	public interface IConfig {
		
		function init():void;
		function get siteName():String;
		function get defaultPage():String;
		function get loadingClass():String;
		function get menuClass():String;
		function getClass(className:String):Class;
		function get stylesheet():StyleSheet;
	}

}