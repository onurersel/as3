/**
 * @author Onur Ersel
 * @date 22.11.2011 / 17:23
 */
package com.onurersel.form.button
{
	import com.onurersel.form.*;
	import com.onurersel.mvc.view.sprite.ButtonView;
	import com.onurersel.mvc.view.sprite.View;

	import flash.events.Event;

	public class FormSubmitController
	{
		private var form : FormController;
		private var view : View;

		public function FormSubmitController()
		{
		}

		public function prepare(view : ButtonView, form : FormController) : void
		{
			this.view = view;
			this.form = form;

			view.addEventListener(ButtonView.CLICK, clickHandler);
		}

		private function clickHandler(event : Event) : void
		{
			form.validate();
		}

		public function destroy() : void
		{
			view = null;
			form = null;

			view.removeEventListener(ButtonView.CLICK, clickHandler);
		}
	}
}
