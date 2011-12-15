/**
 * @author Onur Ersel
 * @date 15.12.2011 / 10:52
 */

package com.onurersel.mvc.events
{
	import flash.events.Event;

	public class SliderEvent extends Event
	{
		static public const 	CHANGE_PERCENT		: String = "CHANGE_PERCENT";

		public var percent 				: Number;

		public function SliderEvent(type : String, percent : Number,  bubbles : Boolean = false, cancelable : Boolean = false)
		{
			this.percent = percent;
			super(type, bubbles, cancelable);
		}


		public override function clone() : Event
		{
			return new SliderEvent(type, percent, bubbles, cancelable);
		}


		public override function toString() : String
		{
			return formatToString("SliderEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}