package com.somaprotest.assets {
	import flash.display.Sprite;		/**
	 * @author Romuald Quantin
	 */
	public class CircleParam extends Sprite {
		public function CircleParam(radius:Number, color:uint) {
			graphics.beginFill(color);
			graphics.drawCircle(radius, radius, radius);
		}	}
}
