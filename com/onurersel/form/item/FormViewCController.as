/**
 * @author Onur Ersel
 * @date 23.11.2011 / 11:25
 */
package com.onurersel.form.item
{
	import com.onurersel.mvc.controller.ViewController;

	public class FormViewCController extends FormItemController
	{
		public var controller : ViewController;

		public function FormViewCController()
		{
		}


		override public function destroy() : void
		{
			controller = null;

			super.destroy();
		}
	}
}
