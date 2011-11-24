/**
 * @author Onur Ersel
 * @date 22.11.2011 / 18:45
 */
package com.onurersel.form.item
{
	import flash.events.Event;

	public class FormEmailController extends FormTextFieldController
	{
		private var invalidText : String;

		public function FormEmailController()
		{
		}


		override public function validate() : Boolean
		{
			var text : String = textField.text;

			var mailExp: RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			var isValid : Boolean = Boolean(text.match(mailExp));

			if(isValid)
			{
				return true;
			}
			else
			{
				invalidText = text;
				return false;
			}
		}


		override protected function textInputHandler(event : Event) : void
		{
			if(isWarningShown)			hideWarning();
		}
	}
}
