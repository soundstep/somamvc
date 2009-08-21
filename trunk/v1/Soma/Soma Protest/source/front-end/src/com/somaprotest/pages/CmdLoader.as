package com.somaprotest.pages {
	
	import flash.events.Event;	
	import com.soma.Soma;	
	import com.soma.vo.LoaderItemVO;	
	import com.soma.events.LoaderEvent;	
	import com.soma.view.SomaText;	
	import com.somaprotest.core.view.CodeBox;	
	import com.soma.interfaces.IRemovable;
	import com.somaprotest.pages.core.CanvasPage;
	import com.hydrotik.utils.QueueLoaderEvent;	
	import flash.events.TextEvent;	
	import flash.geom.ColorTransform;	
	import flash.display.Bitmap;	
	import flash.display.Sprite;	

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
	
	public class CmdLoader extends CanvasPage implements IRemovable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _images:Sprite;
		private var _queueLengthText:SomaText;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function CmdLoader() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function init():void {
			super.init();
			Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete, false, 0, true);
			createImageContainer();
			showLoaderExample();
			buildCommandLinks();
			canvas.refresh();
		}
		
		override protected function start():void {
			super.start();
		}
		
		override protected function startContent():void {
			super.startContent();
			
		}
		
		private function createImageContainer():void {
			_images = new Sprite();
			addChildAt(_images, 0);
		}
		
		private function showLoaderExample():void {
			var loaderExample:CodeBox = new CodeBox(300, 150);
			loaderExample.width = canvas.width - 30;
			loaderExample.y = posY;
			canvas.addChild(loaderExample);
			loaderExample.addCodeLine('Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onItemComplete);');
			loaderExample.addCodeLine('var item:LoaderItemVO = new LoaderItemVO("/images/asset.jpg", mySpriteTarget, {title:"asset", smoothing:true});');
			loaderExample.addCodeLine('new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, item).dispatch();');
			loaderExample.addCodeLine('new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();');
			loaderExample.addCodeLine('');
			loaderExample.addCodeLine('function onItemComplete(event:QueueLoaderEvent):void {');
			loaderExample.addCodeLine('    var bitmap:Bitmap = e.file as Bitmap;');
			loaderExample.addCodeLine('}');
			canvas.refresh();
			posY = loaderExample.y + loaderExample.height + 7;
		}
		
		private function buildCommandLinks():void {
			// loader add item command text
			var loaderCommandText:SomaText = new SomaText(content.*.(@id == "text1"), "body");
			loaderCommandText.y = posY;
			loaderCommandText.width = canvas.width - 25;
			canvas.addChild(loaderCommandText);
			posY = loaderCommandText.y + loaderCommandText.height + 7;
			// loader add item command
			var strAddItem:String = '<a href="event:addItem">new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, loaderItemVO).dispatch();</a>';
			var command:SomaText = new SomaText(strAddItem, "body");
			command.selectable = false;
			command.x = 30;
			command.y = posY;
			command.width = canvas.width - 25;
			canvas.addChild(command);
			posY = command.y + command.height + 7;
			// listeners
			command.addEventListener(TextEvent.LINK, executeAddItem, false, 0, true);
			// queue length
			_queueLengthText = new SomaText("", "body");
			updateItemsInQueue();
			_queueLengthText.y = posY;
			canvas.addChild(_queueLengthText);
			posY = _queueLengthText.y + _queueLengthText.height + 7;
			// loader start loading command
			var strStartLoading:String = '<a href="event:startLoading">new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();</a>';
			var commandStart:SomaText = new SomaText(strStartLoading, "body");
			commandStart.selectable = false;
			commandStart.x = 30;
			commandStart.y = posY;
			commandStart.width = canvas.width - 25;
			canvas.addChild(commandStart);
			posY = commandStart.y + commandStart.height + 7;
			// listeners
			commandStart.addEventListener(TextEvent.LINK, executeStartLoading, false, 0, true);
			// loader stop loading command
			var strStopLoading:String = '<a href="event:stopLoading">new LoaderEvent(LoaderEvent.STOP_LOADING, Soma.getInstance().loader).dispatch();</a>';
			var commandStopLoading:SomaText = new SomaText(strStopLoading, "body");
			commandStopLoading.selectable = false;
			commandStopLoading.x = 30;
			commandStopLoading.y = posY;
			commandStopLoading.width = canvas.width - 25;
			canvas.addChild(commandStopLoading);
			posY = commandStopLoading.y + commandStopLoading.height + 7;
			// listeners
			commandStopLoading.addEventListener(TextEvent.LINK, executeStopLoading, false, 0, true);
			// clear
			var clear:SomaText = new SomaText('<a href="event:clear">Clear items loaded</a>', "body");
			clear.x = 30;
			clear.y = posY;
			canvas.addChild(clear);
			posY = clear.y + clear.height + 7;
			// listeners
			clear.addEventListener(TextEvent.LINK, clearHandler, false, 0, true);
		}
		
		private function updateItemsInQueue():void {
			_queueLengthText.htmlText = "Number of items in the queue: " + Soma.getInstance().loader.queue.length;
		}
		
		private function executeAddItem(e:TextEvent):void {
			var loaderItemVO:LoaderItemVO = new LoaderItemVO("images/assets/asset" + Math.round(Math.random() * 4) + ".jpg", _images, {title:"asset", smoothing:true});
			new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, loaderItemVO).dispatch();
			updateItemsInQueue();
		}
		
		private function executeStartLoading(e:TextEvent):void {
			new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();
		}
		
		private function executeStopLoading(e:TextEvent):void {
			new LoaderEvent(LoaderEvent.STOP_LOADING, Soma.getInstance().loader).dispatch();
			updateItemsInQueue();
		}
		
		private function itemComplete(e:QueueLoaderEvent):void {
			updateItemsInQueue();
			var bitmap:Bitmap = e.file as Bitmap;
			bitmap.x = -(bitmap.width * .5) + Math.random() * stage.stageWidth;
			bitmap.y = -(bitmap.height * .5) + Math.random() * stage.stageHeight;
			var color:ColorTransform = new ColorTransform();
			color.redOffset   = -150;
			color.greenOffset = -150;
			color.blueOffset  = -150;
			bitmap.transform.colorTransform = color;
		}
		
		private function clearHandler(e:TextEvent = null):void {
			while (_images.numChildren > 0) {
				_images.removeChildAt(0);
			}
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function remove(e:Event = null):void {
			new LoaderEvent(LoaderEvent.STOP_LOADING, Soma.getInstance().loader).dispatch();
			super.remove(e);
		}
		
		override public function dispose(e:Event = null):void {
			Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete, false);
			clearHandler();
			while (numChildren > 0) {
				removeChildAt(0);
			}
			super.dispose(e);
		}
	
	}
}
