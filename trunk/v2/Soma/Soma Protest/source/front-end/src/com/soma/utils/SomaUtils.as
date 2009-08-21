package com.soma.utils {
	import flash.text.Font;
	import com.soma.errors.CairngormError;
	import com.soma.errors.CairngormMessage;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;		

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
     * SomaUtils is static utility class containing some methods that might help in every project.
     * </p>
     * 
     */
	 
	public class SomaUtils {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private static var somaUtils:SomaUtils = new SomaUtils();
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		/** SomaUtils is a static class, trying to create an instance will throw an Error, instead use the method this way: SomaUtils.stringToBoolean("true") */
		public function SomaUtils() {
			if (somaUtils) throw new CairngormError(CairngormMessage.UTILS_SINGLETON_INSTANTIATION_ERROR, this);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private static function getType(prop:*, val:String):* {
			if (prop is Boolean) return (val == "true") ? true : false;
			else if (prop is Number) return Number(val);
			else return val;
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Get the URL of a Flash Movie. For example if have a movie Main.swf located on http://www.server.com/Main.swf, add this code in the main class to get its URL:
		 * <listing version="3.0">
		 * trace(SomaUtils.getRootURL(this)); // will trace http://www.server.com/
		 * </listing>
		 * @param container A DisplayObject instance (for example the main class).
		 * @return A String (URL).
		 */
		public static function getRootURL(container:DisplayObjectContainer):String {
			var fullURL:String = container.loaderInfo.url;
			var url:String = fullURL.substr(0, fullURL.lastIndexOf("/")+1);
			return url;
		}
		
		/**
		 * Cast a String value to a Boolean.
		 * <listing version="3.0">
trace(SomaUtils.stringToBoolean("0")); // return a Boolean false
trace(SomaUtils.stringToBoolean("1")); // return a Boolean true
trace(SomaUtils.stringToBoolean("false")); // return a Boolean false
trace(SomaUtils.stringToBoolean("true")); // return a Boolean true
trace(SomaUtils.stringToBoolean("whatever")); // return a Boolean false
		 * </listing>
		 * @param value A String.
		 * @return A Boolean.
		 */
		public static function stringToBoolean(value:String):Boolean {
			return (value.toLowerCase() == "true" || value.toLowerCase() == "1");
		}
		
		/**
		 * Set values to the properties of an Object (can be anything) using an XML node. 
		 * <listing version="3.0">
		 * SomaUtils.setProperties(mySprite, new XML('&lt;node x="10" alpha="1" visible="true" name="mySpriteName" mouseChildren="false"/&gt;'), ['mouseChildren']);
		 * </listing>
		 * @param target A Object (can be a class, a Sprite or anything).
		 * @param node A XML node describing the properties and values.
		 * @param exception An Array of property names that won't be applied to the target.
		 */
		public static function setProperties(target:Object, node:XML, exception:Array = null):void {
			try {
				// a labeled loop is better but it breaks FDT!
				if (target == null) return;
				var att:XMLList = node.attributes();
				for (var a:int=0; a<att.length(); a++) {
					var attName:String = String(att[a].name());
					var allow:Boolean = true;
					if (target == null) return;
					if (target.hasOwnProperty(attName)) {
						if (exception != null) {
							for (var i:int=0; i<length; i++) {
								if (attName == exception[i]) {
									allow = false;
									break;
								}
							}
						}
						if (allow) target[attName] = getType(target[attName], String(att[a]));
					}
				}
			} catch (err:Error) {
				if (target != null) {
					trace("Error in NodeParser.setProperties, target: ", target);
					if (node != null) trace("node: ", node.toXMLString());
					trace(err);
				}
			}
		}
		
		/**
		 * Set BaseUI values (such as top, ratio, horizontalCenter, and so on) to a DisplayObject, it will add the DisplayObject in the BaseUI instance if not found. 
		 * <listing version="3.0">
		 * SomaUtils.setProperties(mySprite, instanceBaseUI, new XML('&lt;node width="80%" top="10" bottom="10"/&gt;'));
		 * </listing>
		 * @param target A DisplayObject (such as Sprite, Bitmap, etc).
		 * @param baseUI A BaseUI instance.
		 * @param node A XML node describing the BaseUI properties and values.
		 */
		public static function setBaseUIProperties(target:DisplayObject, baseUI:BaseUI, node:XML):void {
			try {
				if (target == null) return;
				// check if node contains ElementUI properties
				var el:ElementUI = new ElementUI(baseUI, target);
				var classDescribedElementUI:XML = describeType(el);
				var lP:XMLList = classDescribedElementUI..*.(name() == "accessor" && @access == "readwrite" && @name != "x" && @name != "y" && @name != "width" && @name != "height");
				var at:XMLList = node.attributes();
				var found:Boolean = false;
				var nL:int = at.length(); // loop 1 length
				var n:int; // loop 1
				var eL:int; // loop 2 length
				var e:int; // loop 2
				var aN:String; // node attribute list
				var pE:String; // ElementUI property list
				loop1: for (n=0; n<nL; n++) {
					aN = at[n].name().toString();
					eL = lP.length();
					for (e=0; e<eL; e++) {
						pE = lP[e].@name.toString();
						if (pE == aN) {
							found = true;
							break loop1;
						}
					}
				}
				if ((node.hasOwnProperty("@width") && String(node.@width).indexOf("%") != -1) || (node.hasOwnProperty("@height") && String(node.@width).indexOf("%") != -1)) {
					found = true;
				}
				if (found) {
					// ElementUI properties has been found in the node
					var elUI:ElementUI = (baseUI.getElement(target) == null) ? baseUI.add(target) : baseUI.getElement(target);
					if (elUI != null) {
						var att:XMLList = node.attributes();
						for (var a:int=0; a<att.length(); a++) {
							var attName:String = String(att[a].name());
							if (elUI.hasOwnProperty(attName)) {
								elUI[attName] = String(att[a]);
							}
						}
					}
				}
			} catch (err:Error) {
				if (target != null) {
					trace("Error in SomaUtils.setBaseUIProperties, target: ", target);
					if (node != null) trace("node: ", node.toXMLString());
					trace(err);
				}
			}
		}
		
		/**
		 * Get a modified URL to force the browser to load a file and never use its cache (the trick is using a Date in miliseconds as a param), can be useful for XML or any files.
		 * <listing version="3.0">
		 * var urlToLoad:String = "http://www.server.com/file.xml";
		 * var urlToLoadModified:String = SomaUtils.killCache(urlToLoad);
		 * </listing>
		 * @param url A String (URL).
		 * @return A String (URL).
		 */
		public static function killCache(url:String):String {
		    return url + "?killCache=" + new Date().getTime();
		}
		
		/**
		 * Trace in the output the list of the fonts embedded in the flash movie.
		 * <listing version="3.0">
		 * SomaUtils.showEmbeddedFonts();
		 * </listing>
		 */
		public static function showEmbeddedFonts():void {
			trace("========Embedded Fonts========");
			var fonts:Array = Font.enumerateFonts();
			fonts.sortOn("fontName", Array.CASEINSENSITIVE);
			for (var i:int = 0; i < fonts.length; i++) {
				trace(fonts[i].fontName + ", " + fonts[i].fontStyle);
			}
		}
		
	}
}
