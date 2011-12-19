/**
 * @author Onur Ersel
 * @date 19.12.2011 / 11:24
 */
package com.onurersel.debug.debug_display_list
{
	import com.onurersel.mvc.view.sprite.ButtonView;

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import flash.text.TextField;

	import flash.text.TextFormat;

	public class DebugButtonListItem extends ButtonView
	{
		private var textField		: TextField;
		private var format			: TextFormat;

		public function DebugButtonListItem()
		{
			this.graphics.beginFill(0x000000, .5);
			this.graphics.drawRect(2, 2, 400, 13);
			this.graphics.endFill();

			format = new TextFormat("_sans", 9, 0xDDDDDD, true);
			format.align = "left";
			textField = new TextField();
			textField.defaultTextFormat = format;
			textField.width = 400;
			textField.selectable = false;
			textField.y = 2;
			textField.x = 2;

			this.addChild(textField);

			this.frame = new Rectangle(0,0,400,18);
		}


		public function setText(text : String) : void
		{
			textField.text = text;
		}

		override protected function downHandler(event : MouseEvent) : void
		{
			super.downHandler(event);

			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, .5);
			this.graphics.drawRect(2, 2, 400, 13);
			this.graphics.endFill();

			format.color = 0x999999;
			textField.setTextFormat(format);
		}


		override protected function upHandler(event : MouseEvent) : Boolean
		{
			if(!super.upHandler(event))		return false;

			this.graphics.clear();
			this.graphics.beginFill(0x000000, .5);
			this.graphics.drawRect(2, 2, 400, 13);
			this.graphics.endFill();

			format.color = 0xDDDDDD;
			textField.setTextFormat(format);

			return true;
		}


		override public function destroy() : void
		{
			removeFromParent();
			this.removeChild(textField);
			textField = null;
			format = null;

			super.destroy();

		}
	}
}
