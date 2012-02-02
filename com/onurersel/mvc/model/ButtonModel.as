/**
 * @author Onur Ersel
 * @date 21.11.2011 / 14:56
 */

package com.onurersel.mvc.model
{
	import com.greensock.TweenLite;

	import flash.events.EventDispatcher;

	public class ButtonModel extends EventDispatcher
	{
		static private var instance : ButtonModel;

		public function ButtonModel()
		{
			if (instance)		throw new Error("InteractivityModel is a singleton");
		}

		static public function getInstance() : ButtonModel
		{
			if (!instance)		instance = new ButtonModel();
			return instance;
		}


		/**********      ENABLE / DISABLE BUTTONS      **********/


		private var _isButtonsDisabled			: Boolean;

		public function disableButtons(disableDuration : Number = 1) : void
		{
			if(_isButtonsDisabled)			return;
			_isButtonsDisabled = true;

			if(disableDuration > 0)
			{
				TweenLite.killDelayedCallsTo(enableButtons);
				TweenLite.delayedCall(disableDuration, enableButtons);
			}

		}

		public function enableButtons() : void
		{
			if(!_isButtonsDisabled)			return;
			_isButtonsDisabled = false;

			TweenLite.killDelayedCallsTo(enableButtons);
		}




		/**********      GETTER / SETTER      **********/

		public function get isButtonsDisabled() : Boolean
		{
			return _isButtonsDisabled;
		}
	}
}