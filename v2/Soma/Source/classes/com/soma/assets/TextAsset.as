package com.soma.assets {
	import com.soma.interfaces.IAsset;
	import com.soma.utils.SomaUtils;
	import com.soma.view.SomaText;
	import com.soundstep.ui.BaseUI;
	
	import flash.display.DisplayObject;	

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
     * Used by the NodeParser class to instantiate a SomaText instance.<br/><br/>
	 * <b>node name: text</b> creates a SomaText instance.<br/>
	 * &lt;text id="myText" x="50" alpha=".5" verticalCenter="0" /&gt;&lt;![CDATA[This is my text]]&gt;&lt;/text&gt;<br/><br/>
     * </p>
     * 
     * @see com.soma.assets.Library Library
     * @see com.soma.assets.NodeParser NodeParser
     * @see com.soma.assets.AssetFactory AssetFactory
     * @see com.soma.view.SomaText SomaText
     * @see com.soma.interfaces.IAsset IAsset
     */
	
	public class TextAsset implements IAsset {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates an TextAsset instance, it should not be used as it should be instantiated by a NodeParser class. */
		public function TextAsset() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Parse a XML node to create and return a SomaText instance. Class specific properties (such as multiline for a SomaText instance) and BaseUI properties (such as horizontalCenter) will also be parsed and applied to the asset.
		 * @param node node XML describing the asset.
		 * @param baseUI BaseUI instance (if existing) that will handle the asset.
		 */
		public function instantiate(node:XML, baseUI:BaseUI = null):DisplayObject {
			var text:SomaText = new SomaText(node, node.@style);
			text.name = node.@id;
			SomaUtils.setProperties(text, node, ["style"]);
			if (baseUI != null) SomaUtils.setBaseUIProperties(text, baseUI, node);
			return text;
		}
		
	}
}