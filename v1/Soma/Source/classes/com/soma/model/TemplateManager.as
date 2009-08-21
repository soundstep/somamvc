package com.soma.model {
	
	import com.soma.Soma;
	import flash.display.DisplayObjectContainer;	
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;	
	import com.soma.vo.LoaderItemVO;	
	import com.soma.events.LoaderEvent;	
	import flash.display.DisplayObject;	
	import flash.display.Sprite;	
	import flash.display.Bitmap;	
	import flash.display.MovieClip;	
	import flash.display.PixelSnapping;	
	import com.soma.view.SomaText;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import flash.utils.getDefinitionByName;

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
	
	public class TemplateManager {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const TEXTFIELD:String = "textfield";
		public static const MOVIECLIP:String = "movieclip";
		public static const BITMAP:String = "bitmap";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function TemplateManager() {
			
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function getType(prop:*, val:String):* {
			if (prop is Boolean) return (val == "true") ? true : false;
			else if (prop is Number) return Number(val);
			else if (prop is int) return int(val);
			else return val;
		}
		
		private function getExtension(file:String):String {
			var st:int = file.lastIndexOf(".");
			return file.substring(st, file.length);
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function setBaseUI(target:DisplayObject, baseUI:BaseUI, element:XML):void {
			var elUI:ElementUI = baseUI.add(target);
			if (elUI != null) {
				for each (var att:XML in element.attributes()) {
					if (elUI.hasOwnProperty(String(att.name()))) {
						elUI[String(att.name())] = String(att);
					}
				}
			}
		}
		
		public function parse(baseUI:BaseUI, xml:XMLList, specificLoader:LoaderManager = null):Array {
			var loader:LoaderManager = (specificLoader == null) ? Soma.getInstance().loader : specificLoader;
			var external:Boolean = false;
			var arr:Array = [];
			for each (var element:XML in xml) {
				if (element.@external == "true") {
					try {
						external = true;
						if (!element.hasOwnProperty("@path")) throw new CairngormError(CairngormMessage.TEMPLATE_FILE_NOT_FOUND, element.name());
						if (!element.hasOwnProperty("@file")) throw new CairngormError(CairngormMessage.TEMPLATE_PATH_NOT_FOUND, element.name());
						var extension:String = getExtension(element.@file);
						if (extension == "jpg" || "jpeg" || "gif" || "png") {
							var sprite:Sprite = new Sprite();
							sprite.name = element.@id;
							for each (var attImg:XML in element.attributes()) {
								if (sprite.hasOwnProperty(String(attImg.name()))) {
									sprite[String(attImg.name())] = getType(sprite[String(attImg.name())], String(attImg));
								}
							}
							arr.push(sprite);
							DisplayObjectContainer(baseUI.holder).addChild(sprite);
							var loaderVO:LoaderItemVO = new LoaderItemVO(element.@path + element.@file, sprite, {title:element.@id, smoothing:true});
							new LoaderEvent(LoaderEvent.ADD_ITEM, loader, loaderVO).dispatch();
						}
					}
					catch (e:Error) {
						trace(e);
					}
				}
				else {
					// text
					if (element.name() == TEXTFIELD) {
						var text:SomaText = new SomaText(element, element.@style);
						for each (var attText:XML in element.attributes()) {
							if (text.hasOwnProperty(String(attText.name())) && String(attText.name()) != "style") {
								text[String(attText.name())] = getType(text[String(attText.name())], String(attText));
							}
						}
						arr.push(text);
						setBaseUI(text, baseUI, element);
						DisplayObjectContainer(baseUI.holder).addChild(text);
					}
					// movie clip
					if (element.name() == MOVIECLIP) {
						var ClipClass:Class = getDefinitionByName(element.@linkage) as Class;
						var mc:MovieClip = new ClipClass();
						mc.name = element.@id;
						for each (var attClip:XML in element.attributes()) {
							if (mc.hasOwnProperty(String(attClip.name()))) {
								mc[String(attClip.name())] = getType(mc[String(attClip.name())], String(attClip));
							}
						}
						arr.push(mc);
						setBaseUI(mc, baseUI, element);
						DisplayObjectContainer(baseUI.holder).addChild(mc);
					}
					// image
					if (element.name() == BITMAP) {
						var ImageClass:Class = getDefinitionByName(element.@linkage) as Class;
						var img:Bitmap = new Bitmap(new ImageClass(0, 0), PixelSnapping.AUTO, true);
						img.name = element.@id;
						for each (var attBit:XML in element.attributes()) {
							if (img.hasOwnProperty(String(attBit.name()))) {
								img[String(attBit.name())] = getType(img[String(attBit.name())], String(attBit));
							}
						}
						arr.push(img);
						setBaseUI(img, baseUI, element);
						DisplayObjectContainer(baseUI.holder).addChild(img);
					}
				}
			}
			if (external) new LoaderEvent(LoaderEvent.START_LOADING, loader).dispatch();
			return arr;
		}
		
	}
}