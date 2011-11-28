/**
 * @author Onur Ersel
 * @date 23.11.2011 / 11:41
 */
package com.onurersel.form.item
{
	import com.onurersel.mvc.view.sprite.CheckboxView;

	public class FormCheckboxController extends FormItemController
	{
		public function FormCheckboxController()
		{
		}


		override public function reset() : void
		{
			var checkbox : CheckboxView = CheckboxView(view);
			if(checkbox.isSelected)			checkbox.deselected();
			
			super.reset();
		}
	}
}
