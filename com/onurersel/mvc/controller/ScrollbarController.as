/**
 * @author Onur Ersel
 * @date 23.11.2011 / 18:26
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.events.ButtonEvent;
	import com.onurersel.mvc.model.ResizeModel;
	import com.onurersel.mvc.view.IButtonView;
	import com.onurersel.mvc.view.IView;
	import com.onurersel.mvc.view.sprite.ButtonView;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollbarController extends ViewController
	{
		public var handleFrame					: Rectangle;
		private var _handleView 				: Sprite;
		private var _target						: ScrollAreaController;
		public var barHeight					: int;

		private var minY 		: int;
		private var downY		: int;

		public var percent		: Number;

		public function ScrollbarController(view : Sprite)
		{
			super(view);
		}

		public function prepare(handleView : IButtonView) : void
		{

			this._handleView = handleView as Sprite;
			this.minY = _handleView.y;
			handleFrame = new Rectangle(_handleView.x,  _handleView.y,  _handleView.width, _handleView.height);

			addView(handleView as IView);
			updateViewPosition();

		}

		/**********      ADD VIEWS      **********/

		override public function addView(view : IView) : void
		{
			super.addView(view);

			if(view == _handleView)
			{
				_handleView.addEventListener(ButtonEvent.DOWN, 	downHandler);
				_handleView.addEventListener(ButtonEvent.UP, 	upHandler);
			}
		}

		override public function removeView(view : IView) : void
		{
			super.removeView(view);

			if(view == _handleView)
			{
				_handleView.removeEventListener(ButtonEvent.DOWN, 	downHandler);
				_handleView.removeEventListener(ButtonEvent.UP, 	upHandler);
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

			if(_handleView.y < minY  ||  barHeight < handleFrame.height)					_handleView.y = minY;
			else if(_handleView.y + handleFrame.height > barHeight + minY)					_handleView.y = barHeight - handleFrame.height + minY;

			calculatePercent();
		}


		override public function reset() : void
		{
			super.reset();

			updateViewPosition();
		}


		/**********      UPDATE VIEW POSITION      **********/

		private function updateViewPosition() : void
		{
			if(handleView  &&  target)
			{
				minY = _target.visibleArea.y;

				DisplayObject(handleView).y = _target.visibleArea.y;
				DisplayObject(handleView).x = _target.visibleArea.x + _target.visibleArea.width - _handleView.width/2;

				barHeight = _target.visibleArea.height;
			}
		}


		/**********      PERCENT      **********/

		public function calculatePercent() : void
		{
			percent = (_handleView.y - minY) / (barHeight - handleFrame.height);

			trace(percent);
			if(target)			target.percent = percent;
		}




		/**********      GETTER      **********/

		public function get handleView() : IButtonView
		{
			return _handleView as IButtonView;
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
