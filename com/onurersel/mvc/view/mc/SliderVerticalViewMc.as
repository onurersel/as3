/**
 * @author Onur Ersel
 * @date 10.12.2011 / 18:55
 */
package com.onurersel.mvc.view.mc
{
	import com.onurersel.mvc.events.SliderEvent;

	import flash.events.Event;

	public class SliderVerticalViewMc extends DragViewMc
	{
		public var minY : int;
		public var maxY : int;
		private var baseX	: int;
		public var percent	: Number;

		private var _scrollY : Number;
		

		public function prepare(minY : int, maxY : int):void
		{
			this.minY = minY;
			this.maxY = maxY;

			baseX = this.x;
			scrollY = this.y;
		}


		override public function drag() : void
		{
			super.drag();

			scrollY = this.y;
			this.x = baseX;
		}


		public function set scrollY(value : Number) : void
		{
			_scrollY = value;
			if(_scrollY < minY)					_scrollY = minY;
			else if(_scrollY > maxY)			_scrollY = maxY;

			this.y = _scrollY;

			
			percent = (_scrollY-minY) / (maxY-minY);

			this.dispatchEvent( new Event(SliderEvent.CHANGE_PERCENT, percent));
		}


		public function get scrollY() : Number
		{
			return _scrollY;
		}
	}
}

