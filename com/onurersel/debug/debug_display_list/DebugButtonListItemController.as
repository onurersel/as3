/**
 * @author Onur Ersel
 * @date 19.12.2011 / 12:07
 */
package com.onurersel.debug.debug_display_list
{
	import com.onurersel.mvc.controller.ListItemController;
	import com.onurersel.mvc.events.ButtonEvent;
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;

	public class DebugButtonListItemController extends ListItemController
	{


		public function DebugButtonListItemController(view : View)
		{
			super(view);
			view.addEventListener(ButtonEvent.CLICK, clickHandler);
		}


		override public function updateData(data : *) : void
		{
			super.updateData(data);

			if(data == "CLOSE")		DebugButtonListItem(view).setText("CLOSE");
			else					DebugButtonListItem(view).setText(DisplayObject(data).name + " : " + getQualifiedClassName(data));
		}


		private function clickHandler(event : ButtonEvent) : void
		{
			DebugDisplayList(delegate).selectItem(data);
		}
	}
}
