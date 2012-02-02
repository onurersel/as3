/**
 * @author Onur Ersel
 * @date 04.01.2012 / 10:47
 */
package com.onurersel.image_cropper
{
	import com.onurersel.mvc.view.sprite.DragView;
	import com.onurersel.mvc.view.sprite.View;

	import flash.display.Bitmap;


	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;

	import flash.geom.Rectangle;

	public class ImageCropper extends View
	{
		private var draggableView		: DragView;
		private var _zoom				: Number;

		private var dataWidth			: int;
		private var dataHeight			: int;

		private var pivotRatio			: Point;
		public var originalData		: BitmapData;

		public function ImageCropper()
		{
			
		}


		public function prepare(frame : Rectangle) : void
		{
			this.frame = frame;

			draggableView = new DragView();
			this.addChild(draggableView);

			pivotRatio = new Point();

			addListeners();
		}


		override public function addListeners() : Boolean
		{
			if(!super.addListeners())			return false;

			draggableView.addEventListener(DragView.DRAG, dragHandler);

			return true;
		}


		private function dragHandler(event : Event) : void
		{
			changePosition();
		}

		override public function removeListeners() : Boolean
		{
			if(!super.removeListeners())		return false;

			draggableView.addEventListener(DragView.DRAG, dragHandler);

			return true;
		}


		/**********      SET IMAGE      **********/

		public function setImage(imageData : BitmapData) : void
		{
			originalData = imageData;

			dataWidth 		= imageData.width;
			dataHeight 		= imageData.height;

			drawImage(imageData);
			centerImage();

			dispatchEvent(new Event(Event.COMPLETE));

			imageInAnimation(draggableView);
		}


		private function drawImage(imageData : BitmapData) : void
		{
			draggableView.graphics.clear();
			draggableView.graphics.beginBitmapFill(imageData, null, false, true );
			draggableView.graphics.drawRect(0,0,imageData.width, imageData.height);
			draggableView.graphics.endFill();
		}


		public function clearImage() : void
		{
			imageOutAnimation(draggableView);
		}




		/**********      ANIMATION      **********/


		protected function imageInAnimation(image : View) : void
		{

		}

		protected function imageOutAnimation(image : View):void
		{
			draggableView.graphics.clear();
		}


		/**********      REPOSITION      **********/

		private function centerImage() : void
		{
			zoom = 0;

			draggableView.x = (frame.x + (frame.width / 2)) - (draggableView.width/2)
			draggableView.y = (frame.y + (frame.height / 2)) - (draggableView.height/2)

			changePosition();
		}

		private function changePosition() : void
		{
			if(draggableView.x > frame.x)												draggableView.x = frame.x;
			else if (draggableView.x + draggableView.width < frame.x + frame.width)		draggableView.x = frame.x + frame.width - draggableView.width;

			if(draggableView.y > frame.y)												draggableView.y = frame.y;
			else if (draggableView.y + draggableView.height < frame.y + frame.height)	draggableView.y = frame.y + frame.height - draggableView.height;

			pivotRatio.x = (frame.x + (frame.width / 2) - draggableView.x) / draggableView.width;
			pivotRatio.y = (frame.y + (frame.height / 2) - draggableView.y) / draggableView.height;
		}




		/**********      CAPTURE      **********/

		public function capture() : BitmapData
		{
			var bitmapData : BitmapData = new BitmapData(frame.width, frame.height);
			var matrix : Matrix = new Matrix();
			matrix.scale(draggableView.scaleX, draggableView.scaleY);
			matrix.translate(- frame.x + draggableView.x,  - frame.y + draggableView.y);

			bitmapData.draw(draggableView, matrix);

			return bitmapData;
		}


		/**********      RESIZE      **********/

		public function get zoom() : Number
		{
			return _zoom;
		}


		public function set zoom(value : Number) : void
		{
			_zoom = value;

			var wRatio : Number = frame.width / dataWidth;
			var hRatio : Number = frame.height / dataHeight;
			var ratio : Number = Math.max(wRatio, hRatio);

			draggableView.scaleX = ratio * (value * 2 + 1);
			draggableView.scaleY = ratio * (value * 2 + 1);

			draggableView.x = (frame.x + (frame.width/2)) - draggableView.width * pivotRatio.x;
			draggableView.y = (frame.y + (frame.height/2)) - draggableView.height * pivotRatio.y;


			changePosition();
		}
	}
}
