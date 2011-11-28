/**
 * @author Onur Ersel
 * @date 24.11.2011 / 15:57
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.view.sprite.ButtonView;
	import com.onurersel.mvc.view.sprite.DropdownButtonView;
	import com.onurersel.mvc.view.sprite.View;

	import flash.events.Event;

	public class DropdownListItemController extends ListItemController
	{
		public function DropdownListItemController(view : View)
		{
			super(view);

			view.addEventListener(ButtonView.CLICK, clickHandler);
		}

		private function clickHandler(event : Event) : void
		{
			DropdownController(delegate).chooseItem(id);
		}



		/**********      UPDATE      **********/

		override public function updateData(data : *) : void
		{
			super.updateData(data);

			DropdownButtonView(view).updateData(data);
		}



		/**********      DESTROY      **********/

		override public function destroy() : void
		{
			super.destroy();

			view.removeEventListener(ButtonView.CLICK, clickHandler);
		}
	}
}
