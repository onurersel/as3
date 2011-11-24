/**
 * @author Onur Ersel
 * @date 21.11.2011 / 10:41
 */
package com.onurersel.mvc
{
	import com.onurersel.mvc.model.ResizeModel;

	import flash.display.Sprite;

	public class MVCApp extends Sprite
	{
		public function MVCApp()
		{
			ResizeModel.getInstance().prepare(stage);
		}
	}
}
