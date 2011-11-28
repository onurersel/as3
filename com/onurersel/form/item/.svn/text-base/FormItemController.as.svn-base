/**
 * @author Onur Ersel
 * @date 22.11.2011 / 16:06
 */
package com.onurersel.form.item
{
	import com.onurersel.form.*;

	import flash.display.DisplayObject;

	public class FormItemController
	{
		public 		var view 				: DisplayObject;
		private 	var _isWarningShown		: Boolean;
		protected 	var form				: FormController;

		public function FormItemController()
		{
		}

		public function prepare(view : DisplayObject, form : FormController) : void
		{
			this.view = view;
			this.form = form;
		}

		
		
		/**********      VALIDATE      **********/

		public function validate() : Boolean
		{
			return true;
		}

		public function showWarning() : Boolean
		{
			if(_isWarningShown)			return false;
			_isWarningShown = true;

			showWarningAnimation();

			return true;
		}

		public function hideWarning() : Boolean
		{
			if(!_isWarningShown)			return false;
			_isWarningShown = false;

			hideWarningAnimation();
			
			return true;
		}

		protected function showWarningAnimation() : void
		{

		}

		protected function hideWarningAnimation() : void
		{
			
		}



		/**********      RESET      **********/

		public function reset() : void
		{
			
		}

		public function update() : void
		{
			form.update(this);
		}
		
		
		/**********      DESTROY      **********/
		
		public function destroy() : void
		{
			view = null;
			hideWarning();
		}

		public function get isWarningShown() : Boolean
		{
			return _isWarningShown;
		}
	}
}
