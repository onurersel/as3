/**
 * @author Onur Ersel
 * @date 19.12.2011 / 13:03
 */
package com.onurersel.mvc.view.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;

	public class FittingBitmap extends Bitmap
	{
		private var frameWidth			: int;
		private var frameHeight			: int;

		private var _isShowingAll		: Boolean;
		public var position				: Point;


		public function FittingBitmap(bitmapData:BitmapData = null,pixelSnapping:String = "auto",smoothing:Boolean = true)
		{
			this.frameHeight = -1;
			this.frameWidth = -1;
			this.position = new Point();

			super(bitmapData,pixelSnapping,smoothing);
		}


		public function resize() : void
		{
			if(!bitmapData  ||  frameWidth == -1  ||  frameHeight == -1)
			{
				this.scaleX = 1;
				this.scaleY = 1;
				return;
			}

			var ratioW : Number = frameWidth / bitmapData.width;
			var ratioH : Number = frameHeight / bitmapData.height;

			var ratio : Number;
			if(isShowingAll)
			{
				ratio = Math.min(ratioH, ratioW);
				this.x = position.x;
				this.y = position.y;
			}
			else
			{
				ratio = Math.max(ratioH, ratioW);
				this.x = position.x - (((bitmapData.width * ratio) - frameWidth) / 2);
				this.y = position.y - (((bitmapData.height * ratio) - frameHeight) / 2);
			}

			this.scaleX = ratio;
			this.scaleY = ratio;
		}


		public function setSize(frameWidth : int, frameHeight : int) : void
		{
			this.frameWidth = frameWidth;
			this.frameHeight = frameHeight;

			resize();
		}

		public function cancelResizing() : void
		{
			frameWidth 	= -1;
			frameHeight = -1;

			resize();
		}

		/**********      FRAME      **********/

		


		override public function get bitmapData() : BitmapData
		{
			return super.bitmapData;
		}


		override public function set bitmapData(value : BitmapData) : void
		{
			super.bitmapData = value;

			this.resize();
		}


		public function get isShowingAll() : Boolean
		{
			return _isShowingAll;
		}


		public function set isShowingAll(value : Boolean) : void
		{
			_isShowingAll = value;

			resize();
		}
	}
}
