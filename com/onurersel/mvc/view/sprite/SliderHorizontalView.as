/**
 * @author Onur Ersel
 * @date 10.12.2011 / 18:55
 */
package com.onurersel.mvc.view.sprite
{
	import com.onurersel.mvc.events.SliderEvent;

	import flash.events.Event;

	public class SliderHorizontalView extends DragView
	{
		public var minX : int;
		public var maxX : int;
		private var baseY	: int;
		public var percent	: Number;

		private var _scrollX : Number;
		

		public function prepare(minX : int, maxX : int):void
		{
			this.minX = minX;
			this.maxX = maxX;

			baseY = this.y;
			scrollX = this.x;
		}


		override public function drag() : void
		{
			super.drag();

			scrollX = this.x;
			this.y = baseY;
		}


		public function set scrollX(value : Number) : void
		{
			_scrollX = value;
			if(_scrollX < minX)					_scrollX = minX;
			else if(_scrollX > maxX)			_scrollX = maxX;

			this.x = _scrollX;

			
			percent = (_scrollX-minX) / (maxX-minX);

			this.dispatchEvent( new SliderEvent(SliderEvent.CHANGE_PERCENT, percent));
		}


		public function get scrollX() : Number
		{
			return _scrollX;
		}
	}
}
