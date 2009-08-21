package com.soma.model {
	
	import com.soma.events.StyleSheetEvent;	
	import com.hydrotik.utils.QueueLoader;	
	import flash.text.StyleSheet;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import flash.utils.Dictionary;	
	import com.hydrotik.utils.QueueLoaderEvent;	
	import com.soma.Soma;	
	import com.soma.events.LoaderEvent;	
	import com.soma.vo.LoaderItemVO;	
	import flash.text.TextFormat;

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
	
	public class StyleManager {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _stylesheets:Dictionary;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const GLOBAL_STYLESHEET_ID:String = "global";
		
		public var styles:Object;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function StyleManager() {
			init();
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_stylesheets = new Dictionary();
			styles = {};
		}
		
		private function itemComplete(e:QueueLoaderEvent):void {
			removeListeners();
			if(e.filetype == QueueLoader.FILE_CSS) {
				var css:StyleSheet = new StyleSheet();
				css.parseCSS(e.file);
				addStyleSheet(e.title, css);
				new StyleSheetEvent(StyleSheetEvent.LOADED, css).dispatch();
			}
		}
		
		private function itemError(e:QueueLoaderEvent):void {
			removeListeners();
			throw new CairngormError(CairngormMessage.STYLESHEET_LOADING_ERROR, e.message);
		}
		
		private function removeListeners():void {
			Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete);
			Soma.getInstance().loader.queue.removeEventListener(QueueLoaderEvent.ITEM_ERROR, itemError);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function addStyleSheet(id:String, stylesheet:StyleSheet):void {
			if(_stylesheets[id] != null) throw new CairngormError(CairngormMessage.STYLESHEET_ALREADY_REGISTERED, id);
			_stylesheets[id] = stylesheet;
		}
		
		public function loadStyleSheet(id:String, url:String):void {
			var lvo:LoaderItemVO = new LoaderItemVO(url, null, {title:id});
			Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete);
			Soma.getInstance().loader.queue.addEventListener(QueueLoaderEvent.ITEM_ERROR, itemError);
			new LoaderEvent(LoaderEvent.ADD_ITEM, Soma.getInstance().loader, lvo).dispatch();
			new LoaderEvent(LoaderEvent.START_LOADING, Soma.getInstance().loader).dispatch();
		}
		
		public function removeStyleSheet(stylesheetID:String):void {
			if(_stylesheets[stylesheetID] === null) throw new CairngormError(CairngormMessage.STYLESHEET_NOT_FOUND, stylesheetID);  
			_stylesheets[stylesheetID] = null;
			delete _stylesheets[stylesheetID];
		}
		
		public function setGlobalStyleSheet(stylesheet:StyleSheet):void {
			_stylesheets[StyleManager.GLOBAL_STYLESHEET_ID] = stylesheet;
		}
		
		public function getGlobalStyleSheet():StyleSheet {
			return _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID];
		}
		
		public function getStyleSheet(stylesheetID:String):StyleSheet {
			var stylesheet:StyleSheet = _stylesheets[stylesheetID];
			if (stylesheet == null) throw new CairngormError(CairngormMessage.STYLESHEET_NOT_FOUND, stylesheetID);
			return stylesheet;
		}
		
		public function getStyleSheetID(stylesheet:StyleSheet):String {
			for (var stylesheetID:String in _stylesheets) {
				if (_stylesheets[stylesheetID] == stylesheet) {
					return stylesheetID;
				}
			}
			return null;
		}
		
		public function getGlobalStyle(style:String):Object {
			var globalStyleSheet:StyleSheet = _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID];
			if (globalStyleSheet == null) throw new CairngormError(CairngormMessage.STYLESHEET_GLOBAL_NOT_FOUND);
			return globalStyleSheet.getStyle(style);
		}
		
		public function getStyles(stylesheet:StyleSheet, style:String):Object {
			var stylesheetID:String = getStyleSheetID(stylesheet);
			return _stylesheets[stylesheetID].getStyle(style);
		}
		
		public function addStyle(name:String, style:TextFormat):void {
			styles[name] = style;
		}
		
		public function getStyle(style:String):TextFormat {
			return styles[style];
		}
		
	}
}