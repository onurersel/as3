/**
 * @author Onur Ersel
 * @date 23.11.2011 / 18:26
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.model.ResizeModel;
	import com.onurersel.mvc.view.ButtonView;
	import com.onurersel.mvc.view.View;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollbarController extends ViewController
	{
		public var handleFrame					: Rectangle;
		private var _handleView 				: ButtonView;
		private var _target						: ScrollAreaController;
		public var barHeight					: int;

		private var minY 		: int;
		private var downY		: int;

		public var percent		: Number;

		public function ScrollbarController(view : Sprite)
		{
			super(view);
		}

		public function prepare(handleView : ButtonView) : void
		{

			this._handleView = handleView;
			this.minY = handleView.y;
			handleFrame = new Rectangle(handleView.x,  handleView.y,  handleView.width, handleView.height);

			addView(handleView);
			updateViewPosition();

		}

		/**********      ADD VIEWS      **********/

		override public function addView(view : View) : void
		{
			super.addView(view);

			if(view == _handleView)
			{
				_handleView.addEventListener(ButtonView.DOWN, 	downHandler);
				_handleView.addEventListener(ButtonView.UP, 	upHandler);
			}
		}

		override public function removeView(view : View) : void
		{
			super.removeView(view);

			if(view == _handleView)
			{
				_handleView.removeEventListener(ButtonView.DOWN, 	downHandler);
				_handleView.removeEventListener(ButtonView.UP, 	upHandler);
			}
		}


		/**********      HANDLERS      **********/

		private function downHandler(event : Event) : void
		{
			downY = _handleView.mouseY;
			ResizeModel.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}

		private function upHandler(event : Event) : void
		{
			ResizeModel.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}

		private function moveHandler(event : MouseEvent) : void
		{
			_handleView.y = _handleView.parent.mouseY - downY;

			if(_handleView.y < minY  ||  barHeight < handleFrame.height)			_handleView.y = minY;
			else if(_handleView.y + handleFrame.height > barHeight)					_handleView.y = barHeight - handleFrame.height;

			calculatePercent();
		}




		/**********      UPDATE VIEW POSITION      **********/

		private function updateViewPosition() : void
		{
			if(handleView  &&  target)
			{
				minY = _target.visibleArea.y;

				handleView.y = _target.visibleArea.y;
				handleView.x = _target.visibleArea.x + _target.visibleArea.width;

				barHeight = _target.visibleArea.height;
			}
		}


		/**********      PERCENT      **********/

		public function calculatePercent() : void
		{
			percent = (_handleView.y - minY) / (barHeight - handleFrame.height - minY);

			if(target)			target.percent = percent;
		}




		/**********      GETTER      **********/

		public function get handleView() : ButtonView
		{
			return _handleView;
		}

		public function get target() : ScrollAreaController
		{
			return _target;
		}

		public function set target(value : ScrollAreaController) : void
		{
			_target = value;

			barHeight = value.visibleArea.height;
			updateViewPosition();

		}
	}
}
