/**
 * @author Onur Ersel
 * @date 04.01.2012 / 12:11
 */
package com.onurersel.image_cropper
{
	import com.onurersel.image_cropper.ImageCropper;
	import com.onurersel.mvc.controller.ViewController;

	import flash.display.Bitmap;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class ImageCropperLoader extends ViewController
	{

		private var loader		: Loader;
		private var context		: LoaderContext;

		public function ImageCropperLoader(view : Sprite)
		{
			context = new LoaderContext();
			context.checkPolicyFile = true;
			super(view);
		}

		public function loadImage(url : String) : void
		{
			clearLoader();

			ImageCropper(view).clearImage();

			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.load(new URLRequest(url), context);
		}


		private function completeHandler(event : Event) : void
		{
			ImageCropper(view).setImage(Bitmap(loader.content).bitmapData);
			clearLoader();
		}


		public function loadBytes(bytes : ByteArray) : void
		{
			clearLoader();

			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(bytes);
		}


		private function clearLoader() : void
		{
			if(loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				loader.unloadAndStop();
				loader = null;
			}
		}



	}
}
