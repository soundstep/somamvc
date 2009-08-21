package com.soma.model {
	import com.soma.Soma;
	import com.soma.assets.NodeParser;
	import com.soma.errors.CairngormError;
	import com.soma.errors.CairngormMessage;
	import com.soma.events.BackgroundEvent;
	import com.soma.events.ParserEvent;
	import com.soma.interfaces.IDisposable;
	import com.soma.loader.SomaLoader;
	import com.soma.loader.SomaLoaderEvent;
	import com.soma.loader.SomaLoaderItem;
	import com.soma.utils.SomaUtils;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import com.soundstep.utils.Easing;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Dictionary;

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
     * The BackgroundManager handles backgrounds in a Sprite layer underneath the site and provides an easy way to load, display and hide backgrounds.
     * The backgrounds can automatically be loaded and/or instantiated from the XML Site Definition (nodes children of a backgrounds node).<br/><br/>
     * The global background manager instance is accessible using:
     * <listing version="3.0">Soma.getInstance().background</listing>
     * The backgrounds container (Sprite) is accessible using:
     * <listing version="3.0">Soma.getInstance().background.container</listing>
     * The current background displayed is accessible using:
     * <listing version="3.0">Soma.getInstance().background.currentBackground</listing>
     * The backgrounds supported are the the ones supported by the NodeParser class (see link below), they can be image, bitmap, movieclip, video or your own custom classes, here are some examples:
     * <listing version="3.0">
&lt;video id="myVideo" url="video/video.flv" x="50" alpha=".5" verticalCenter="0" volume="0" /&gt;
&lt;image id="myImage" file="image.png" scaleX=".5" scaleY=".5" blendMode="multiply" ratio="ratio_in"/&gt;
&lt;bitmap id="myBitmap" linkage="AssetClassNameBitmap" x="170" y="170" blendMode="multiply" scaleX=".3" scaleY=".3"/&gt;
&lt;movieclip id="myMovieClip" linkage="AssetClassNameMovieClip" x="170" y="280" scaleX=".3" scaleY=".3"/&gt;
     * </listing>
     * Soma provides commands to show and hide backgrounds using the attribute id of an asset node in the background node of the XML Site Definition.
     * <listing version="3.0">
     * new BackgroundEvent(BackgroundEvent.SHOW, "myBackgroundID").dispatch();
     * new BackgroundEvent(BackgroundEvent.HIDE, "myBackgroundID").dispatch();
     * </listing>
     * Two listeners can be added to Soma control the transitions (can be default prevented).
     * <listing version="3.0">
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_IN, eventHandler);
	 * Soma.getInstance().addEventListener(BackgroundEvent.TRANSITION_OUT, eventHandler);
     * </listing>
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.events.BackgroundEvent BackgroundEvent
     * @see com.soma.assets.NodeParser NodeParser
     * @see com.soma.events.ParserEvent ParserEvent
     * @see com.soma.loader.SomaLoader SomaLoader
     * @see com.soma.loader.SomaLoaderEvent SomaLoaderEvent
     */
	
	public class BackgroundManager implements IDisposable {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _backgroundsArray:Array;
		private var _tweenObject:Dictionary;
		private var _container:Sprite;
		private var _currentBackground:DisplayObject;
		private var _content:XMLList;
		private var _parser:NodeParser;
		private var _loader:SomaLoader;
		private var _baseUI:BaseUI;
		private var _ease:Number;

		//------------------------------------
		// public properties
		//------------------------------------
		
		/** Default time value in seconds used to show a background (alpha tween). */
		public static var TRANSITION_IN_TIME:Number = 2;
		/** Default time value in seconds used to hide a background (alpha tween). */
		public static var TRANSITION_OUT_TIME:Number = 2;
		/** Default easing equations used to hide and show the background. */
		public static var TRANSITION_EASING:Function = Easing.ExpoOut;
		/** Default value whether or not a background video will be played from the start when displayed. */
		public static var REPLAY_BACKGROUND_VIDEO:Boolean = true;

		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Creates a BackgroundManager instance, the global BackgroundManager instance is accessible using Soma.getInstance().background.
		 */
		public function BackgroundManager() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/** @private initializes variables */
		protected function init():void {
			_tweenObject = new Dictionary();
			_ease = .15;
			_backgroundsArray = [];
			dispose();
			_container = new Sprite();
			_container.name = "backgrounds";
			Soma.getInstance().ui.addChildAt(_container, 0);
			_baseUI = new BaseUI(_container);
			setLoader();
		}
		
		/** @private creates loader */
		protected function setLoader():void {
			_loader = new SomaLoader();
		}
		
		/** @private parses and creates backgrounds from XML nodes */
		protected function createBackgrounds():void {
			_loader.addEventListener(SomaLoaderEvent.QUEUE_CHANGED, setBinary);
			_loader.addEventListener(SomaLoaderEvent.COMPLETE, backgroundComplete);
			_loader.addEventListener(SomaLoaderEvent.ERROR, backgroundError);
			_parser = new NodeParser(Soma.getInstance().library);
			_parser.addEventListener(ParserEvent.COMPLETE, parserComplete);
			_parser.add(_content.children());
			_backgroundsArray = _parser.run(_container, _baseUI, _loader);
			_loader.removeEventListener(SomaLoaderEvent.QUEUE_CHANGED, setBinary);
			for (var i:int=0; i<_backgroundsArray.length; i++) {
				if (_backgroundsArray[i].hasOwnProperty("stop")) {
					_backgroundsArray[i]['stop']();
				}
				_backgroundsArray[i].alpha = 0;
				_backgroundsArray[i].visible = false;
				_tweenObject[_backgroundsArray[i]] = {};
				_tweenObject[_backgroundsArray[i]].time = 0;
				_tweenObject[_backgroundsArray[i]].begin = 0;
			}
		}
		
		/** @private parser complete event handler */
		protected function parserComplete(e:ParserEvent):void {
			disposeParser();
		}
		
		/** @private dispose parser */
		protected function disposeParser():void {
			_parser.removeEventListener(ParserEvent.COMPLETE, parserComplete);
			_parser.dispose();
			_parser = null;
		}
		
		/** @private set loading dataformat */
		protected function setBinary(e:SomaLoaderEvent):void {
			var item:SomaLoaderItem = _loader.getLastItem();
			item.dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		/** @private check is the asset loaded is a child of the backgrounds node */
		protected function isBackground(url:String):Boolean {
			var list:XMLList = _content.children().(attribute('file') == url);
			return (list.length() > 0);
		}
		
		/** @private background loading complete */
		protected function backgroundComplete(e:SomaLoaderEvent):void {
			var item:SomaLoaderItem = e.item;
			if (!isBackground(item.url)) return;
			if (item.container == _currentBackground) {
				var bgName:String = _currentBackground.name;
				if (item.file is Bitmap) {
					showFromBinary(item.file, item.data['node']);
				}
				else {
					_currentBackground = null;
					show(bgName);
				}
			}
		}
		
		/** @private background loading error */
		protected function backgroundError(e:SomaLoaderEvent):void {
			trace("Error in BackgroundManager instance, a loading failed (" + e.item.url + "): ", e.errorMessage);
		}
		
		/** @private display an asset when created from binary data */
		protected function showFromBinary(bitmap:Bitmap, node:XML):void {
			while (DisplayObjectContainer(_currentBackground).numChildren > 0) {
				DisplayObjectContainer(_currentBackground).removeChildAt(0);
			}
			DisplayObjectContainer(_currentBackground).addChild(bitmap);
			if (_baseUI.getElement(_currentBackground) == null) {
				SomaUtils.setBaseUIProperties(_currentBackground, _baseUI, node);
			}
			showAsset();
		}
		
		/** @private show background */
		protected function showAsset():void {
			var el:ElementUI = _baseUI.getElement(_currentBackground);
			if (el != null) el.forceRefresh();
			if (REPLAY_BACKGROUND_VIDEO && _currentBackground.hasOwnProperty("seek") && _currentBackground.hasOwnProperty("play")) {
				_currentBackground["seek"](0);
				_currentBackground["play"]();
			}
			var event:BackgroundEvent = new BackgroundEvent(BackgroundEvent.TRANSITION_IN, _currentBackground.name, true, true);
			event.dispatch();
			if (!event.isDefaultPrevented()) {
				reset(_currentBackground);
				_currentBackground.addEventListener(Event.ENTER_FRAME, showTransition);
			}	
		}
		
		/** @private hide background */
		protected function hideTransition(e:Event):void {
			var background:DisplayObject = e['target'];
			var num:Number = TRANSITION_EASING(_tweenObject[background].time, 1 - _tweenObject[background].begin, 1, TRANSITION_OUT_TIME);
			background.alpha = 1 - num;
			_tweenObject[background].time = (new Date().getTime() - _tweenObject[background].startTime) * 0.001;
			if (background.alpha <= 0) {
				background.alpha = 0;
				background.visible = false;
				background.removeEventListener(Event.ENTER_FRAME, hideTransition);
				if (background.hasOwnProperty("stop")) {
					background['stop']();
				}
			}
		}
		
		/** @private start transition in */
		protected function showTransition(e:Event):void {
			var background:DisplayObject = e['target'];
			if (!background.visible) background.visible = true;
			var num:Number = TRANSITION_EASING(_tweenObject[background].time, _tweenObject[background].begin, 1, TRANSITION_IN_TIME);
			background.alpha = num;
			_tweenObject[background].time = (new Date().getTime() - _tweenObject[background].startTime) * 0.001;
			if (background.alpha >= 1) {
				background.alpha = 1;
				background.removeEventListener(Event.ENTER_FRAME, showTransition);
			}
		}
		
		/** @private remove enterframe listeners and reset tween values */
		protected function reset(target:DisplayObject):void {
			if (_tweenObject[target] == undefined) return;
			_tweenObject[target].time = 0;
			_tweenObject[target].begin = target.alpha;
			_tweenObject[target].startTime = new Date().getTime();
			if (target.hasEventListener(Event.ENTER_FRAME)) {
				target.removeEventListener(Event.ENTER_FRAME, hideTransition);
				target.removeEventListener(Event.ENTER_FRAME, showTransition);
			}
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		/** Entry point of the BackgroundManager, it will create (and load) the backgrounds from the children nodes of the backgrounds node from the XML Site Definition. */
		public function start():void {
			init();
			_content = Soma.getInstance().content.getBackgrounds();
			if (_content.children().length() > 0) createBackgrounds();
		}
		
		/** Disposes the BackgroundManager instance. Removes listeners and destroys backgrounds, loader, parser and container. */
		public function dispose():void {
			if (_container != null) {
				_baseUI.removeAll();
				_baseUI = null;
				while (_container.numChildren > 0) {
					_container.removeChildAt(0);
				}
				Soma.getInstance().ui.removeChild(_container);
				_container = null;
				if (_loader != null) {
					_loader.stop();
					_loader.dispose(true);
					_loader = null;
				}
				if (_parser != null) disposeParser();
				_currentBackground = null;
			}
		}
		
		/** Method called from the BackgroundEvent.HIDE command to hide the current background displayed. */
		public function hide():void {
			if (_currentBackground != null) {
				var event:BackgroundEvent = new BackgroundEvent(BackgroundEvent.TRANSITION_OUT, _currentBackground.name, true, true);
				event.dispatch();
				if (!event.isDefaultPrevented()) {
					reset(_currentBackground);
					_currentBackground.addEventListener(Event.ENTER_FRAME, hideTransition);
					_currentBackground = null;
				}
			}
		}
		
		/** Method called from the BackgroundEvent.SHOW command to show a background using its id from the XML node.
		 * @param id Attribute id of the XML node asset (in backgrounds node in the XML Site Definition).
		 */
		public function show(id:String):void {
			var b:DisplayObject = _container.getChildByName(id) as DisplayObject;
			if (id == "none" || id == "false" || id == "") {
				hide();
				_currentBackground = null;
			}
			else if (b != null && b != _currentBackground) {
				hide();
				_currentBackground = b;
				_currentBackground.alpha = 0;
				_currentBackground.visible = false;
				_container.addChild(_currentBackground);
				// load binary
				var item:SomaLoaderItem = _loader.getBinaryLoadedItemByOwnKey("id", id);
				if (item == null) {
					var url:String = _content.children().(@id == id).@file;
					if (url == "") {
						// not an external file
						showAsset();
					}
					else {
						// background not loaded, change priority 
						_loader.pause();
						_loader.setIndex(url, 0);
						_loader.start();
					}
				}
				else {
					// background loaded, add Binary in the queue 
					_loader.pause();
					_loader.addBinaryAt(item, 0);
					_loader.start();
				}
			}
			else if (b == null) {
				throw new CairngormError(CairngormMessage.BACKGROUND_NOT_FOUND, id);
			}
		}
		
		/**
		 * Get the Sprite container that contains the backgrounds, this container is by default on the index 0 in the display list (added to the main class).
		 * @return A Sprite instance that contains the backgrounds.
		 */
		public function get container():Sprite {
			return _container;
		}
		
		/**
		 * Get the current background displayed, returns a DisplayObject but you can cast the value returned to the proper type, example for a video node:
	     * <listing version="3.0">&lt;video id="myVideo" url="video/video.flv" x="50" alpha=".5" verticalCenter="0" volume="0" /&gt;</listing>
	     * <listing version="3.0">
		 * var video:SomaVideo = Soma.getInstance().background.currentBackground as SomaVideo;
		 * video.volume = .5;
 		 * </listing>
 		 * @return A DisplayObject instance.
		 */
		public function get currentBackground():DisplayObject {
			return _currentBackground;
		}
		
		/**
		 * Get a background in the container using its attribute id from the XML node.
 		 * @return A DisplayObject instance.
		 */
		public function getBackgroundByID(id:String):DisplayObject {
			return _container.getChildByName(id);
		}
		
		/**
		 * Get the SomaLoader instance used to load the backgrounds.
		 * @return A SomaLoader instance.
		 */
		public function get loader():SomaLoader {
			return _loader;
		}
		
		/**
		 * Get the BaseUI instance used if BaseUI properties have been found in the XML (such as ratio, alignX and so on).
		 * @return A BaseUI instance.
		 */
		public function get baseUI():BaseUI {
			return _baseUI;
		}
		
		/**
		 * Get the NodeParser instance used to parse the nodes and instantiate the backgrounds.
		 * @return A NodeParser instance.
		 */
		public function get parser():NodeParser {
			return _parser;
		}
		
	}
}