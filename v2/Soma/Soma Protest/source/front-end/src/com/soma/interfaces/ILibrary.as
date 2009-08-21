package com.soma.interfaces {

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
     * A Library instance is meant to be used by a NodeParser instance and must implements ILibrary.
     * The global Library instance is accessible using Soma.getInstance().library.
     * </p>
     * 
     * @see com.soma.assets.Library Library
     * @see com.soma.assets.NodeParser NodeParser
     */
	
	public interface ILibrary {
		
		/**
		 * Register a class with its name to be instantiated by a NodeParser instance from an XML node.
		 * @param name name of the asset (will be used as an XML node name: &lt;myAssetName /&gt;)
		 * @param asset class implementing IAsset that will instantiate the asset using an XML node.
		 */
		function registerAsset(name:String, asset:Class):void;
		
		/**
		 * Get an asset class (IAsset) from its name, usually used by a NodeParser instance.
		 * @param name Name of the class (used when register).
		 * @return a Class.
		 */
		function getAsset(name:String):Class;
		
	}
}
