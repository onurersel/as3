/**
 * @author Onur Ersel
 * @date 21.11.2011 / 15:06
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.events.ButtonEvent;
	import com.onurersel.mvc.view.IView;
	import com.onurersel.mvc.view.sprite.RadioButtonView;

	import flash.display.DisplayObject;

	import flash.display.Sprite;
	import flash.events.Event;

	public class RadioButtonController extends ViewController
	{

		private var selectedRadioButton			: RadioButtonView;

		public function RadioButtonController(view : Sprite)
		{
			super(view);
		}



		/**********      ADD VIEW      **********/

		override public function addView(view : IView) : void
		{
			super.addView(view);

			if(view is RadioButtonView)
			{
				DisplayObject(view).addEventListener(ButtonEvent.CLICK, clickHandler);
			}
		}


		override public function removeView(view : IView) : void
		{
			super.removeView(view);

			if(view is RadioButtonView)
			{
				DisplayObject(view).removeEventListener(ButtonEvent.CLICK, clickHandler);
			}
		}

		
		
		/**********      HANDLERS      **********/
		
		private function clickHandler(event : Event) : void
		{
			if(selectedRadioButton)			selectedRadioButton.deselected();
			selectedRadioButton = event.target as RadioButtonView;
			selectedRadioButton.selected();
		}


		
		
		/**********      RESET      **********/
		
		override public function reset() : void
		{
			super.reset();
			
			if(selectedRadioButton)		selectedRadioButton.deselected();
		}

		/**********      DESTROY      **********/


		override public function destroy() : void
		{
			selectedRadioButton = null;
			super.destroy();
		}
	}
}
