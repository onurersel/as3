/**
 * @author Onur Ersel
 * @date 23.11.2011 / 16:58
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.view.View;

	public class ListItemController extends ViewController
	{
		public var id						: int;
		public var data 					: *;
		public var delegate					: *;

		
		public function ListItemController(view : View)
		{
			super(view);
		}

		public function updateData(data : *) : void
		{
			this.data = data;

		}
	}
}
