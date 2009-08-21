package com.soma.vo {
	
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
	 
	public class TransitionVO {
		
		public var id:String;
		public var vars:Object;
		
		public function TransitionVO(id:String, vars:Object):void {
			this.id = id;
			this.vars = vars;
		}
		
		public function toString():String {
			var s:String = "TransitionVO[id: " + id + ", time: " + vars + "]";
			return s;
		}
		
	}
}
