package com.soma {
	import com.soma.assets.ClassImport;
	import com.soma.assets.Library;
	import com.soma.control.CairngormEvent;
	import com.soma.control.CairngormEventDispatcher;
	import com.soma.control.SomaController;
	import com.soma.errors.CairngormError;
	import com.soma.errors.CairngormMessage;
	import com.soma.events.SomaEvent;
	import com.soma.events.StyleSheetEvent;
	import com.soma.interfaces.IConfig;
	import com.soma.interfaces.ILibrary;
	import com.soma.interfaces.IModelLocator;
	import com.soma.loader.ILoading;
	import com.soma.loader.SomaLoader;
	import com.soma.model.BackgroundManager;
	import com.soma.model.BaseManager;
	import com.soma.model.ContentManager;
	import com.soma.model.MenuContext;
	import com.soma.model.MenuManager;
	import com.soma.model.PageManager;
	import com.soma.model.StyleManager;
	import com.soma.utils.SomaUtils;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;

	/** Soma command to display a background using the id from the XML Site Definition, use from anywhere in the code:<br/><br/>
	 * The parameter should the ID of the background (id attribute in the XML Site Definition)<br/><br/>
	 * new BackgroundEvent(BackgroundEvent.SHOW, "myBackground").dispatch();
     * @eventType com.soma.events.BackgroundEvent.SHOW
     * @see com.soma.model.BackgroundManager BackgroundManager
     * @see com.soma.events.BackgroundEvent BackgroundEvent
     */
	[Event(name="SHOW", type="com.soma.events.BackgroundEvent.SHOW")]
	
	/** Soma command to display a background using the id from the XML Site Definition, use from anywhere in the code:<br/><br/>
	 * The parameter should the ID of the background (id attribute in the XML Site Definition)<br/><br/>
	 * new BackgroundEvent(BackgroundEvent.HIDE, "myBackground").dispatch();
     * @eventType com.soma.events.BackgroundEvent.HIDE
     * @see com.soma.model.BackgroundManager BackgroundManager
     * @see com.soma.events.BackgroundEvent BackgroundEvent
     */
	[Event(name="HIDE", type="com.soma.events.BackgroundEvent.HIDE")]
	
	/** Indicates when a background is about to be displayed by the BackgroundManager instance (Soma.getInstance().background).<br/><br/>
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_IN, eventHandler);
     * @eventType com.soma.events.BackgroundEvent.TRANSITION_IN
     * @see com.soma.model.BackgroundManager BackgroundManager
     * @see com.soma.events.BackgroundEvent BackgroundEvent
     */
	[Event(name="TRANSITION_IN", type="com.soma.events.BackgroundEvent.TRANSITION_IN")]
	
	/** Indicates when a background is about to be hidden by the BackgroundManager instance (Soma.getInstance().background).<br/><br/>
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_OUT, eventHandler);
     * @eventType com.soma.events.BackgroundEvent.TRANSITION_OUT
     * @see com.soma.model.BackgroundManager BackgroundManager
     * @see com.soma.events.BackgroundEvent BackgroundEvent
     */
	[Event(name="TRANSITION_OUT", type="com.soma.events.BackgroundEvent.TRANSITION_OUT")]
	
	/** Indicates when the XML Site Definition has been loaded.<br/><br/>
	 * Soma.getInstance().addEventListener(ContentEvent.LOADED, eventHandler);
     * @eventType com.soma.events.ContentEvent.LOADED
     * @see com.soma.model.ContentManager ContentManager
     * @see com.soma.events.ContentEvent ContentEvent
     */
	[Event(name="LOADED", type="com.soma.events.ContentEvent.LOADED")]
	
	/** Indicates when the XML Site Definition has been updated.<br/><br/>
	 * Soma.getInstance().addEventListener(ContentEvent.UPDATED, eventHandler);
     * @eventType com.soma.events.ContentEvent.UPDATED
     * @see com.soma.model.ContentManager ContentManager
     * @see com.soma.events.ContentEvent ContentEvent
     */
	[Event(name="UPDATED", type="com.soma.events.ContentEvent.UPDATED")]
	
	/** Soma command that will be received by the user's custom menu (IMenu) to update the state of this menu when a new page is about to be displayed.<br/><br/>
	 * This event is automatically dispatched by the PageManager instance in some case, such as a URL change (Soma.getInstance().page).<br/><br/>
	 * Can also be used as a command from anywhere in the code, the parameter should be the ID of the page (id attribute in the XML Site Definition):<br/><br/>
	 * new MenuEvent(MenuEvent.OPEN_MENU, "myID").dispatch();
     * @eventType com.soma.events.MenuEvent.OPEN_MENU
     * @see com.soma.model.MenuManager MenuManager
     * @see com.soma.events.MenuEvent MenuEvent
     */
	[Event(name="OPEN_MENU", type="com.soma.events.MenuEvent.OPEN_MENU")]
	
	/** Soma command to display a page using the id from the XML Site Definition, use from anywhere in the code.<br/><br/>
	 * The parameter should the ID of the page (id attribute in the XML Site Definition)<br/><br/>
	 * new PageEvent(PageEvent.SHOW, "myPageID").dispatch();
     * @eventType com.soma.events.PageEvent.SHOW
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="SHOW", type="com.soma.events.PageEvent.SHOW")]
	
	/** Soma command to open a new browser window in case the page in the XML Site Definition is an external link, example:<br/><br/>
	 * &lt;page id="soundstep" externalLink="http://www.soundstep.com/"&gt;<br/>
	 *     &lt;title&gt;&lt;![CDATA[Soundstep]]&gt;&lt;/title&gt;<br/>
	 * &lt;/page&gt;<br/><br/>
	 * This event can be automatically dispatched by the Singleton MenuContext (right-click menu).<br/>
	 * Can also be used as a command from anywhere in the code:<br/><br/>
	 * new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, null, "http://www.soundstep.com/").dispatch();<br/>
	 * new PageEvent(PageEvent.SHOW_EXTERNAL_LINK, myPage.&#64;id, myPage.&#64;externalLink).dispatch();
     * @eventType com.soma.events.PageEvent.SHOW_EXTERNAL_LINK
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="SHOW_EXTERNAL_LINK", type="com.soma.events.PageEvent.SHOW_EXTERNAL_LINK")]
	
	/** Indicates when a page is about to be instantiated by the PageManager instance (Soma.getInstance().page).<br/><br/>
	 * This event can be default prevented to stop the page manager to display and hide pages.<br/><br/>
	 * Soma.getInstance().addEventListener(PageEvent.STARTED, eventHandler);
     * @eventType com.soma.events.PageEvent.STARTED
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="STARTED", type="com.soma.events.PageEvent.STARTED")]
	
	/** Indicates when a page has been instantiated and is about to be displayed.<br/><br/>
	 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN, eventHandler);
     * @eventType com.soma.events.PageEvent.TRANSITION_IN
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="TRANSITION_IN", type="com.soma.events.PageEvent.TRANSITION_IN")]
	
	/** Indicates when a page has been displayed.<br/><br/>
	 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_IN_COMPLETE, eventHandler);
     * @eventType com.soma.events.PageEvent.TRANSITION_IN_COMPLETE
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="TRANSITION_IN_COMPLETE", type="com.soma.events.PageEvent.TRANSITION_IN_COMPLETE")]
	
	/** Indicates when a page is about to be hidden.<br/><br/>
	 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT, eventHandler);
     * @eventType com.soma.events.PageEvent.TRANSITION_OUT
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="TRANSITION_OUT", type="com.soma.events.PageEvent.TRANSITION_OUT")]
	
	/** Indicates when a page has been hidden.<br/><br/>
	 * Soma.getInstance().addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, eventHandler);
     * @eventType com.soma.events.PageEvent.TRANSITION_OUT_COMPLETE
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="TRANSITION_OUT_COMPLETE", type="com.soma.events.PageEvent.TRANSITION_OUT_COMPLETE")]
	
	/** Indicates when an excluded page has been called.<br/><br/>
	 * See <a href=http://www.soundstep.com/somaprotest/www/#/page-system/excluded/"" target="_blank">Soma Protest Page Excluded</a> section.<br/>
	 * Soma.getInstance().addEventListener(PageEvent.EXCLUDED, eventHandler);
     * @eventType com.soma.events.PageEvent.EXCLUDED
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="EXCLUDED", type="com.soma.events.PageEvent.EXCLUDED")]
	
	/** Indicates when a page that contains excluded page children has been called.
	 * See <a href=http://www.soundstep.com/somaprotest/www/#/page-system/excluded/"" target="_blank">Soma Protest Page Excluded</a> section.<br/>
	 * Soma.getInstance().addEventListener(PageEvent.EXCLUDED_PARENT, eventHandler);
     * @eventType com.soma.events.PageEvent.EXCLUDED_PARENT
     * @see com.soma.model.PageManager PageManager
     * @see com.soma.events.PageEvent PageEvent
     */
	[Event(name="EXCLUDED_PARENT", type="com.soma.events.PageEvent.EXCLUDED_PARENT")]
	
	/** Indicates the language (string in the URL) has been changed.<br/><br/>
	 * Soma.getInstance().addEventListener(SomaEvent.LANGUAGE_CHANGED, eventHandler);
     * @eventType com.soma.events.SomaEvent.LANGUAGE_CHANGED
     * @see com.soma.events.SomaEvent SomaEvent
     */
	[Event(name="LANGUAGE_CHANGED", type="com.soma.events.SomaEvent.LANGUAGE_CHANGED")]
	
	/** Indicates when Soma has been initialized.<br/><br/> 
	 * Soma.getInstance().addEventListener(SomaEvent.INITIALIZED, eventHandler);
     * @eventType com.soma.events.SomaEvent.INITIALIZED
     * @see com.soma.events.SomaEvent SomaEvent
     */
	[Event(name="INITIALIZED", type="com.soma.events.SomaEvent.INITIALIZED")]
	
	/** Indicates when the XML Site Definition has been loaded.<br/><br/>
	 * Soma.getInstance().addEventListener(StyleSheetEvent.LOADED, eventHandler);
     * @eventType com.soma.events.StyleSheetEvent.LOADED
     * @see com.soma.model.StyleManager StyleManager
     * @see com.soma.events.StyleSheetEvent StyleSheetEvent
     */
	[Event(name="LOADED", type="com.soma.events.StyleSheetEvent.LOADED")]
	
	/**
     * <p><b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br/>
     * <p><b>Information:</b><br/>
     * Blog page - <a href="http://www.soundstep.com/blog/downloads/somaui/" target="_blank">SomaUI</a><br/>
     * How does it work - <a href="http://www.soundstep.com/somaprotest/" target="_blank">Soma Protest</a><br/>
     * Project Host - <a href="http://code.google.com/p/somamvc/" target="_blank">Google Code</a><br/>
     * Documentation - <a href="http://www.soundstep.com/blog/source/somaui/docs/" target="_blank">Soma ASDOC</a><br/>
     * <b>Class version:</b> 2.0.1<br/>
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
     * The Soma Singleton (extendable) is the entry point to access to the framework.
     * </p>
     * @example
     * <listing version="3.0">
Soma.getInstance().addEventListener(SomaEvent.INITIALIZED, initialized);
Soma.getInstance().addEventListener(ContentEvent.LOADED, contentLoaded);
Soma.getInstance().registerGloBalStyleSheet("css/styles.css");
Soma.getInstance().start(this, "data/site.xml", new Config());

private function contentLoaded(e:ContentEvent = null):void {
    // xml and stylesheet have been loaded (components that don't require the XML Site Definition are initialized)
    trace(Soma.getInstance().container);
    trace(Soma.getInstance().content.data.toXMLString());
}

private function initialized(e:SomaEvent = null):void {
    // Soma is initialized
    trace(Soma.getInstance().page.currentPage);
}
     * </listing>
     */
	 
	public class Soma implements IModelLocator {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		// singleton instance
		private static var _instance:Soma = new Soma();
		// super class name (used to extend the singleton)
		private static var _className:String = getQualifiedClassName(super);
		
		// XML Site Definition URL
		private var _xmlFile:String;
		// whether or not soma is initialized
		private var _initialized:Boolean;
		// whether or the language is enable
		private var _languageEnabled:Boolean;
		// string language value used in the deep-linking URL
		private var _currentLanguage:String;
		// URL of a stylesheet registered, Soma will load it during the initialization process
		private var _registeredGlobalStyleSheet:String;
		// ClassImport instance (force the import of classes by the compiler).
		private var _classImport:ClassImport;
		
		// Main Class
		private var _ui:DisplayObjectContainer;
		// global BaseUI layout instance 
		private var _baseUI:BaseUI;
		// refence of the global BaseUI instance (stage for liquid layout, container for fixed layout)
		private var _referenceBaseUI:DisplayObjectContainer;
		// container container the site
		private var _container:Sprite;
		// instance of a Content Manager
		private var _content:ContentManager;
		// global library instance
		private var _library:ILibrary;
		// background manager instance (handle backgrounds in the site from the XML)
		private var _background:BackgroundManager;
		// base manager instance (handle elements that stays on the screen in the site from the XML)
		private var _base:BaseManager;
		// page manage instance (handle pages and deep-linking)
		private var _page:PageManager;
		// menu manager instance (handle menu)
		private var _menu:MenuManager;
		// global loader instance (SomaLoader)
		private var _loader:SomaLoader;
		// user config instance
		private var _config:IConfig;
		// style manager instance (stylesheets) 
		private var _styles:StyleManager;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Constant value of the Soma Version.*/
		public static const VERSION:String = "2.0.2";
		
		/** Constant value used to defined that the layout of the site is a liquid user interface, the width and height of the main container is updated to fit the browser (Soma.getInstance().container). The values are set in the XML Site definition &lt;site layout="liquid"&gt; or &lt;site&gt;.*/
		public static const LIQUID_LAYOUT:String = "liquid";
		/** Constant value used to defined that the layout of the site is a fixed user interface, the width and height are fixed values applied to the main container (Soma.getInstance().container). The values are set in the XML Site definition &lt;site layout="fixed" width="800" height="600"&gt;. */
		public static const FIXED_LAYOUT:String = "fixed";
		/** Constant value used to get a specific model class (manager) with the method getModel example: Soma.getInstance().getModel(Soma.MODEL_LOADER) equivalent to Soma.getInstance().loader */
		public static const MODEL_LOADER:String = "com.soma.Soma.MODEL_LOADER";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_BASE) equivalent to Soma.getInstance().base */
		public static const MODEL_BASE:String = "com.soma.Soma.MODEL_BASE";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_BACKGROUND) equivalent to Soma.getInstance().background */
		public static const MODEL_BACKGROUND:String = "com.soma.Soma.MODEL_BACKGROUND";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_CONTENT) equivalent to Soma.getInstance().content */
		public static const MODEL_CONTENT:String = "com.soma.Soma.MODEL_CONTENT";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_MENU) equivalent to Soma.getInstance().menu */
		public static const MODEL_MENU:String = "com.soma.Soma.MODEL_MENU";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_PAGE) equivalent to Soma.getInstance().page */
		public static const MODEL_PAGE:String = "com.soma.Soma.MODEL_PAGE";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_STYLE) equivalent to Soma.getInstance().styles */
		public static const MODEL_STYLE:String = "com.soma.Soma.MODEL_STYLE";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_LIBRARY) equivalent to Soma.getInstance().library */
		public static const MODEL_LIBRARY:String = "com.soma.Soma.MODEL_LIBRARY";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_CONFIG) equivalent to Soma.getInstance().config */
		public static const MODEL_CONFIG:String = "com.soma.Soma.MODEL_CONFIG";
		/** Constant value used to get a specific model class (manager) with the method getModel, example: Soma.getInstance().getModel(Soma.MODEL_BASEUI) equivalent to Soma.getInstance().baseUI */
		public static const MODEL_BASEUI:String = "com.soma.Soma.MODEL_BASEUI";
		
		/** static global value whether or not the user loading display (super class: com.soma.view.Loading, interface: com.soma.loader.ILoading) of the main global loader (Soma.getInstance().loader) will be centered in the layout (default true). It must be changed before starting Soma, if the value is true, the loading display class will be added to the global baseUI instance (Soma.getInstance().baseUI).  */
		public static var GLOBAL_LOADING_CENTERED:Boolean;
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Soma is an extendable Singleton, use Soma.getInstance(). See the Soma Protest source code for an example to extend Soma and alter the initializing/starting process. */
		public function Soma() {
			if (_instance != null && getQualifiedSuperclassName(this) != _className) throw Error("Soma is Singleton");
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/**
		 * @private
		 * initialize variables values
		 */
		protected function init():void {
			_initialized = false;
			_languageEnabled = false;
			GLOBAL_LOADING_CENTERED = true;
		}
		
		// start Soma (1 step)
		private function somaStart(ui:DisplayObjectContainer, xmlFile:String, config:IConfig):void {
			_xmlFile = xmlFile;
			_config = config;
			_ui = ui;
			initClassImport();
			initController();
			initLoader();
			initStyle();
			initLibrary();
			_config.init();
			initBackground(); // create a Sprite backgrounds
			initBase(); // create a Sprite base
			createContainer(); // create and add the main container
			createBaseUI();
			initContent();
			_content.start(_xmlFile);
		}
		
		// start Soma with a loaded XML (1 step)
		private function somaStartWithXML(ui:DisplayObjectContainer, xml:XML, config:IConfig):void {
			_config = config;
			_ui = ui;
			initClassImport();
			initController();
			initLoader();
			var stylesheetToLoad:Boolean = false;
			if (_registeredGlobalStyleSheet != null) {
				stylesheetToLoad = true;
				addEventListener(StyleSheetEvent.LOADED, stylesheetLoaded);
			}
			initStyle();
			initLibrary();
			_config.init();
			initBackground(); // create a Sprite backgrounds
			initBase(); // create a Sprite base
			createContainer(); // create and add the main container
			createBaseUI();
			initContent(xml);
			if (!stylesheetToLoad) contentLoaded();
		}
		
		// registered stylesheet has been loaded
		private function stylesheetLoaded(e:StyleSheetEvent):void {
			removeEventListener(StyleSheetEvent.LOADED, stylesheetLoaded);
			contentLoaded();
		}
		
		/** @private */
		protected function initClassImport():void {
			_classImport = new ClassImport();
		}

		/** @private */
		protected function initStyle():void {
			_styles = new StyleManager();
			if (_registeredGlobalStyleSheet != null) {
				_styles.loadStyleSheet(StyleManager.GLOBAL_STYLESHEET_ID, _registeredGlobalStyleSheet);
				_registeredGlobalStyleSheet = null;
			}
		}
		
		/** @private */
		protected function initLibrary():void {
			_library = new Library();
		}

		/** @private */
		protected function initController():void {
			SomaController.init();
		}
		
		/** @private */		
		protected function initBackground():void {
			_background = new BackgroundManager();
		}
		
		/** @private */
		protected function initBase():void {
			_base = new BaseManager();
		}
		
		/** @private */
		protected function createBaseUI():void {
			_baseUI = new BaseUI(_container);
		}
		
		/** @private */
		protected function createContainer():void {
			_container = new Sprite();
			_container.name = "SomaContainer";
			_ui.addChild(_container);
		}
		
		/** @private */
		protected function initContext():void {
			MenuContext.start();
		}
		
		/** @private */
		protected function initPage():void {
			_page = new PageManager();
			_page.start();
		}
		
		/** @private */
		protected function initMenu():void {
			_menu = new MenuManager();
		}
		
		/** @private */
		protected function initContent(xml:XML = null):void {
			_content = new ContentManager();
			if (xml != null) _content.data = xml;
		}
		
		/** @private */
		protected function initLoader():void {
			_loader = new SomaLoader();
		}
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/** 
		 * Soma is an extendable Singleton, getInstance() is returning the Soma instance to access to the framework and its components.
		 * @return Soma instance
		 */
		public static function getInstance():Soma {
			return _instance;
		}
		
		/** @private */
		public function updateInstance(instance:Soma):void {
			if (instance != null && instance is Soma) _instance = instance;
			else throw CairngormError(CairngormMessage.SOMA_INSTANCE_UPDATE);
		}
		
		/**
		 * Initialize a String language (the current language when Soma starts) to be used in the deep-linking URL with SWFAddress.<br/>
		 * It must be used before starting Soma and it will prepend the value before the URL, example: mysite.com/#/home will become mysite.com/#/en/home.<br/>
		 * The value can be changed at run-time using Soma.getInstance().currentLanguage and will dispatch a SomaEvent.LANGUAGE_CHANGED event through the framework.<br/>
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().initLanguage(true, "en");
		 * Soma.getInstance().addEventListener(SomaEvent.LANGUAGE_CHANGED, languageHandler);
		 * Soma.getInstance().currentLanguage = "de";
		 * </listing>
		 * @param languageEnabled Enable or Disable the language String in the URL.  
		 * @param language Specify the language String used in the URL, example: "en", "de", and so on.
		 */
		public function initLanguage(languageEnabled:Boolean, language:String = ""):void {
			_languageEnabled = languageEnabled;
			_currentLanguage = language;
		}
		
		/**
		 * Starts the Soma framework. The 3 parameters are required: the main document class, the URL of the XML Site definition describing the site structure and a Config file (interface: com.interface.IConfig) containing information needed by the framework.<br/>
		 * Part 1: Soma starts, creates the containers and initializes the global managers (such as controller, loader, config, ...).<br/>
		 * Part 2: Soma loads the XML Site definition (and stylesheet if set before starting).<br/>
		 * Part 3: Soma initializes the managers that need the XML Site definition (such as menu, loading, pages, styles, ...).<br/>
		 * Part 4: Soma dispatches a SomaEvent.INITIALIZED when done.<br/>
	     * @example
	     * <listing version="3.0">
Soma.getInstance().addEventListener(SomaEvent.INITIALIZED, initialized);
Soma.getInstance().addEventListener(ContentEvent.LOADED, contentLoaded);
Soma.getInstance().registerGloBalStyleSheet("css/styles.css");
Soma.getInstance().start(this, "data/site.xml", new Config());

private function contentLoaded(e:ContentEvent = null):void {
    // xml and stylesheet have been loaded (components that don't require the XML Site Definition are initialized)
    trace(Soma.getInstance().container);
    trace(Soma.getInstance().content.data.toXMLString());
}

private function initialized(e:SomaEvent = null):void {
    // Soma is initialized
    trace(Soma.getInstance().page.currentPage);
}
	     * </listing>
	     * @param ui main Document Class (AS Entry Point), accessible using Soma.getInstance().ui
	     * @param xmlFile URL of the XML Site Definition to load (describing the structure of the site), accessible using Soma.getInstance().content.data
	     * @param config user config file (containing framework options and global configuration), accessible using Soma.getInstance().config 
	     */
		public function start(ui:DisplayObjectContainer, xmlFile:String, config:IConfig):void {
			somaStart(ui, xmlFile, config);
		}
		
		/**
		 * Starts the Soma framework with an XML already loaded.
	     * @example
	     * <listing version="3.0">Soma.getInstance().start(this, myXMLSiteDefinition, new Config());</listing>
	     * @param ui main Document Class (AS Entry Point), accessible using Soma.getInstance().ui
	     * @param xml XML Site Definition (describing the structure of the site), accessible using Soma.getInstance().content.data
	     * @param config user config file (containing framework options and global configuration), accessible using Soma.getInstance().config 
	     */
		public function startWithXML(ui:DisplayObjectContainer, xml:XML, config:IConfig):void {
			somaStartWithXML(ui, xml, config);
		}
		
		/** @private */
		public function contentLoaded():void {
			setLayout();
			initPage(); // create a Sprite pages
			initMenu();
			_background.start();
			_base.start();
			MenuContext.start();
			if (_config.loadingClassName != null && _config.loadingClassName != "") {
				var LoadingClass:Class = getClass(_config.loadingClassName);
				var loading:ILoading = new LoadingClass() as ILoading;
				if (!(loading is DisplayObject)) throw new CairngormError(CairngormMessage.UTILS_INSTANCE_NOT_DISPLAYOBJECT, loading);
				_container.addChild(loading as DisplayObject);
				_loader.loading = loading;
				if (GLOBAL_LOADING_CENTERED) {
					var el:ElementUI = baseUI.add(loading as DisplayObject);
					el.horizontalCenter = el.verticalCenter = 0; 
				}
			}
			if (_config.menuClassName != null && _config.menuClassName != "") _container.addChild(_menu.add(_config.menuClassName));
			_initialized = true;
			new SomaEvent(SomaEvent.INITIALIZED).dispatch();
		}
		
		/**
		 * Whether or not Soma is initialized.
		 * @return a Boolean.
		 */
		public function get initialized():Boolean {
			return _initialized;
		}
		
		/** 
		 * Register the URL of a global stylesheet (css) to load at the initialization process.
		 * Soma will load the stylesheet (before the XML) and dispatch a StyleSheetEvent.LOADED event.
	     * @example
	     * <listing version="3.0">
Soma.getInstance().registerGloBalStyleSheet("css/styles.css");
Soma.getInstance().addEventListener(StyleSheetEvent.LOADED, stylesheetHandler);
Soma.getInstance().start(this, "data/site.xml", new Config());

private function stylesheetHandler(e:StyleSheetEvent):void {
	trace(e.stylesheet);
	trace(Soma.getInstance().style.getStyleSheet(StyleManager.GLOBAL_STYLESHEET_ID));
}
	     * </listing>
		 * @param url URL of the global stylesheet.
		 */
		public function registerGloBalStyleSheet(url:String):void {
			_registeredGlobalStyleSheet = url;
		}
		
		/** @private */
		public function setLayout():void {
			_container.graphics.clear();
			if (_baseUI.contains(_container)) _baseUI.remove(_container);
			if (_content.data.@layout == LIQUID_LAYOUT || !_content.data.hasOwnProperty("@layout")) {
				_referenceBaseUI = _ui.stage;
			}
			else if (_content.data.@layout == FIXED_LAYOUT) {
				_referenceBaseUI = _container;
				if (!_content.data.hasOwnProperty("@width")) throw new CairngormError(CairngormMessage.LAYOUT_WIDTH_MISSING);
				if (!_content.data.hasOwnProperty("@height")) throw new CairngormError(CairngormMessage.LAYOUT_HEIGHT_MISSING);
				var bgColor:Number = (!_content.data.hasOwnProperty("@backgroundColor")) ? 0x000000 : parseInt(_content.data.@backgroundColor, 16);
				var bgAlpha:Number = (!_content.data.hasOwnProperty("@backgroundAlpha")) ? 0 : Number(_content.data.@backgroundAlpha);
				_container.graphics.beginFill(bgColor, bgAlpha);
				_container.graphics.drawRect(0, 0, Number(_content.data.@width), Number(_content.data.@height));
				_content.data.@bypassSize = "true";
				_content.data.@useInitialSize = "true";
				SomaUtils.setBaseUIProperties(_container, _baseUI, _content.data);
			}
			else throw new CairngormError(CairngormMessage.LAYOUT_UNKNOWN);
			_baseUI.reference = _referenceBaseUI;
		}
		
		/** @inheritDoc */
		public function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
			CairngormEventDispatcher.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
  		}
  		
		/** @inheritDoc */
		public function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
  			CairngormEventDispatcher.removeEventListener(p_type, p_listener, p_useCapture);
  		}
  		
		/** @inheritDoc */
		public function dispatchEvent(p_event:CairngormEvent):Boolean {
  			return CairngormEventDispatcher.dispatchEvent(p_event);
		}
		
		/** @inheritDoc */
		public function hasEventListener(type:String):Boolean {
			return CairngormEventDispatcher.hasEventListener(type);
		}

		/** @inheritDoc */
		public function willTrigger(type:String):Boolean {
			return CairngormEventDispatcher.willTrigger(type);
		}
		
		/** 
		 * Whether or not the language is enabled.
		 * @return a Boolean.
		 */
		public function get languageEnabled():Boolean {
			return _languageEnabled;
		}
		
		public function set languageEnabled(languageEnabled:Boolean):void {
			_languageEnabled = languageEnabled;
		}
		
		/** 
		 * Current language String (example: "en") set using Soma.getInstance().initLanguage(true, "en");
		 * @return a String.
		 */
		public function get currentLanguage():String {
			return _currentLanguage;
		}
		
		public function set currentLanguage(currentLanguage:String):void {
			_currentLanguage = currentLanguage;
			new SomaEvent(SomaEvent.LANGUAGE_CHANGED).dispatch();
		}
		
		/** 
		 * Get the main document class registered when Soma starts, usually Sprite or MovieClip. To access to your own Document class methods and property you can cast to your own class: MyMainClass(Soma.getInstance().ui).myMethod()
		 * @return a DisplayObjectContainer.
		 */
		public function get ui():DisplayObjectContainer {
			return _ui;
		}
		
		/** 
		 * Get the global BaseUI instance (used for loading class if centered and the layout if set to fixed).
		 * @return a DisplayObjectContainer.
		 */
		public function get baseUI():BaseUI {
			return _baseUI;
		}
		
		/** 
		 * Get the reference of the global BaseUI instance, the reference is the main container if the layout is set to fixed or the stage if the layout is set to liquid.
		 * @return a DisplayObjectContainer.
		 */
		public function get referenceBaseUI():DisplayObjectContainer {
			return _referenceBaseUI;
		}
		
		/** 
		 * Get the main container of the site (contains pages, menu and loading);
		 * @return a Sprite.
		 */
		public function get container():Sprite {
			return _container;
		}
		
		/** 
		 * Get the content manager (containing the XML Site Definition).
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().content.data // access to the XML Site Definition
		 * </listing>
		 * @return the ContentManager instance.
		 */
		public function get content():ContentManager {
			return _content;
		}
		
		/** 
		 * Get the background manager (containing the background container and the backgrounds).
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().background.container // access to container of the backgrounds
		 * Soma.getInstance().background.currentBackground // access to currently displayed background
		 * </listing>
		 * @return the BackgroundManager instance.
		 */
		public function get background():BackgroundManager {
			return _background;
		}
		
		/** 
		 * Get the page manager (containing the page container and the pages).
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().page.currentPage // access to the current page
		 * </listing>
		 * @return the PageManager instance.
		 */
		public function get page():PageManager {
			return _page;
		}
		
		/** 
		 * Get the menu manager (containing the global menu if used).
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().menu.getMenu(Soma.getInstance().config.menuClassName) // access to the global menu
		 * </listing>
		 * @return the MenuManager instance.
		 */
		public function get menu():MenuManager {
			return _menu;
		}
		
		/** 
		 * Get the global loader (used to load the stylesheet, the XML Site Definition and the assets in the pages).
		 * @example
		 * <listing version="3.0">
		 * var itemloaded:Dictionary = Soma.getInstance().loader.getLoadedItems(); // access to a list of items previously loaded
		 * Soma.getInstance().loader.add("image.jpg"); // add an image to load in the global loader
		 * Soma.getInstance().loader.start(); // start to load
		 * </listing>
		 * @return the SomaLoader global instance.
		 */
		public function get loader():SomaLoader {
			return _loader;
		}
		
		/** 
		 * Get the config file.
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().config.siteName(); // access to the site name
		 * MyConfig(Soma.getInstance().config).myConfigMethod(); // access to a specific user method
		 * </listing>
		 * @return the Config class instance.
		 */
		public function get config():IConfig {
			return _config;
		}
		
		/** 
		 * Get the style manager (containing stylesheets loaded).
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().style.loadStyleSheet("myStylesheet", "myNewStyleSheet.css"); // load a stylesheet
		 * Soma.getInstance().style.getStyleSheet("myStylesheet"); // get a stylesheet
		 * Soma.getInstance().style.getGlobalStyle("myStyle"); // get a style from the global stylesheet
		 * </listing>
		 * @return the StyleManager instance.
		 */
		public function get styles():StyleManager {
			return _styles;
		}
		
		/** 
		 * Get the global library. It contains special assets registered by the framework such as SomaText, SomaVideo, ... and used by a NodeParser instance to dynamically instantiate assets from the XML Site Definition.
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().library.registerAsset("myAsset", "com.mypackage.MyAssetClass"); // register a custom asset class
		 * &lt;myAsset id="myAssetID" x="10" y="10" /&gt; // use of a registered custom asset in the XML Site Definition
		 * </listing>
		 * @return the StyleManager instance.
		 */
		public function get library():ILibrary {
			return _library;
		}				/** 
		 * Get the base manager library. The Base is a Sprite layer between the backgrounds Sprite layer and the site container layer and is meant to easily add DisplayObject (even from the XML) that are always on the screen (such as a logo). 
		 * @example
		 * <listing version="3.0">
		 * Soma.getInstance().base.container; // access to the container of the Base layer
		 * Soma.getInstance().base.getElementByID("my asset") // access to a Base DisplayObject (instantiated from the XML or by code).
		 * </listing>
		 * @return the StyleManager instance.
		 */
		public function get base():BaseManager {
			return _base;		}
		
		/** 
		 * Get a model instance from Soma (managers). 
		 * @example
		 * <listing version="3.0">
		 * // access to the background manager (equals to Soma.getInstance().background);
		 * var background:BackgroundManager = Soma.getInstance().getModel(Soma.MODEL_BACKGROUND) as BackgroundManager;
		 * </listing>
		 * @return the StyleManager instance.
		 */
		public function getModel(model:String):* {
			switch (model) {
				case MODEL_LOADER:
					return _loader;
					break;
				case MODEL_BASE:
					return _base;
					break;
				case MODEL_BACKGROUND:
					return _background;
					break;
				case MODEL_CONTENT:
					return _content;
					break;
				case MODEL_MENU:
					return _menu;
					break;
				case MODEL_PAGE:
					return _page;
					break;
				case MODEL_STYLE:
					return _styles;
					break;
				case MODEL_LIBRARY:
					return _library;
					break;
				case MODEL_CONFIG:
					return _config;
					break;
				case MODEL_BASEUI:
					return _baseUI;
					break;
				default:
					return null;
					break;
			}
		}
		
		/** Return the global ClassImport instance (use Soma.getInstance().registerClass and Soma.getInstance().getClass). 
		 * @return An instance of ClassImport.
		 */
		public function get classImport():ClassImport {
			return _classImport;
		}
		
		/** Get a Class registered using the method Soma.getInstance().registerClass.
		 * <listing version="3.0">
		 * var MyClassType:Class = Soma.getInstance().getClass("MyClass");
		 * </listing>
		 * @param className Class name (String) of a class to force its import by the compiler (useful with getDefinitionByName).
		 * @return A Class.
		 */
		public function getClass(className:String):Class {
			return _classImport.getClass(className);
		}
		
		/** Register a Class with the ClassImport instance to force its import by the compiler (useful with getDefinitionByName).
		 * You can get the class using the method Soma.getInstance().getClass.
		 * <listing version="3.0">
		 * Soma.getInstance().registerClass(MyClass);
		 * </listing>
		 * @param value Class.
		 * @return The String of the class name.
		 */
		public function registerClass(value:Class):String {
			return _classImport.register(value);
		}
		
	}
}
