/**
 * @author Onur Ersel
 * @date 21.11.2011 / 15:14
 */
package com.onurersel.mvc.view.mc
{
	import flash.events.MouseEvent;

	public class CheckboxViewMc extends ButtonViewMc
	{
		protected var 	_isSelected			: Boolean;

		public function CheckboxViewMc()
		{
		}

		/**********      HANDLERS      **********/

		override protected function clickHandler(event : MouseEvent) : void
		{
			super.clickHandler(event);

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
