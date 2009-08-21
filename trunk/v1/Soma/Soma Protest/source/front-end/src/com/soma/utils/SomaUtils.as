package com.soma.utils {
	
	import flash.display.DisplayObjectContainer;	

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
	 
	public class SomaUtils {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var somaUtils:SomaUtils = new SomaUtils();
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const LIQUID_LAYOUT:String = "liquid";
		public static const FIXED_LAYOUT:String = "fixed";

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaUtils() {
			if (somaUtils) throw new Error("SomaUtils is Singleton");
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public static function getRootURL(d:DisplayObjectContainer):String {
			var fullURL:String = d.loaderInfo.url;
			var url:String = fullURL.substr(0, fullURL.lastIndexOf("/")+1);
			return url;
		}
		
		public static function stringToBoolean(value:String):Boolean {
			return (value.toLowerCase() == "true" || value.toLowerCase() == "1");
		}
		
		
		
	}
}
