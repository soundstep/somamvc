/*

Copyright (c) 2007. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/
package com.soma.errors
{
	/**
	 * Stores Cairngorm message codes.
	 * 
	 * <p>All messages/error codes must match the regular expression:
	 *
	 * C\d{4}[EWI]
	 *
	 * 1. The application prefix e.g. 'C'.
	 * 
	 * 2. A four-digit error code that must be unique.
	 * 
	 * 3. A single character severity indicator
	 *    (E: error, W: warning, I: informational).</p>
	 */
	public class CairngormMessage {
		// command
		public static const COMMAND_ALREADY_REGISTERED:String = "C0001E: This command is already registered in SomaController";
		public static const COMMAND_NOT_FOUND:String = "C0002E: Command not found in SomaController";
		public static const COMMAND_NOT_REGISTERED:String = "C0003E: Command not registered in SomaController";
		// background
		public static const BACKGROUND_NOT_FOUND:String = "C0010E: Background not found in BackgroundManager";
		// page
		public static const PAGE_TYPE_NOT_FOUND:String = "C0020E: Type not found in PageManager";		public static const PAGE_DEPTH_NOT_FOUND:String = "C0021E: Depth not found in PageManager";
		public static const PAGE_CLASS_NOT_FOUND:String = "C0022E: Error in PageManager.displayPage, the class of the page is not found. If the class exists, force the import using Soma.getInstance().registerClass(MyPageClass). You are trying to create an instance of the class: ";
		public static const PAGE_ID_NOT_FOUND:String = "C0023E: Error in Page.init, the id of the page is not found. If your page is an external page, you must explicitely set the id in the init function, before the super.init(), example: override protected function init():void { id = \"myExternalPageNodeID\"; super.init(); }";
		// layout
		public static const LAYOUT_UNKNOWN:String = "C0040E: The layout property of the XML definition must be 'liquid' or 'fixed'";
		public static const LAYOUT_WIDTH_MISSING:String = "C0041E: width property for the fixed layout is missing in the XML definition";
		public static const LAYOUT_HEIGHT_MISSING:String = "C0042E: height property for the fixed layout is missing in the XML definition";
		// stylesheet
		public static const STYLESHEET_GLOBAL_NOT_FOUND:String = "C0050E: global stylesheet not found, you must register a global stylesheet before starting Soma: Soma.getInstance().registerGloBalStyleSheet(\"css/flash_global.css\");";
		public static const STYLESHEET_NOT_FOUND:String = "C0051E: stylesheet not found in StyleManager, you must load the stylesheet: Soma.getInstance().styles.loadStyleSheet(\"stylesheetID\", \"css/stylesheet.css\");";
		public static const STYLESHEET_ALREADY_REGISTERED:String = "C0052E: stylesheet already registered in StyleManager";		public static const STYLESHEET_LOADING_ERROR:String = "C0053E: Error in StyleManager, the stylesheet couldn't be loaded";
		// soma
		public static const SOMA_INSTANCE_UPDATE:String = "C0060E: Error in Soma, incorrect Soma instance update";
		public static const SOMA_XML_NOT_VALID:String = "C0061E: Error in Soma, The XML Site Definition is not valid";
		// utils
		public static const UTILS_SINGLETON_INSTANTIATION_ERROR:String = "C0070E: Error Singleton, a Singleton can't be instantiated, you must use the getInstance method";
		public static const UTILS_INSTANCE_NOT_DISPLAYOBJECT:String = "C0071E: Error, this class must extend DisplayObject";
	}
}