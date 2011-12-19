/**
 * @author Onur Ersel
 * @date 15.12.2011 / 11:10
 */
package com.onurersel.debug.history
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class DebugHistoryVO
	{
		public var item 		: DisplayObject;
		public var x 			: int;
		public var y 			: int;


		public function isIdenticalWidth(vo : DebugHistoryVO) : Boolean
		{
			if(this.item == vo.item, this.x == vo.x,  this.y == vo.y)			return true;
			else																return false;
		}


		public function destroy() : void
		{
			item = null;
		}
	}
}
