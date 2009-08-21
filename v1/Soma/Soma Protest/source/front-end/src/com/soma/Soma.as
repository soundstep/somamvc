package com.soma {
	
	import com.soma.model.MenuContext;	
	import com.soma.model.StyleManager;	
	import com.soma.model.TransitionManager;	
	import com.soma.model.TemplateManager;	
	import com.soma.model.LoaderManager;	
	import com.soma.model.MenuManager;	
	import com.soma.model.PageManager;	
	import com.soma.model.BackgroundManager;	
	import com.soma.interfaces.ITransition;
	import com.soma.events.SomaEvent;	
	import com.soma.interfaces.IConfig;	
	import com.soma.events.ContentEvent;	
	import com.soma.control.CairngormEvent;	
	import com.soma.control.CairngormEventDispatcher;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import flash.display.DisplayObjectContainer;	
	import com.soundstep.ui.BaseUI;	
	import flash.display.Sprite;	
	import com.soma.model.ContentManager;	
	import com.soma.interfaces.IModelLocator;
	import com.soma.control.SomaController;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;

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
	 
	public class Soma implements IModelLocator {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var _instance:Soma = new Soma();
		private static var _className:String = getQualifiedClassName(super);
		
		private var _xmlFile:String;
		private var _initialized:Boolean;
		private var _languageEnabled:Boolean;
		private var _currentLanguage:String;
		private var _registeredGlobalStyleSheet:String;
		
		private var _ui:Sprite;
		private var _baseUI:BaseUI;
		private var _referenceBaseUI:DisplayObjectContainer;
		private var _container:Sprite;
		private var _content:ContentManager;
		private var _background:BackgroundManager;
		private var _page:PageManager;
		private var _menu:MenuManager;
		private var _loader:LoaderManager;
		private var _template:TemplateManager;
		private var _config:IConfig;
		private var _transition:TransitionManager;
		private var _userTransition:ITransition;
		private var _styles:StyleManager;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const LIQUID_LAYOUT:String = "liquid";
		public static const FIXED_LAYOUT:String = "fixed";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Soma() {
			if (_instance != null && getQualifiedSuperclassName(this) != _className) throw Error("Soma is Singleton");
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function init():void {
			_initialized = false;
			_languageEnabled = false;
		}
		
		protected function somaStart(ui:Sprite, xmlFile:String, config:IConfig, transition:ITransition):void {
			_xmlFile = xmlFile;
			_config = config;
			_userTransition = transition;
			_ui = ui;
			initController();
			initContent();
			initLoader();
			initStyle();
			initTransitions();
			_config.init();
			initTemplate();
			initBackground(); // create a Sprite backgrounds
			createContainer(); // create and add the main container
			createBaseUI();
			_content.start(_xmlFile);
		}
		
		protected function initStyle():void {
			_styles = new StyleManager();
			if (_registeredGlobalStyleSheet != null) {
				_styles.loadStyleSheet(StyleManager.GLOBAL_STYLESHEET_ID, _registeredGlobalStyleSheet);
				_registeredGlobalStyleSheet = null;
			}
		}
		
		protected function initTransitions():void {
			_transition = new TransitionManager();
		}

		protected function initController():void {
			SomaController.init();
		}
				
		protected function initBackground():void {
			_background = new BackgroundManager();
		}
		
		protected function createBaseUI():void {
			_baseUI = new BaseUI(_container);
		}
		
		protected function createContainer():void {
			_container = new Sprite();
			_container.name = "SomaContainer";
			_ui.addChild(_container);
		}
		
		protected function setLayout():void {
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
				_template.setBaseUI(_container, _baseUI, _content.data);
			}
			else throw new CairngormError(CairngormMessage.LAYOUT_UNKNOWN);
			_baseUI.reference = _referenceBaseUI;
		}
		
		protected function initContext():void {
			MenuContext.start();
		}
		
		protected function initPage():void {
			_page = new PageManager();
		}
		
		protected function initMenu():void {
			_menu = new MenuManager();
		}
		
		protected function initContent():void {
			_content = new ContentManager();
		}
		
		protected function initTemplate():void {
			_template = new TemplateManager();
		}
		
		protected function initLoader():void {
			_loader = new LoaderManager();
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public static function getInstance():Soma {
			return _instance;
		}
		
		public function updateInstance(instance:Soma):void {
			if (instance != null && instance is Soma) _instance = instance;
			else throw new Error("Incorrect Soma instance update");
		}
		
		public function initLanguage(languageEnabled:Boolean, language:String = ""):void {
			_languageEnabled = languageEnabled;
			_currentLanguage = language;
		}
		
		public function start(ui:Sprite, xmlFile:String, config:IConfig, transitions:ITransition):void {
			somaStart(ui, xmlFile, config, transitions);
		}
		
		public function contentLoaded():void {
			if (_initialized) {
				trace("Soma has been already initialized...");
			}
			else {
				setLayout();
				initPage(); // create a Sprite pages
				initMenu();
				_background.start();
				MenuContext.start();
				if (_config.loadingClass != null && _config.loadingClass != "") _loader.addLoading(_config.loadingClass);
				_page.start();
				if (_config.menuClass != null && _config.menuClass != "") _container.addChild(_menu.add(_config.menuClass));
				_initialized = true;
				new ContentEvent(ContentEvent.INITIALIZED).dispatch();
			}
		}
		
		public function get initialized():Boolean {
			return _initialized;
		}
		
		public function registerGloBalStyleSheet(url:String):void {
			_registeredGlobalStyleSheet = url;
		}
		
		public function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
			CairngormEventDispatcher.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
  		}
  		
		public function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
  			CairngormEventDispatcher.removeEventListener(p_type, p_listener, p_useCapture);
  		}
  		
		public function dispatchEvent(p_event:CairngormEvent):Boolean {
  			return CairngormEventDispatcher.dispatchEvent(p_event);
		}
		
		public function hasEventListener(type:String):Boolean {
			return CairngormEventDispatcher.hasEventListener(type);
		}

		public function willTrigger(type:String):Boolean {
			return CairngormEventDispatcher.willTrigger(type);
		}
		
		public function get languageEnabled():Boolean {
			return _languageEnabled;
		}
		
		public function set languageEnabled(languageEnabled:Boolean):void {
			_languageEnabled = languageEnabled;
		}
		
		public function get currentLanguage():String {
			return _currentLanguage;
		}
		
		public function set currentLanguage(currentLanguage:String):void {
			_currentLanguage = currentLanguage;
			new SomaEvent(SomaEvent.LANGUAGE_CHANGED).dispatch();
		}
		
		public function get ui():Sprite {
			return _ui;
		}
		
		public function get baseUI():BaseUI {
			return _baseUI;
		}
		
		public function get referenceBaseUI():DisplayObjectContainer {
			return _referenceBaseUI;
		}
		
		public function get container():Sprite {
			return _container;
		}
		
		public function get content():ContentManager {
			return _content;
		}
		
		public function get background():BackgroundManager {
			return _background;
		}
		
		public function get page():PageManager {
			return _page;
		}
		
		public function get menu():MenuManager {
			return _menu;
		}
		
		public function get loader():LoaderManager {
			return _loader;
		}
		
		public function get template():TemplateManager {
			return _template;
		}
		
		public function get config():IConfig {
			return _config;
		}
		
		public function get styles():StyleManager {
			return _styles;
		}
		
		public function get transition():TransitionManager {
			return _transition;
		}
		
		public function get userTransition():ITransition {
			return _userTransition;
		}
		
	}
}
