/**
 * @author Onur Ersel
 * @date 22.11.2011 / 17:56
 */
package com.onurersel.form.item
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	public class FormTextFieldController extends FormItemController
	{
		private var _textField				: TextField;

		public function FormTextFieldController()
		{
			
		}


		override public function validate() : Boolean
		{
			var text : String = textField.text;

			var whitespace:RegExp = /(\t|\n|\s{2,})/g;
			text = text.replace(whitespace, "");

			if(text.length == 0)		return false;
			else						return true;
		}


		override public function reset() : void
		{
			super.reset();

			_textField.text = "";
		}
		

		/**********      HANDLER      **********/

		protected function textInputHandler(event : Event) : void
		{
			if(isWarningShown)		form.update(this);
		}



		/**********      DESTROY      **********/

		override public function destroy() : void
		{
			super.destroy();

			textField = null;
		}




		/**********      CUSTOM FOCUS      **********/

		public function showFocus() : void
		{

		}

		public function hideFocus() : void
		{
			
		}

		private function addFocusListeners() : void
		{

		}

		private function removeFocusListeners() : void
		{

		}

		private function focusInHandler(event : FocusEvent) : void
		{
			showFocus();
		}

		private function focusOutHandler(event : FocusEvent) : void
		{
			hideFocus();
		}


		/**********      GETTER      **********/

		public function get textField() : TextField
		{
			return _textField;
		}

		public function set textField(value : TextField) : void
		{
			if(_textField is TextField)
			{
				_textField.removeEventListener(Event.CHANGE, textInputHandler);
				_textField.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler);
				_textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			}

			_textField = value;

			if(_textField is TextField)
			{
				_textField.addEventListener(Event.CHANGE, textInputHandler);
				_textField.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
				_textField.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			}
		}
	}
}
