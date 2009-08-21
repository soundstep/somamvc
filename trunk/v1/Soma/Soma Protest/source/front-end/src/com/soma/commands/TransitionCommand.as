package com.soma.commands {
	
	import com.soma.vo.TransitionVO;	
	import com.soma.model.TransitionManager;	
	import com.soma.events.TransitionEvent;	
	import com.soma.Soma;	
	import com.soma.control.CairngormEvent;
	import com.soma.interfaces.ICommand;

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
	
	public class TransitionCommand implements ICommand {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TransitionCommand() {}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:CairngormEvent):void {
			var manager:TransitionManager = Soma.getInstance().transition;
			var id:String = TransitionEvent(event).id;
			var item:Object = TransitionEvent(event).item;
			switch (event.type) {
				case TransitionEvent.ADD:
					manager.add(TransitionEvent(event).transition);
					break;
				case TransitionEvent.REMOVE:
					manager.remove(TransitionEvent(event).id);
					break;
				case TransitionEvent.REMOVE_ALL:
					manager.removeAll();
					break;
				case TransitionEvent.START:
					var transition:TransitionVO = (id != null) ? manager.getTransition(id) : TransitionEvent(event).transition;
					manager.execute(item, id, transition);
					break;
				case TransitionEvent.STOP:
					manager.stop(item);
					break;
				case TransitionEvent.STOP_ALL:
					manager.stopAll();
					break;
			}
		}
	}
}
