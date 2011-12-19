/**
 * @author Onur Ersel
 * @date 19.12.2011 / 12:40
 */
package com.onurersel.debug.console
{
	import com.onurersel.mvc.view.sprite.ButtonView;

	import flash.events.MouseEvent;

	import flash.text.TextField;

	import flash.text.TextFormat;

	public class DebugReleaseSnapped extends ButtonView
	{
		private var textField		: TextField;
		private var format			: TextFormat;

		public function DebugReleaseSnapped()
		{
			this.graphics.beginFill(0x000000, .5);
			this.graphics.drawRect(2, 2, 126, 13);
			this.graphics.endFill();

			format = new TextFormat("_sans", 9, 0xDDDDDD, true);
			format.align = "center";
			textField = new TextField();
			textField.text = "RELEASE";
			textField.width = 126;
			textField.selectable = false;
			textField.setTextFormat(format);
			textField.y = 2;

			this.addChild(textField);
		}


		override protected function downHandler(event : MouseEvent) : void
		{
			super.downHandler(event);

			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, .5);
			this.graphics.drawRect(2, 2, 126, 13);
			this.graphics.endFill();

			format.color = 0x999999;
			textField.setTextFormat(format);
		}


		override protected function upHandler(event : MouseEvent) : Boolean
		{
			if(!super.upHandler(event))			return false;

			this.graphics.clear();
			this.graphics.beginFill(0x000000, .5);
			this.graphics.drawRect(2, 2, 126, 13);
			this.graphics.endFill();

			format.color = 0xDDDDDD;
			textField.setTextFormat(format);

			return true;
		}
	}
}
