/**
 * @author Onur Ersel
 * @date 22.11.2011 / 15:40
 */
package com.onurersel.form
{
	import com.onurersel.form.button.FormResetController;
	import com.onurersel.form.button.FormSubmitController;
	import com.onurersel.form.item.FormItemController;
	import com.onurersel.form.item.FormTextFieldController;
	import com.onurersel.form.item.FormViewCController;
	import com.onurersel.mvc.controller.ViewController;
	import com.onurersel.mvc.view.sprite.ButtonView;
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;

	public class FormController extends EventDispatcher
	{

		static public const			VALID		 : String = "VALID";

		private var controllerArray		: Array;
		private var submitArray			: Array;
		private var resetArray			: Array;

		private var currentTabIndex		: int;

		public function FormController()
		{
			
		}

		public function prepare() : void
		{
			controllerArray = [];
			submitArray	 	= [];
			resetArray	 	= [];

			currentTabIndex = 0;
		}

		/**********      ADD      **********/

		public function addFormItem(view : InteractiveObject, controllerClass : Class) : void
		{
			var controller : FormItemController = new controllerClass();
			controller.prepare(view, this);
			controllerArray.push(controller);

			view.tabEnabled = true;
			view.tabIndex = currentTabIndex;
			currentTabIndex++;
		}

		public function addTextItem(view : DisplayObject, controllerClass : Class, textField : TextField) : void
		{
			var controller : FormTextFieldController = new controllerClass();
			controller.prepare(view, this);
			controller.textField = textField;
			controllerArray.push(controller);

			textField.tabEnabled = true;
			textField.tabIndex = currentTabIndex;
			currentTabIndex++;
		}

		public function addControllerItem(view : DisplayObject, controllerClass : Class, viewController : ViewController) : void
		{
			var controller : FormViewCController = new controllerClass();
			controller.prepare(view, this);
			controller.controller = viewController;
			controllerArray.push(controller);

			for (var i : int = 0; i < viewController.viewArray.length; i++)
			{
				var v : View = viewController.viewArray[i];
				if(v is ButtonView)
				{
					v.tabEnabled = true;
					v.tabIndex = currentTabIndex;
					currentTabIndex++;
				}
			}
		}

		public function addSubmitButton(view : ButtonView, controllerClass : Class) : void
		{
			var controller : FormSubmitController = new controllerClass();
			controller.prepare(view, this);
			submitArray.push(controller);

			view.tabEnabled = true;
			view.tabIndex = currentTabIndex;
			currentTabIndex++;
		}

		public function addResetButton(view : ButtonView, controllerClass : Class) : void
		{
			var controller : FormResetController = new controllerClass();
			controller.prepare(view, this);
			resetArray.push(controller);

			view.tabEnabled = true;
			view.tabIndex = currentTabIndex;
			currentTabIndex++;
		}
		
		/**********      VALIDATE      **********/
		
		public function validate() : void
		{
			var result : Boolean = true;

			for (var i : int = 0; i < controllerArray.length; i++)
			{
				var formItemController : FormItemController = controllerArray[i];
				var isValid : Boolean = formItemController.validate();
				if(!isValid)
				{
					formItemController.showWarning();
					result = false;
				}
			}

			if(result)			this.dispatchEvent(new Event(VALID));
		}


		/**********      RESET      **********/
		public function reset() : void
		{
			for (var i : int = 0; i < controllerArray.length; i++)
			{
				var formItemController : FormItemController = controllerArray[i];
				formItemController.reset();
				formItemController.hideWarning();
			}
		}

		public function update(formItemController : FormItemController) : void
		{
			if(formItemController.validate())			formItemController.hideWarning();
			else										formItemController.showWarning();
		}


		/**********      DESTROY      **********/

		public function destroy() : void
		{
			var i : int;
			for (i = 0; i < controllerArray.length; i++)
			{
				var formItemController : FormItemController = controllerArray[i];
				formItemController.destroy();
				controllerArray[i] = null;
			}
			controllerArray = null;

			for (i = 0; i < submitArray.length; i++)
			{
				var formSubmitController : FormSubmitController = submitArray[i];
				formSubmitController.destroy();
				submitArray[i] = null;
			}
			submitArray = null;

			for (i = 0; i < resetArray.length; i++)
			{
				var formResetController : FormResetController = submitArray[i];
				formResetController.destroy();
				resetArray[i] = null;
			}
			resetArray = null;
		}
	}
}
