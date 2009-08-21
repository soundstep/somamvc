package com.somaprotest.assets {
	import com.soma.interfaces.IAsset;
	import com.soma.utils.SomaUtils;
	import com.soundstep.ui.BaseUI;
	
	import flash.display.DisplayObject;		

	/**
	 * @author Romuald Quantin
	 */
	public class CircleAsset implements IAsset {
		public function instantiate(node:XML, baseUI:BaseUI = null):DisplayObject {
			var circle:CircleParam = new CircleParam(10, 0x00FF00);
			circle.name = node.@id;
			SomaUtils.setProperties(circle, node);
			if (baseUI != null) SomaUtils.setBaseUIProperties(circle, baseUI, node); 
			return circle;		}	}
}
