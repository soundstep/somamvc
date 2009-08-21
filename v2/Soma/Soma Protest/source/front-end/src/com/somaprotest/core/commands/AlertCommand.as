package com.somaprotest.core.commands {
	
	import com.soma.Soma;	
	import com.somaprotest.core.view.Alert;	
	import com.somaprotest.core.model.SomaExtended;	
	import com.somaprotest.core.events.AlertEvent;	
	import com.soma.control.CairngormEvent;	
	import com.soma.interfaces.ICommand;	
	
	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 05-2008<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class AlertCommand implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function AlertCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case AlertEvent.SHOW_ALERT:
					if (SomaExtended.getInstance().state == SomaExtended.STATE_SITE) {
						SomaExtended.getInstance().state = SomaExtended.STATE_ALERT;
						var alertToAdd:Alert = new Alert(AlertEvent(event).alertVO);
						Soma.getInstance().ui.addChild(alertToAdd);
					}
					break;
				case AlertEvent.HIDE_ALERT:
					if (SomaExtended.getInstance().state == SomaExtended.STATE_ALERT) {
						SomaExtended.getInstance().state = SomaExtended.STATE_SITE;
						var alertToRemove:Alert = Soma.getInstance().ui.getChildByName(Alert.NAME) as Alert;
						alertToRemove.dispose();
						Soma.getInstance().ui.removeChild(alertToRemove);
					}
					break;
			}
		}
		
	}
}
