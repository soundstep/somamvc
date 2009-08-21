package com.somaprotest {
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.DisplayShortcuts;

	import com.soma.Soma;
	import com.soma.interfaces.IConfig;
	import com.soma.view.SomaText;
	import com.somaprotest.assets.CircleAsset;
	import com.somaprotest.assets.CircleSimple;
	import com.somaprotest.base.Footer;
	import com.somaprotest.loading.basic.BasicLoading;
	import com.somaprotest.menu.basic.BasicMenu;
	import com.somaprotest.pages.ChainEventPage;
	import com.somaprotest.pages.CmdBackground;
	import com.somaprotest.pages.CmdMenu;
	import com.somaprotest.pages.CustomMVC;
	import com.somaprotest.pages.ExtendSoma;
	import com.somaprotest.pages.PageDepth;
	import com.somaprotest.pages.PageEmpty;
	import com.somaprotest.pages.PageExcludedDemo;
	import com.somaprotest.pages.PageSystem;
	import com.somaprotest.pages.Parser;
	import com.somaprotest.pages.SomaUI;
	import com.somaprotest.pages.StartSoma;
	import com.somaprotest.pages.Stylesheet;
	import com.somaprotest.pages.core.CanvasPage;
	import com.somaprotest.pages.core.Margin;

	import flash.text.AntiAliasType;

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
	
	public class Config implements IConfig {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _siteName:String;
		private var _landingPageID:String;
		private var _loadingClass:String;
		private var _menuClass:String;
		private var _margin:Margin;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Config() {}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function registerClasses():void {
			// the compiler (Flash or Flex SDK) doesn't import classes that are not explicitely used in actionscript
			// this method register the classes that are "named" in the XML Site Definition (like the type attribute of a page node)
			//
			// example to instantiate a Circle class from the XML (not explicitely used in actionscript):
			//
			// Method 1:
			//
			// <circle id="circle" classname="Circle"/>
			// you must use Config.registerClass(Circle), this Config file seems to be the best place
			//
			// Method 1:
			//
			// <circle id="circle" classname="com.project.Circle"/>
			// you must use Config.registerClass(Circle), this Config file seems to be the best place
			// or
			// write in a class before the dynamic intantiation:
			// private var circle:Circle;
			// create a variable will for the compiler to import it (even not used)
			//
			
			Soma.getInstance().registerClass(ChainEventPage);
			//pages
			Soma.getInstance().registerClass(CanvasPage);
			Soma.getInstance().registerClass(StartSoma);
			Soma.getInstance().registerClass(CmdBackground);
			Soma.getInstance().registerClass(CmdMenu);
			Soma.getInstance().registerClass(ExtendSoma);
			Soma.getInstance().registerClass(CustomMVC);
			Soma.getInstance().registerClass(PageSystem);
			Soma.getInstance().registerClass(PageDepth);
			Soma.getInstance().registerClass(PageEmpty);
			Soma.getInstance().registerClass(PageExcludedDemo);
			Soma.getInstance().registerClass(Stylesheet);
			Soma.getInstance().registerClass(Parser);
			Soma.getInstance().registerClass(SomaUI);
			// menu
			Soma.getInstance().registerClass(BasicMenu);
			// loading
			Soma.getInstance().registerClass(BasicLoading);
			// base
			Soma.getInstance().registerClass(Footer);
			// custom asset classes
			Soma.getInstance().registerClass(CircleSimple);
			Soma.getInstance().library.registerAsset("circleParam", CircleAsset);
		}
		// PUBLIC
		//________________________________________________________________________________________________

		public function init():void {
			// initialize values used in a Soma site
			// some values are required but you can add your own
			_siteName = "Soma Protest";
			_landingPageID = "home";
			_loadingClass = "BasicLoading";
			_menuClass = "BasicMenu";
			_margin = new Margin(170, 20, 20, 20);
			SomaText.DEFAULT_EMBED_FONT = true;
			SomaText.DEFAULT_CONDENSE_WHITE = true;
			SomaText.DEFAULT_ANTIALIAS = AntiAliasType.NORMAL;
			XML.ignoreWhitespace = true;
			registerClasses();
			DisplayShortcuts.init();
			ColorShortcuts.init();
		}

		public function get loadingClassName():String {
			return _loadingClass;
		}
		
		public function get menuClassName():String {
			return _menuClass;
		}
		
		public function get siteName():String {
			return _siteName;
		}
		
		public function get landingPageID():String {
			return _landingPageID;
		}
		
		public function get margin():Margin {
			return _margin;
		}
	}
}
