/**
 * @author Onur Ersel
 * @date 21.11.2011 / 11:44
 */
package com.onurersel.mvc.view.mc
{
	import com.onurersel.mvc.events.ButtonEvent;
	import com.onurersel.mvc.model.ButtonModel;
	import com.onurersel.mvc.model.ResizeModel;
	import com.onurersel.mvc.view.IButtonView;
	import com.onurersel.mvc.view.sprite.ButtonView;

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ButtonViewMc extends ViewMc implements IButtonView
	{
		private var _isActivated		: Boolean;
		private var isPressed			: Boolean;
		private var _isOver				: Boolean;

		public function ButtonViewMc()
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

			if(!ResizeModel.getInstance().stage)		ResizeModel.getInstance().stage = stage;
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

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
		}

		protected function overHandler(event : MouseEvent) : void
		{
			_isOver = true;
			overAnimation();
		}

		protected function outHandler(event : MouseEvent) : void
		{
			_isOver = false;
			outAnimation();
		}

		protected function downHandler(event : MouseEvent) : void
		{
			isPressed = true;

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new ButtonEvent(ButtonEvent.DOWN));
			downAnimation();
		}

		protected function upHandler(event : MouseEvent) : void
		{
			if(!isPressed)				return;
			isPressed = false;

			if(!ButtonModel.getInstance().isButtonsDisabled)		this.dispatchEvent(new ButtonEvent(ButtonEvent.UP));
			upAnimation();
		}

		
		
		/**********      ANIMATIONS      **********/

		public function upAnimation() : void
		{
			
		}

		public function overAnimation() : void
		{
			
		}

		public function outAnimation() : void
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


		public function get isOver() : Boolean
		{
			return _isOver;
		}
	}
}
