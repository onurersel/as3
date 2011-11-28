/**
 * @author Onur Ersel
 * @date 21.11.2011 / 10:40
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.model.ResizeModel;
	import com.onurersel.mvc.view.IView;
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ViewController extends EventDispatcher
	{
		public var view 						: Sprite;

		private var _viewArray					: Array;
		private var _viewControllerArray		: Array;

		private var _isListenersAdded			: Boolean;
		private var _isShown					: Boolean;


		public function ViewController(view : Sprite)
		{
			this.view = view;

			_viewArray 			= [];
			_viewControllerArray = [];

			_isShown = true;
		}


		/**********      SHOW / HIDE      **********/

		public function show() : Boolean
		{
			if(_isShown)			return false;
			_isShown = true;

			addListeners();

			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var targetView : View = _viewArray[i];
				targetView.show();
			}

			for (var j : int = 0; j < _viewControllerArray.length; j++)
			{
				var viewController : ViewController = _viewControllerArray[j];
				viewController.show();
			}

			return true;
		}

		public function hide() : Boolean
		{
			if(!_isShown)		return false;
			_isShown = false;

			removeListeners();

			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var targetView : View = _viewArray[i];
				targetView.hide();
			}

			for (var j : int = 0; j < _viewControllerArray.length; j++)
			{
				var viewController : ViewController = _viewControllerArray[j];
				viewController.hide();
			}

			return true;
		}


		/**********      ADD LISTENERS      **********/

		public function addListeners() : Boolean
		{
			if(_isListenersAdded)			return false;
			_isListenersAdded = true;

			ResizeModel.getInstance().addEventListener(ResizeModel.RESIZE, resizeHandler);

			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var targetView : View = _viewArray[i];
				targetView.addListeners();
			}

			for (var j : int = 0; j < _viewControllerArray.length; j++)
			{
				var viewController : ViewController = _viewControllerArray[j];
				viewController.addListeners();
			}

			return true;
		}

		public function removeListeners() : Boolean
		{
			if(!_isListenersAdded)			return false;
			_isListenersAdded = false;

			ResizeModel.getInstance().removeEventListener(ResizeModel.RESIZE, resizeHandler);

			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var targetView : View = _viewArray[i];
				targetView.removeListeners();
			}

			for (var j : int = 0; j < _viewControllerArray.length; j++)
			{
				var viewController : ViewController = _viewControllerArray[j];
				viewController.removeListeners();
			}

			return true;
		}
		
		
		/**********      HANDLERS      **********/
		
		private function resizeHandler(event : Event) : void
		{
			resize(ResizeModel.getInstance().width, ResizeModel.getInstance().height);
		}



		/**********      RESIZE      **********/

		protected function resize(width : int, height : int) : void
		{
			
		}



		/**********      RESET      **********/
		public function reset() : void
		{
			
		}




		/**********      ADD VIEW      **********/
		public function addView(view : IView) : void
		{
			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var v : View = _viewArray[i];
				if(v == view)
				{
					trace("ViewController:addView : View was added before");
					return;
				}
			}

			_viewArray.push(view);
		}

		public function removeView(view : IView) : void
		{
			for (var i : int = 0; i < _viewArray.length; i++)
			{
				var targetView : View = _viewArray[i];
				if(targetView == view)
				{
					_viewArray.splice(i,  1);
					return;
				}
			}

			trace("ViewController:removeView : View wasn't added before");
		}



		/**********      ADD CONTROLLER      **********/

		public function addController(controller : ViewController) : void
		{
			for (var i : int = 0; i < _viewControllerArray.length; i++)
			{
				var viewController : ViewController = _viewControllerArray[i];
				if(viewController == controller)
				{
					trace("ViewController:addController : Controller was added before");
					return;
				}
			}

			_viewControllerArray.push(controller);
		}

		public function removeController(controller : ViewController) : void
		{
			for (var i : int = 0; i < _viewControllerArray.length; i++)
			{
				var viewController : ViewController = _viewControllerArray[i];
				if(viewController == controller)
				{
					_viewControllerArray.splice(i,  1);
					return;
				}
			}

			trace("ViewController:removeController : Controller wasn't added before");
		}



		/**********      DESTROY      **********/
		public function destroy() : void
		{
			hide();
			removeListeners();


			var i : int;
			for (i  = 0; i < _viewArray.length; i)
			{
				var view : View = _viewArray[i];
				view.destroy();
				removeView(view);
			}
			_viewArray = null;

			for (i = 0; i < _viewControllerArray.length; i)
			{
				var controller : ViewController = _viewControllerArray[i];
				controller.destroy();
				removeController(controller);
			}
			_viewControllerArray = null;
			
			view = null;
		}




		/**********      GETTER / SETTER      **********/

		public function get isListenersAdded() : Boolean
		{
			return _isListenersAdded;
		}

		public function get isShown() : Boolean
		{
			return _isShown;
		}

		public function get viewArray() : Array
		{
			return _viewArray;
		}

		public function get viewControllerArray() : Array
		{
			return _viewControllerArray;
		}
	}
}
