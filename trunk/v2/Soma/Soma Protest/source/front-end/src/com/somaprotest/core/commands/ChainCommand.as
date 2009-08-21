package com.somaprotest.core.commands {
	import com.soma.Soma;
	import com.soma.commands.SequenceCommand;
	import com.soma.control.CairngormEvent;
	import com.soma.interfaces.ICommand;
	import com.soma.interfaces.IComplete;
	import com.soma.view.Page;
	import com.somaprotest.core.events.ChainEvent;
	import com.somaprotest.pages.ChainEventPage;		
	/**
	 * @author romuald
	 */
	public class ChainCommand extends SequenceCommand implements ICommand, IComplete {
		public function ChainCommand(nextEvent:CairngormEvent = null) {
			super(nextEvent);
		}
		
		override public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case ChainEvent.STEP1:
					nextEvent = new ChainEvent(ChainEvent.STEP2);
					break;
				case ChainEvent.STEP2:
					nextEvent = new ChainEvent(ChainEvent.STEP3);
					break;
				case ChainEvent.STEP3:
					nextEvent = new ChainEvent(ChainEvent.STEP4);
					break;
				case ChainEvent.STEP4:
					nextEvent = new ChainEvent(ChainEvent.STEP1);
					break;
			}
			if (ChainEvent(event).complete == null) ChainEvent(event).complete = this;
			var page:Page = Soma.getInstance().page.currentPage;
			if (page is ChainEventPage) {
				ChainEventPage(page).moveAsset(event as ChainEvent);
			}
		}
		
		public function complete(data:Object = null):void {
			executeNextCommand();
		}
		
	}
}
