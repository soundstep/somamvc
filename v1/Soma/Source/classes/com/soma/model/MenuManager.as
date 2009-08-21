package com.soma.model {
	
	import com.soma.Soma;
	import com.soma.view.Menu;

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
	
	public class MenuManager {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _menu:Menu;

		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function MenuManager() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function add(menuClass:String):Menu {
			var MenuClass:Class = Soma.getInstance().config.getClass(menuClass);
			_menu = new MenuClass();
			return _menu;
		}
		
		public function get menu():Menu {
			return _menu;
		}
		
	}
}