/**
 * @author Onur Ersel
 * @date 31.10.2011 / 13:53
 */

package com.onurersel.mvc.model
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ResizeModel extends EventDispatcher
	{
		static public const 		RESIZE		: String = "RESIZE";

		static private var instance : ResizeModel;
		public var width 			: int;
		public var height 			: int;
		public var stage			: Stage;

		public function ResizeModel()
		{
			if (instance)		throw new Error("ResizeModel is a singleton");
		}

		static public function getInstance() : ResizeModel
		{
			if (!instance)		instance = new ResizeModel();
			return instance;
		}

		public function prepare(stage : Stage) : void
		{
			this.stage = stage;

			resize(stage.stageWidth, stage.stageHeight);
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		private function resize(width : int, height : int) : void
		{
			this.width = width;
			this.height = height;

			this.dispatchEvent(new Event(RESIZE));
		}

		private function resizeHandler(event : Event) : void
		{
			resize(stage.stageWidth, stage.stageHeight);
		}
	}
}