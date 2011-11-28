/**
 * @author Onur Ersel
 * @date 21.11.2011 / 15:02
 */
package com.onurersel.mvc.view.sprite
{
	public class RadioButtonView extends ButtonView
	{
		protected var 	_isSelected			: Boolean;

		public function RadioButtonView()
		{

		}
		

		/**********      SELECTED / DESELECTED      **********/

		public function selected() : Boolean
		{
			if(_isSelected)				return false;
			_isSelected = true;

			deactivate();
			selectAnimation();

			return true;
		}

		public function deselected() : Boolean
		{
			if(!_isSelected)				return false;
			_isSelected = false;

			activate();
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
