/**
 * @author Onur Ersel
 * @date 15.12.2011 / 10:50
 */

package com.onurersel.mvc.events
{
	import flash.events.Event;

	public class ButtonEvent extends Event
	{

		static public const				CLICK		: String = "CLICK";
		static public const				DOWN		: String = "DOWN";
		static public const				UP			: String = "UP";

		public function ButtonEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		public override function clone() : Event
		{
			return new ButtonEvent(type, bubbles, cancelable);
		}


		public override function toString() : String
		{
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}