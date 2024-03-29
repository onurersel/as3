/**
 * @author Onur Ersel
 * @date 23.11.2011 / 16:31
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class ListController extends ViewController
	{
		public var container			: Sprite;
		public var itemArray			: Array;

		public var isWrapping			: Boolean;
		public var visibleArea			: Rectangle;
		private var itemViewClass 		: Class;
		private var controllerClass 	: Class;
		private var delegate 			: *;

		public function ListController(view : Sprite)
		{
			super(view);

			container 	= new Sprite();
			view.addChild(container);

			itemArray = [];

			isWrapping = true;
		}

		/**********      PREPARE      **********/

		public function prepare(data : Array, itemViewClass : Class, controllerClass : Class, visibleArea : Rectangle, delegate : *) : void
		{
			this.visibleArea = visibleArea;
			this.itemViewClass = itemViewClass;
			this.controllerClass = controllerClass;
			this.delegate = delegate;

			if(!data)		return;
			
			var itemController 	: ListItemController;
			var itemView 		: View;
			for (var i : int = 0; i < data.length; i++)
			{
				var object : * = data[i];

				itemView = new itemViewClass();
				container.addChild(itemView);
				container.x = visibleArea.x;
				container.y = visibleArea.y;

				itemController = new controllerClass(itemView);
				itemController.updateData(object);
				itemController.delegate = delegate;
				itemController.id = i;

				itemArray.push(itemController);
				
				addView(itemView);
				addController(itemController);
			}

			updatePositions();
		}

		public function updateData(data : Array) : void
		{
			clearContent();

			itemArray = [];

			if(!data)		return;

			var itemController 	: ListItemController;
			var itemView 		: View;
			for (var i : int = 0; i < data.length; i++)
			{
				var object : * = data[i];

				itemView = new itemViewClass();
				container.addChild(itemView);
				container.x = visibleArea.x;
				container.y = visibleArea.y;

				itemController = new controllerClass(itemView);
				itemController.updateData(object);
				itemController.delegate = delegate;
				itemController.id = i;

				itemArray.push(itemController);

				addView(itemView);
				addController(itemController);
			}

			updatePositions();
		}


		override public function reset() : void
		{
			super.reset();
			clearContent();
		}


		private function clearContent() : void
		{
			if(itemArray)
			{
				for (var i : int = 0; i < itemArray.length; i++)
				{
					itemArray[i] = null;
				}
				itemArray = null;
			}


			for (i  = 0; i < viewArray.length; i)
			{
				var view : View = viewArray[i];
				view.removeFromParent();
				view.destroy();
				removeView(view);
			}

			for (i = 0; i < viewControllerArray.length; i)
			{
				var controller : ViewController = viewControllerArray[i];
				controller.destroy();
				removeController(controller);
			}
		}


		public function updatePositions() : void
		{
			//get first list item from controller array to get its position for start listing from there
			var listItemController : ListItemController;
			for (var i : int = 0; i < viewControllerArray.length; i++)
			{
				var viewController : ViewController = viewControllerArray[i];
				if(viewController is ListItemController)
				{
					listItemController = viewController as ListItemController;
					break;
				}
			}
			if(!listItemController)			return;


			//start listing
			var currentX 	: int = - View(listItemController.view).frame.x;
			var currentY	: int = - View(listItemController.view).frame.y;

			for (i = 0; i < viewControllerArray.length; i++)
			{
				if(viewControllerArray[i] is ListItemController)
				{
					listItemController = viewControllerArray[i];

					if(isWrapping)
					{
						if(currentX + View(listItemController.view).frame.width > visibleArea.width)
						{
							currentX = - View(listItemController.view).frame.x;
							currentY += View(listItemController.view).frame.height + View(listItemController.view).margin.x;
						}
					}

					listItemController.view.x = currentX;
					listItemController.view.y = currentY;
	
					currentX += View(listItemController.view).frame.width + View(listItemController.view).margin.y;
				}

			}
		}


		override public function destroy() : void
		{

			view.removeChild(container);
			container = null;

			clearContent();
			
			super.destroy();
		}
	}
}
