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
     * Soma needs a config file to start and initialize the structure, this config must implement IConfig.
     * You can start with the <a href="http://www.soundstep.com/somaprotest/source/front-end/src/com/somaprotest/Config.as" target="_blank">Soma Protest Config File</a> as an example to build your own.<br/><br/>
     * <b>Method init</b><br/>
     * This method is called by Soma during the initialization process, you can initialize the required variables and your own variables.<br/><br/>
     * <b>Method get siteName</b><br/>
     * This method should return the name of you site, it will be used in the title of the Browser.<br/><br/>
     * <b>Method get landingPageID</b><br/>
     * This method should return the id attribute value of one of the XML page node, this page will be the first page instantiated by the PageManager (unless there the URL point to another page).<br/><br/>
     * <b>Method get loadingClassName</b><br/>
     * This method should return the class name of the loading display that will be used by the global SomaLoader instance (Soma.getInstance().loader).
     * The loading Class must be registered (example in the same config class: registerClass(BasicLoading)) to force its import.
     * An empty String can be returned in case you are not using any.<br/><br/>
     * <b>Method get menuClassName</b><br/>
     * This method should return the class name of the main menu that will be used by the framework (Soma.getInstance().menu).
     * The menu Class must be registered (example in the same config class: registerClass(BasicMenu)) to force its import.
     * An empty String can be returned in case you are not using any.<br/><br/>
     * </p>
     * 
     * @see com.soma.Soma Soma
     * @see com.soma.assets.ClassImport ClassImport
     * @see com.soma.interface.IMenu Imenu
     * @see com.soma.interface.ILoading ILoading
     */

	public interface IConfig {
		
		/** 
		 * Initializes variables (is called by the Soma).
		 */
		function init():void;
		/** 
		 * Returns the site name.
		 * @return The site name.
		 */
		function get siteName():String;
		/**
		 * Returns the id attribute of an XML page node, (landing page or default page instantiated by the PageManager).
		 * @return A String. 
		 */
		function get landingPageID():String;
		/**
		 * Returns the default loading class name.
		 * @return A String. 
		 */
		function get loadingClassName():String;
		/**
		 * Returns the main menu class name.
		 * @return A String.
		 */
		function get menuClassName():String;

	}

}