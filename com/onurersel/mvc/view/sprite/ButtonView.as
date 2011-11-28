/**
 * @author Onur Ersel
 * @date 21.11.2011 / 11:44
 */
package com.onurersel.mvc.view.sprite
{
	import com.onurersel.mvc.view.*;
	import com.onurersel.mvc.model.ButtonModel;
	import com.onurersel.mvc.model.ResizeModel;

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ButtonView extends View implements IButtonView
	{
		static public const				CLICK		: String = "CLICK";
		static public const				DOWN		: String = "DOWN";
		static public const				UP			: String = "UP";
		static public const				MOVE		: String = "MOVE";


		private var _isActivated		: Boolean;
		private var isPressed			: Boolean;

		public function ButtonView()
		{
			this.mouseChildren = false;
			this.tabEnabled = false;

			activate();
		}

		/**********      ACTIVATE      **********/

		public function activate() : Boolean
		{
			if(_isActivated)				return false;
			_isActivated = true;

			this.buttonMode = true;
			this.mouseEnabled = true;

			addListeners();

			return true;
		}

		public function deactivate() : Boolean
		{
			if(!_isActivated)				return false;
			_isActivated = false;

			this.buttonMode = false;
			this.mouseEnabled = false;

			removeListeners();

			return true;
		}



		/**********      LISTENERS      **********/


		override public function addListeners() : Boolean
		{
			if(!super.addListeners())			return false;

			this.addEventListener(MouseEvent.CLICK, 									clickHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, 								overHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, 								outHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, 								downHandler);
			ResizeModel.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP, 		upHandler);


			return true;
		}

		override public function removeListeners() : Boolean
		{
			if(!super.addListeners())			return false;

			this.removeEventListener(MouseEvent.CLICK, 									clickHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER, 							overHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, 								outHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, 							downHandler);
			ResizeModel.getInstance().stage.removeEventListener(MouseEvent.MOUSE_UP, 	upHandler);


			return true;
		}



		/**********      HANDLERS      **********/

		protected function clickHandler(event : MouseEvent) : void
		{
			clickAnimation();

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new Event(CLICK));
		}

		protected function overHandler(event : MouseEvent) : void
		{
			overAnimation();
		}

		protected function outHandler(event : MouseEvent) : void
		{
			upAnimation();
		}

		protected function downHandler(event : MouseEvent) : void
		{
			isPressed = true;

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new Event(DOWN));
			downAnimation();
		}

		protected function upHandler(event : MouseEvent) : void
		{
			if(!isPressed)				return;
			isPressed = false;

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new Event(UP));
			upAnimation();
		}

		
		
		/**********      ANIMATIONS      **********/

		public function upAnimation() : void
		{
			
		}

		public function overAnimation() : void
		{
			
		}

		public function downAnimation() : void
		{
			
		}

		public function clickAnimation() : void
		{
			
		}
		
		/**********      GETTER / SETTER      *********/

		public function get isActivated() : Boolean
		{
			return _isActivated;
		}
	}
}
