/**
 * @author Onur Ersel
 * @date 01.12.2011 / 11:02
 */
package com.onurersel.mvc.view.sprite
{
	import com.onurersel.mvc.model.ResizeModel;

	import flash.events.Event;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class DragView extends ButtonView
	{
		static public const			DRAG		: String = "DRAG";

		private var _isDragging		: Boolean;
		private var grabPoint		: Point;

		public function DragView()
		{
			grabPoint = new Point();
		}

		override protected function downHandler(event : MouseEvent) : void
		{
			super.downHandler(event);

			_isDragging = true;

			grabPoint.x = this.mouseX * this.scaleX;
			grabPoint.y = this.mouseY * this.scaleY;
			ResizeModel.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);

			startDragging();
		}

		override protected function upHandler(event : MouseEvent) : Boolean
		{
			if(!super.upHandler(event))		return false;

			ResizeModel.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler)
			_isDragging = false;

			stopDragging();

			return true;
		}

		private function moveHandler(event : MouseEvent) : void
		{
			if(this.parent)
			{
				this.x = parent.mouseX - grabPoint.x;
				this.y = parent.mouseY - grabPoint.y;
			}

			drag();
		}

		override public function removeListeners() : Boolean
		{
			if(!super.removeListeners())			return false;

			ResizeModel.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler)

			return true;
		}


		public function startDragging() : void
		{

		}


		public function stopDragging() : void
		{

		}


		public function drag() : void
		{
			this.dispatchEvent(new Event(DRAG));
		}


		public function get isDragging() : Boolean
		{
			return _isDragging;
		}
	}
}
