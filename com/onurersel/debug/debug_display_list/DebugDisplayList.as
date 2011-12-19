/**
 * @author Onur Ersel
 * @date 19.12.2011 / 11:37
 */
package com.onurersel.debug.debug_display_list
{
	import com.onurersel.debug.Debug;
	import com.onurersel.mvc.controller.ListController;
	import com.onurersel.mvc.controller.ListItemController;
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public class DebugDisplayList extends View
	{
		private var list : ListController;
		
		public function DebugDisplayList()
		{
			list = new ListController(this);
			list.prepare(null, DebugButtonListItem, DebugButtonListItemController, new Rectangle(0,0,400,1600), this);
		}


		public function displayArray(array : Array) : void
		{
			array.push("CLOSE");

			list.updateData(array);

			this.graphics.clear();
			this.graphics.beginFill(0x000000, .7);
			this.graphics.drawRect(0,0,404,array.length * 18);
			this.graphics.endFill();

		}


		public function selectItem(displayObject : *) : void
		{
			if(displayObject is DisplayObject)
			{
				Debug.getInstance().setSnappedView(displayObject, this);
			}
			else
			{
				list.reset();
			}
			
			removeFromParent();
		}


		override public function destroy() : void
		{
			list.destroy();
			super.destroy();

		}
	}
}
