/**
 * @author Onur Ersel
 * @date 21.11.2011 / 10:40
 */
package com.onurersel.mvc.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class View extends Sprite
	{
		private var _frame					: Rectangle;
		private var isFrameSettedManually	: Boolean;
		public var margin					: Point;

		private var _isListenersAdded		: Boolean;
		private var _isShown				: Boolean;
		private var _isSnappingPixels		: Boolean;
		
		public function View()
		{
			_isShown = true;
			
			_frame = new Rectangle(0, 0, this.height, this.width);
			margin = new Point();

			show();
			addListeners();
		}


		override public function addChild(child : DisplayObject) : DisplayObject
		{
			var displayObject : DisplayObject = super.addChild(child);

			if(!isFrameSettedManually)
			{
				frame.width = this.width;
				frame.height = this.height;
			}

			return displayObject;
		}


		override public function removeChild(child : DisplayObject) : DisplayObject
		{
			var displayObject : DisplayObject = super.addChild(child);

			if(!isFrameSettedManually)
			{
				frame.width = this.width;
				frame.height = this.height;
			}

			return displayObject;
		}

		/**********      LISTENERS      **********/

		public function addListeners() : Boolean
		{
			if(_isListenersAdded)			return false;
			_isListenersAdded = true;

			return true;
		}

		public function removeListeners() : Boolean
		{
			if(!_isListenersAdded)			return false;
			_isListenersAdded = false;

			return true;
		}


		/**********      SHOW / HIDE      **********/

		public function show() : Boolean
		{
			if(_isShown)			return false;
			_isShown = true;

			this.visible = true;

			return true;
		}

		public function hide() : Boolean
		{
			if(!_isShown)		return false;
			_isShown = false;

			this.visible = false;

			return true;
		}



		/**********      REMOVE      **********/
		public function removeFromParent() : void
		{
			if(this.parent)			parent.removeChild(this);
		}
		
		/**********      DESTROY      **********/
		
		public function destroy() : void
		{
			margin = null;
			removeFromParent();
			hide();
			removeListeners();
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

		override public function set x(value:Number):void
		{
			if(_isSnappingPixels)	super.x = Math.round(value);
			else					super.x = value;
		}

		override public function set y(value:Number):void
		{
			if(_isSnappingPixels)	super.y = Math.round(value);
			else					super.y = value;
		}

		public function get isSnappingPixels() : Boolean
		{
			return _isSnappingPixels;
		}

		public function set isSnappingPixels(value : Boolean) : void
		{
			_isSnappingPixels = value;

			if(_isSnappingPixels)
			{
				this.x = this.x;
				this.y = this.y;
			}
		}

		public function get frame() : Rectangle
		{
			return _frame;
		}

		public function set frame(value : Rectangle) : void
		{
			_frame = value;

			if(_frame == null)			isFrameSettedManually = false;
			else						isFrameSettedManually = true;
		}
	}
}
