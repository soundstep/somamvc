package com.somaprotest.pages {
	import caurina.transitions.Tweener;

	import com.soma.events.PageEvent;
	import com.soma.events.ParserEvent;
	import com.soma.interfaces.IPage;
	import com.soma.loader.SomaLoader;
	import com.soma.loader.SomaLoaderItem;
	import com.soma.view.Page;
	import com.soma.view.SomaText;

	import flash.display.DisplayObject;

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
	
	public class Parser extends Page implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _myXML:XML;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Parser() {
			visible = false;
			alpha = 0;
			addEventListener(PageEvent.INITIALIZED, initialized, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function initialized(e:PageEvent):void {
			addEventListener(PageEvent.CONTENT_PARSED, contentParsed, false, 0, true);
			parser.addEventListener(ParserEvent.ASSET_LOADED, assetLoaded);
		}
		
		private function contentParsed(e:PageEvent = null):void {
			for (var i:int=0; i<assets.length; i++) {
				var asset:DisplayObject = assets[i];
				var targetAlpha:Number = asset.alpha;
				asset.alpha = 0;
				Tweener.addTween(asset, {time:1, delay:i*.3, _autoAlpha:targetAlpha});
			}
		}
		
		private function assetLoaded(e:ParserEvent):void {
			var item:SomaLoaderItem = e.asset;
			if (item.type == SomaLoader.TYPE_XML) {
				_myXML = new XML(item.file);
				SomaText(getAssetByID("xmlLoadedAlert")).text = "An XML file has been loaded.";
			}
			else {
				var asset:DisplayObject = item.container;
				asset.alpha = 0;
				Tweener.addTween(asset, {time:2, alpha:1});
			}
		}
		
		private function dispose():void {
			removeEventListener(PageEvent.INITIALIZED, initialized, false);
			removeEventListener(PageEvent.CONTENT_PARSED, contentParsed, false);
			if (parser != null) {
				parser.removeEventListener(ParserEvent.ASSET_LOADED, assetLoaded);
				parser.dispose();
			}
			while (numChildren > 0) {
				if (getChildAt(0).hasOwnProperty("dispose")) getChildAt(0)['dispose']();
				removeChildAt(0);
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionIn():void {
			Tweener.addTween(this, {time:.7, _autoAlpha:1, onComplete:super.transitionIn});
		}

		override public function transitionInComplete():void {
			super.transitionInComplete();
		}
		
		override public function transitionOut():void {
			Tweener.addTween(this, {time:.7, _autoAlpha:0, onComplete:super.transitionOut});
		}
		
		override public function transitionOutComplete():void {
			dispose();
			super.transitionOutComplete();
		}
		
	}
}
