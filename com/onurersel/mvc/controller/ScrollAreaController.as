/**
 * @author Onur Ersel
 * @date 24.11.2011 / 11:49
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.view.IButtonView;

	import flash.display.Sprite;
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
			_percent = value;

			if(listController.container.height < mask.height)				return;

			var targetY : int = (listController.container.height - mask.height) * value;
			listController.container.y = listController.visibleArea.y - targetY;
		}
	}
}
