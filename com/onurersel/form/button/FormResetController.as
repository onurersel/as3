/**
 * @author Onur Ersel
 * @date 22.11.2011 / 17:41
 */
package com.onurersel.form.button
{
	import com.onurersel.form.*;
	import com.onurersel.mvc.view.ButtonView;

	import flash.events.Event;

	public class FormResetController
	{
		private var view : ButtonView;
		private var form : FormController;
		public function FormResetController()
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
			form.reset();
		}

		public function destroy() : void
		{
			view = null;
			form = null;

			view.removeEventListener(ButtonView.CLICK, clickHandler);
		}
	}
}
