/**
 * @author Onur Ersel
 * @date 21.11.2011 / 16:21
 */

package com.onurersel.debug
{
	import com.onurersel.debug.console.DebugConsole;
	import com.onurersel.debug.history.DebugHistory;
	import com.onurersel.mvc.events.ButtonEvent;
	import com.onurersel.mvc.model.ButtonModel;
	import com.onurersel.mvc.model.ResizeModel;

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	public class Debug extends EventDispatcher
	{
		static private var instance : Debug;

		public function Debug()
		{
			if (instance)			throw new Error("DebugController is a singleton");
			else					init();
		}

		static public function getInstance() : Debug
		{
			if (!instance)		instance = new Debug();
			return instance;
		}


		private var _isDebugModeOn		: Boolean;
		private var stage				: Stage;
		private var snappedView			: DisplayObject;
		private var dragStartPoint		: Point;
		private var viewStartPoint		: Point;
		private var history				: DebugHistory;

		private var console				: DebugConsole;

		private var isPressingCommand	: Boolean;

		private function init() : void
		{
			console = new DebugConsole();
			history = new DebugHistory();
		}

		public function on() : void
		{
			if(_isDebugModeOn)			return;
			_isDebugModeOn = true;

			stage = ResizeModel.getInstance().stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			console.addEventListener(ButtonEvent.CLICK, clickConsoleHandler);
		}

		public function off() : void
		{
			if(!_isDebugModeOn)			return;
			_isDebugModeOn = false;

			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			console.removeEventListener(ButtonEvent.CLICK, clickConsoleHandler);
			stage = null;
		}

		
		/**********      HANDLERS      **********/

		private function clickConsoleHandler(event : ButtonEvent) : void
		{
			console.hide();
			history.clearHistory();
		}

		//SHIFT
		private function keyDownHandler(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.SHIFT)
			{
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
				 ButtonModel.getInstance().disableButtons(-1);
			}

			if(event.keyCode == Keyboard.COMMAND  ||  event.keyCode == Keyboard.CONTROL)
			{
				isPressingCommand = true;
			}

			if(isPressingCommand  &&  event.keyCode == Keyboard.Z)
			{
				history.undo();
			}

			if(isPressingCommand  &&  event.keyCode == Keyboard.Y)
			{
				history.redo();
			}
		}

		private function keyUpHandler(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.SHIFT)
			{
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
				ButtonModel.getInstance().enableButtons();
			}

			if(event.keyCode == Keyboard.COMMAND  ||  event.keyCode == Keyboard.CONTROL)
			{
				isPressingCommand = false;
			}
		}

		//MOUSE DRAG
		private function downHandler(event : MouseEvent) : void
		{
			var array : Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
			if(array.length > 0)
			{
				for (var i : int = array.length-1; i >= 0; i--)
				{
					if(array[i] is DisplayObject)
					{
						snappedView = array[i];
						break;
						
					}

				}
				
				if(snappedView)
				{
					history.addAction(snappedView, snappedView.x,  snappedView.y);

					dragStartPoint = new Point(snappedView.parent.mouseX, snappedView.parent.mouseY);
					viewStartPoint = new Point(snappedView.x,  snappedView.y);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
					stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);

					stage.addChild(console);
					console.update(snappedView);
					console.show();
				}
				else
				{
					return;
				}


			}
		}

		private function upHandler(event : MouseEvent) : void
		{
			history.addAction(snappedView, snappedView.x,  snappedView.y);

			snappedView = null;
			dragStartPoint = null;
			viewStartPoint = null;

			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
		}

		private function moveHandler(event : MouseEvent) : void
		{

			snappedView.x += snappedView.parent.mouseX - dragStartPoint.x;
			snappedView.y += snappedView.parent.mouseY - dragStartPoint.y;

			dragStartPoint.x = snappedView.parent.mouseX;
			dragStartPoint.y = snappedView.parent.mouseY;

			console.update(snappedView);
		}
		
		
		
		/**********      SNAP      **********/
		
		


		/**********      GETTER      **********/

		public function get isDebugModeOn() : Boolean
		{
			return _isDebugModeOn;
		}
	}
}