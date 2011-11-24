/**
 * @author Onur Ersel
 * @date 21.11.2011 / 15:14
 */
package com.onurersel.mvc.view
{
	import flash.events.Event;

	public class CheckboxView extends ButtonView
	{
		protected var 	_isSelected			: Boolean;

		public function CheckboxView()
		{
			this.addEventListener(CLICK, clickCheckboxHandler);
		}

		/**********      HANDLERS      **********/

		private function clickCheckboxHandler(event : Event) : void
		{
			if(isSelected)			deselected();
			else					selected();
		}

		/**********      SELECTED / DESELECTED      **********/

		public function selected() : Boolean
		{
			if(_isSelected)				return false;
			_isSelected = true;

			selectAnimation();

			return true;
		}

		public function deselected() : Boolean
		{
			if(!_isSelected)				return false;
			_isSelected = false;

			deselectAnimation();

			return true;

		}



		/**********      ANIMATIONS      **********/

		protected function selectAnimation() : void
		{

		}

		protected function deselectAnimation() : void
		{

		}



		/**********      GETTER      **********/

		public function get isSelected() : Boolean
		{
			return _isSelected;
		}
	}
}
