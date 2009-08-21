package com.soma.view {
	
	import com.soma.Soma;	
	import flash.text.*;
	import com.soma.model.StyleManager;
	
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
	
	public class Text extends TextField {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _style:String;
		private var _globalStylesheet:StyleSheet;
		private var _useStyleSheet:Boolean;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static var DEFAULT_FONT_EMBED:Boolean = false;
		public static var DEFAULT_ANTIALIAS:String = "advanced";
		public static var DEFAULT_AUTOSIZE:String = "left";
		public static var DEFAULT_MULTILINE:Boolean = false;
		public static var DEFAULT_WORDWRAP:Boolean = false;
		public static var DEFAULT_CONDENSE_WHITE:Boolean = true;
		public static var USE_STYLESHEET:Boolean = false;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Text(txt:String = "Text", style:String = "", multiline:Boolean = false, wordWrap:Boolean = false, embedFonts:Boolean = false, autoSize:String = "", antiAliasType:String = "", selectable:Boolean = false, ... rest) {
			super();
			useStyleSheet = (rest[0] == undefined) ? Text.USE_STYLESHEET : rest[0];
			condenseWhite = (rest[1] == undefined) ? Text.DEFAULT_CONDENSE_WHITE : rest[1];
			if (autoSize == "") autoSize = Text.DEFAULT_AUTOSIZE;
			if (antiAliasType == "") antiAliasType = Text.DEFAULT_ANTIALIAS;
			this.autoSize = autoSize;
			this.antiAliasType = antiAliasType;
			this.embedFonts = embedFonts;
			this.selectable = selectable;
			this.multiline = multiline;
			this.wordWrap = wordWrap;
			_style = style;
			_globalStylesheet = Soma.getInstance().config.stylesheet;
			this.styleSheet = _globalStylesheet;
			htmlText = txt;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function set styleSheet(value:StyleSheet):void {
			var t:String = htmlText;
			super.styleSheet = value;
			super.htmlText = t;
		}
		
		override public function set htmlText(value:String):void {
			if (!_useStyleSheet) this.styleSheet = null;
			super.htmlText = value;
			if (!_useStyleSheet && _style != "") setTextFormat(Soma.getInstance().styles.getStyle(_style));
			this.styleSheet = _globalStylesheet;
		}

		public function set style(style:String):void {
			if (!_useStyleSheet) this.styleSheet = null;
			_style = style;
			if (!_useStyleSheet && _style != "") setTextFormat(Soma.getInstance().styles.getStyle(_style));
			this.styleSheet = _globalStylesheet;
		}

		public function get style():String {
			return _style;
		}
		
		public function get globalStylesheet():StyleSheet {
			return _globalStylesheet;
		}
		
		public function get useStyleSheet():Boolean {
			return _useStyleSheet;
		}
		
		public function set useStyleSheet(useStyleSheet:Boolean):void {
			_useStyleSheet = useStyleSheet;
		}
	}
}