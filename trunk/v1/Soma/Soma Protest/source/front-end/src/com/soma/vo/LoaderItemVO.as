package com.soma.vo {
	
	import flash.display.DisplayObject;
	
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
	 
	public class LoaderItemVO {
		
		public var file:String;
		public var container:DisplayObject;
		public var objectInfo:Object;
		
		public function LoaderItemVO(file:String, container:DisplayObject, objectInfo:Object = null):void {
			this.file = file;
			this.container = container;
			this.objectInfo = objectInfo;
			if (this.objectInfo == null) this.objectInfo = {};
		}
		
		public function toString():String {
			var s:String = "LoaderItemVO[file: " + file + ", container: " + container + ", objectInfo: " + objectInfo + "]";
			return s;
		}
		
	}
}
