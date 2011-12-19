/**
 * @author Onur Ersel
 * @date 24.11.2011 / 11:49
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.model.ResizeModel;
	import com.onurersel.mvc.view.IButtonView;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollAreaController extends ViewController
	{
		public var scrollController			: ScrollbarController;
		public var listController			: ListController;
		private var _visibleArea			: Rectangle;
		private var _percent				: Number;

		private var mask					: Sprite;

		public function ScrollAreaController(view : Sprite)
		{
			super(view);

			mask = new Sprite();
			view.addChild(mask);

			_percent = 0;
		}



		/**********      PREPARE      **********/

		public function prepare(listItemControllerClass : Class, listItemClass : Class,  scrollHandle : IButtonView, data : Array, visibleArea : Rectangle, listControllerClass : Class = null, delegate : * = null) : void
		{
			this.visibleArea = visibleArea;
			scrollController = new ScrollbarController(view);
			scrollController.prepare(scrollHandle);

			if(listControllerClass == null)			listControllerClass = ListController;
			listController = new listControllerClass(view);
			listController.prepare(data, listItemClass, listItemControllerClass, visibleArea, delegate);

			scrollController.target = this;
			if(listController.container.height < visibleArea.height)			scrollController.hide();
			
			listController.container.mask = mask;

			addListeners();
		}

		public function update(array : Array) : void
		{
			scrollController.reset();
			listController.updateData(array);
		}

		override public function destroy() : void
		{
			view.removeChild(mask);
			mask = null;

			super.destroy();
		}


		override public function reset() : void
		{
			super.reset();
			scrollController.reset();
			listController.reset();
		}




		/**********      LISTENERS      **********/

		override public function addListeners() : Boolean
		{
			if(!super.addListeners())			return false;

			ResizeModel.getInstance().stage.addEventListener(MouseEvent.MOUSE_WHEEL, scrollWheelHandler);

			return true;
		}


		


		override public function removeListeners() : Boolean
		{
			if(!super.removeListeners())		return false;

			ResizeModel.getInstance().stage.removeEventListener(MouseEvent.MOUSE_WHEEL, scrollWheelHandler);

			return true;
		}

		private function scrollWheelHandler(event : MouseEvent) : void
		{
			if(listController.view.mouseX < visibleArea.width + visibleArea.x  &&  listController.view.mouseX > visibleArea.x)
			{
				if(listController.view.mouseY < visibleArea.height + visibleArea.y  &&  listController.view.mouseY > visibleArea.y)
				{
					percent += -event.delta * .01;
				}
			}

		}


		/**********      GETTER      **********/

		public function get visibleArea() : Rectangle
		{
			return _visibleArea;
		}

		public function set visibleArea(value : Rectangle) : void
		{
			_visibleArea = value;

			mask.graphics.clear();
			mask.graphics.beginFill(0x000000);
			mask.graphics.drawRect(value.x,  value.y,  value.width, value.height);
			mask.graphics.endFill();
		}

		public function get percent() : Number
		{
			return _percent;
		}

		public function set percent(value : Number) : void
		{
			if(value < 0)			value = 0;
			else if (value > 1)		value = 1;

			_percent = value;
			trace(_percent);

			if(listController.container.height < mask.height)				return;

			scrollController.updatePosition(percent);
			
			var targetY : int = (listController.container.height - mask.height) * value;
			listController.container.y = listController.visibleArea.y - targetY;
		}
	}
}
