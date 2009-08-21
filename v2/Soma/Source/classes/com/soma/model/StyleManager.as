package com.soma.model {
	import com.soma.loader.SomaLoaderItem;		import com.soma.loader.SomaLoaderEvent;	
	import com.soma.loader.SomaLoader;	
	import com.soma.events.StyleSheetEvent;	
	import flash.text.StyleSheet;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import flash.utils.Dictionary;	
	import com.soma.Soma;	
	import flash.text.TextFormat;

	/**
     * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0<br/>
     * <b>Actionscript version:</b> 3.0</p>
     * <p><b>Copyright:</b></p>
     * <p>The contents of this file are subject to the Mozilla Public License<br />
     * Version 1.1 (the "License"); you may not use this file except in compliance<br />
     * with the License. You may obtain a copy of the License at<br /></p>
     * 
     * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>
     * 
     * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />
     * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />
     * See the License for the specific language governing rights and<br />
     * limitations under the License.<br /></p>
     * 
     * <p>The Original Code is Soma.<br />
     * The Initial Developer of the Original Code is Romuald Quantin.<br />
     * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.</p>
     * 
     * <p><b>Usage:</b><br/>
     * The StyleManager handles external stylesheets (css) and gives you an easy access to the styles.
     * The global stylesheet manager is accessible using:
     * <listing version="3.0">Soma.getInstance().styles</listing>
     * Before starting Soma, you can register a "global stylesheet" to the framework using (the css will be loaded during the initialization process):
     * <listing version="3.0">Soma.getInstance().registerGloBalStyleSheet("styles.css");</listing>
     * Other StyleSheets can easily be loaded using:
     * <listing version="3.0">
Soma.getInstance().addEventListener(StyleSheetEvent.LOADED, eventHandler);
Soma.getInstance().loadStyleSheet("myStyleSheetID", "css/custom.css");
 	 * </listing>
 	 * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.StyleSheetEvent StyleSheetEvent
     * @see com.soma.view.SomaText SomaText
     */
	
	public class StyleManager {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _stylesheets:Dictionary;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** id String of the global stylesheet. */
		public static const GLOBAL_STYLESHEET_ID:String = "global";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates an StyleManager instance */
		public function StyleManager() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			_stylesheets = new Dictionary();
		}
		
		private function itemComplete(e:SomaLoaderEvent):void {
			removeListeners();
			if(e.item.type == SomaLoader.TYPE_CSS) {
				var css:StyleSheet = new StyleSheet();
				css.parseCSS(e.item.file);
				addStyleSheet(e.item.data['id'], css);
				new StyleSheetEvent(StyleSheetEvent.LOADED, css).dispatch();
			}
		}
		
		private function itemError(e:SomaLoaderEvent):void {
			removeListeners();
			throw new CairngormError(CairngormMessage.STYLESHEET_LOADING_ERROR, e.errorMessage);
		}
		
		private function removeListeners():void {
			Soma.getInstance().loader.removeEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
			Soma.getInstance().loader.removeEventListener(SomaLoaderEvent.ERROR, itemError);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Add a stylesheet to the StyleManager instance and register it with an id.
		 * @param id id of the stylesheet.
		 * @param stylesheet A StyleSheet.
		 */
		public function addStyleSheet(id:String, stylesheet:StyleSheet):void {
			_stylesheets[id] = stylesheet;
		}
		
		/**
		 * Load a stylesheet and register it with an id.
		 * @param id id of the stylesheet.
		 * @param url URL of the css file.
		 */
		public function loadStyleSheet(id:String, url:String):void {
			var loader:SomaLoader = Soma.getInstance().loader;
			loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
			loader.addEventListener(SomaLoaderEvent.ERROR, itemError);
			var item:SomaLoaderItem = loader.add(url, null, SomaLoader.TYPE_CSS, {id:id});
			item.cacheEnabled = false;
			loader.start();
		}
		
		/**
		 * Remove a styleheet from the StyleManager instance using its id.
		 * @param stylesheetID id of the stylesheet.
		 */
		public function removeStyleSheet(stylesheetID:String):void {
			if (_stylesheets[stylesheetID] != undefined) {
				_stylesheets[stylesheetID] = null;
				delete _stylesheets[stylesheetID];
			}
		}
		
		/**
		 * Set a stylesheet to be the "global stylesheet" (used by default with SomaText instances when a stylesheet is not specified).
		 * @param stylesheet A StyleSheet instance.
		 */
		public function setGlobalStyleSheet(stylesheet:StyleSheet):void {
			_stylesheets[StyleManager.GLOBAL_STYLESHEET_ID] = stylesheet;
		}
		
		/**
		 * Get the global stylesheet instance registered (used by default with SomaText instances when a stylesheet is not specified).
		 * @return A StyleSheet instance.
		 */
		public function getGlobalStyleSheet():StyleSheet {
			return _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID];
		}
		
		/**
		 * Get a stylesheet using its id.
		 * @param stylesheetID id of the stylesheet.
		 * @return A StyleSheet instance.
		 */
		public function getStyleSheet(stylesheetID:String):StyleSheet {
			if (_stylesheets[stylesheetID] == undefined) return null;
			else return _stylesheets[stylesheetID];
		}
		
		/**
		 * Get the id of a stylesheet.
		 * @param stylesheet A StyleSheet instance.
		 * @return A String.
		 */
		public function getStyleSheetID(stylesheet:StyleSheet):String {
			for (var stylesheetID:String in _stylesheets) {
				if (_stylesheets[stylesheetID] == stylesheet) {
					return stylesheetID;
				}
			}
			return null;
		}
		
		/**
		 * Get a style from the global stylesheet.
		 * <listing version="3.0">
var obj:Object = Soma.getInstance().styles.getGlobalStyle(".myStyle");
for (var i:String in obj) {
	trace(i, obj[i])
}
		 * </listing>
		 * @param style Name of the style.
		 * @return An object.
		 */
		public function getGlobalStyle(style:String):Object {
			var globalStyleSheet:StyleSheet = _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID];
			if (globalStyleSheet == null) throw new CairngormError(CairngormMessage.STYLESHEET_GLOBAL_NOT_FOUND);
			return globalStyleSheet.getStyle(style);
		}
		
		/**
		 * Get a style from a stylesheet (the global stylesheet will be used if you don't pass any).
		 * <listing version="3.0">
var obj:Object = Soma.getInstance().styles.getStyle(".myStyle", myStyleSheet);
for (var i:String in obj) {
	trace(i, obj[i])
}
		 * </listing>
		 * @param style Name of the style.
		 * @return An object.
		 */
		public function getStyle(style:String, stylesheet:StyleSheet = null):Object {
			var stylesheetTarget:StyleSheet = (stylesheet == null) ? _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID] : stylesheet;
			if (stylesheetTarget == null) throw new CairngormError(CairngormMessage.STYLESHEET_GLOBAL_NOT_FOUND);
			var stylesheetID:String = getStyleSheetID(stylesheetTarget);
			return _stylesheets[stylesheetID].getStyle(style);
		}
		
		/**
		 * Get a color from a stylesheet (the global stylesheet will be used if you don't pass any).
		 * <listing version="3.0">
var color:uint = Soma.getInstance().styles.getColor(".myStyle");
trace(color.toString(16));
		 * </listing>
		 * @param style Name of the style.
		 * @param stylesheet StyleSheet instance.
		 * @return A uint value (color value).
		 */
		public function getColor(style:String, stylesheet:StyleSheet = null):uint {
			var stylesheetTarget:StyleSheet = (stylesheet == null) ? _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID] : stylesheet;
			if (stylesheetTarget == null) throw new CairngormError(CairngormMessage.STYLESHEET_GLOBAL_NOT_FOUND);
			var color:String = getStyle(style, stylesheetTarget)['color'];
			return parseInt(String(color).substring(1), 16);
		}
		
		/**
		 * Get a color from a stylesheet (the global stylesheet will be used if you don't pass any).
		 * <listing version="3.0">var tf:TextFormat = Soma.getInstance().styles.getTextFormat(".body");</listing>
		 * @param style Name of the style.
		 * @param stylesheet StyleSheet instance.
		 * @return A TextFormat instance.
		 */
		public function getTextFormat(style:String, stylesheet:StyleSheet = null):TextFormat {
			var stylesheetTarget:StyleSheet = (stylesheet == null) ? _stylesheets[StyleManager.GLOBAL_STYLESHEET_ID] : stylesheet;
			if (stylesheetTarget == null) throw new CairngormError(CairngormMessage.STYLESHEET_GLOBAL_NOT_FOUND);
			var s:Object = stylesheetTarget.getStyle(style);
			return stylesheetTarget.transform(s);
		}
		
		public function cloneStyleSheet(target:StyleSheet):StyleSheet {
			var newStyleSheet:StyleSheet = new StyleSheet();
			var len:int = target.styleNames.length;
			for(var i:int=0; i<len; i++){
				newStyleSheet.setStyle(target.styleNames[i], target.getStyle(target.styleNames[i]));
			}
			return newStyleSheet;
		}
		
	}
}