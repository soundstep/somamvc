package com.somaprotest {
	
	import com.soma.view.SomaText;
	import com.somaprotest.templates.*;
	import com.somaprotest.pages.core.CanvasPage;
	import com.soma.interfaces.IConfig;
	import com.somaprotest.pages.core.Margin;
	import com.somaprotest.menu.basic.*;
	import com.somaprotest.loading.basic.*;
	import com.somaprotest.pages.*;
	import flash.text.StyleSheet;
	import flash.net.registerClassAlias;
	import flash.net.getClassByAlias;
	import flash.text.AntiAliasType;

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
	
	public class Config implements IConfig {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _siteName:String;
		private var _defaultPage:String;
		private var _stylesheet:StyleSheet;
		private var _loadingClass:String;
		private var _menuClass:String;
		private var _classArray:Array = [
			// pages
			CanvasPage,
			StartSoma,
			CmdBackground,
			CmdLoader,			CmdMenu,
			ExtendSoma,
			CustomMVC,
			PageSystem,
			PageDepth,
			PageEmpty,
			PageExcludedDemo,
			TemplateSystem,
			TplExample1,
			TplExample2,
			Stylesheet,
			SomaTweenPage,
			// templates
			TemplateExample,
			TemplateParser,
			// menu
			BasicMenu,
			// loading
			BasicLoading
		];
		private var _margin:Margin;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Config() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function registerClasses():void {
			for each (var i:Class in _classArray) {
				registerClassAlias(String(i).substring(7, String(i).length-1), i);
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________

		public function init():void {
			_stylesheet = new StyleSheet();
			_siteName = "Soma Protest";
			_defaultPage = "home";
			_loadingClass = "BasicLoading";
			_menuClass = "BasicMenu";
			_margin = new Margin(170, 20, 20, 20);
			SomaText.DEFAULT_EMBED_FONT = true;
			SomaText.DEFAULT_ANTIALIAS = AntiAliasType.NORMAL;
			XML.ignoreWhitespace = true;
			registerClasses();
		}
		
		public function get loadingClass():String {
			return _loadingClass;
		}
		
		public function get menuClass():String {
			return _menuClass;
		}
		
		public function getClass(className:String):Class {
			for each (var i:Class in _classArray) {
				if (String(i).indexOf(className)) {
					return getClassByAlias(className);
					break;
				}
			}
			return null;
		}
		
		public function get siteName():String {
			return _siteName;
		}
		
		public function get defaultPage():String {
			return _defaultPage;
		}
		
		public function get stylesheet():StyleSheet {
			return _stylesheet;
		}
		
		public function get margin():Margin {
			return _margin;
		}
	}
}
