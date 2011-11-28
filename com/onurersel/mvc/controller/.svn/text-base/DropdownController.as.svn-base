/**
 * @author Onur Ersel
 * @date 24.11.2011 / 14:39
 */
package
com.onurersel.mvc.controller{
	import com.onurersel.mvc.view.ButtonView;
	import com.onurersel.mvc.view.DropdownButtonView;
	import com.onurersel.mvc.view.View;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class DropdownController extends ViewController
	{

		protected var headerButton			: DropdownButtonView;
		protected var scrollArea			: ScrollAreaController;
		protected var isOpen				: Boolean;
		protected var dropdownContainer		: View;

		private var listView				: View;

		public var selectedID				: int;

		public function DropdownController(view : Sprite)
		{
			super(view);
		}



		/**********      PREPARE      **********/

		public function prepare(data : Array, headerButton : DropdownButtonView, listItemClass : Class, scrollHandle : ButtonView, height : int, scrollAreaClass : Class = null,  listView : View = null) : void
		{
			this.headerButton = headerButton;

			addView(headerButton);
			headerButton.addEventListener(ButtonView.CLICK, clickHandler);

			this.listView = listView;
			if(listView)		addView(listView);

			dropdownContainer = new View();
			view.addChild(dropdownContainer);
			addView(dropdownContainer);
			dropdownContainer.x = headerButton.x;
			dropdownContainer.y = headerButton.y + headerButton.height;

			dropdownContainer.addChild(scrollHandle);


			if(scrollAreaClass == null)			scrollAreaClass = ScrollAreaController;
			scrollArea = new scrollAreaClass(dropdownContainer);
			scrollArea.prepare(DropdownListItemController, listItemClass, scrollHandle, data, new Rectangle(0, 0, headerButton.width, height), null, this);


			chooseItem(0);


			if(listView)		listView.hide();
			dropdownContainer.hide();
			scrollArea.hide();
		}




		/**********      OPEN / CLOSE      **********/

		public function open() : Boolean
		{
			if(isOpen)			return false;
			isOpen = true;

			if(listView)		listView.show();
			dropdownContainer.show();
			scrollArea.show();

			return true;
		}

		public function close() : Boolean
		{
			if(!isOpen)			return false;
			isOpen = false;

			if(listView)		listView.hide();
			dropdownContainer.hide();
			scrollArea.hide();

			return true;
		}



		/**********      CHOOSE      **********/

		public function chooseItem(id : int) : void
		{

			scrollArea.listController.itemArray[selectedID].view.activate();
			scrollArea.listController.itemArray[id].view.deactivate();

			selectedID = id;
			headerButton.updateData(scrollArea.listController.itemArray[id].data);



			close();
		}




		/**********      HANDLERS      **********/

		private function clickHandler(event : Event) : void
		{
			if(isOpen)				close();
			else					open();
		}



		/**********      DESTROY      **********/

		override public function destroy() : void
		{
			super.destroy();
		}
	}
}
