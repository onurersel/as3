/**
 * @author Onur Ersel
 * @date 21.11.2011 / 16:56
 */
package com.onurersel.debug.console
{
	import avmplus.getQualifiedClassName;

	import com.onurersel.mvc.model.ButtonModel;
	import com.onurersel.mvc.view.ButtonView;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;

	public class DebugConsole extends ButtonView
	{
		//todo:navigator
		//todo:highlight

		private var textField			: TextField;
		private var throwButton			: DebugThrowButton;
		private var xml					: XML;
		private var objectBeingDebugged	: DisplayObject;

		public function DebugConsole()
		{
			this.graphics.beginFill(0x000000, .7);
			this.graphics.drawRect(0,0,130,62);
			this.graphics.endFill();

			xml = <xml><className></className><x>x:</x><y>y:</y></xml>;

			var style : StyleSheet = new StyleSheet();
			style.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			style.setStyle("className", {color:hexToCss(0xDDDDDD)});
			style.setStyle("x", {color:hexToCss(0x00FF00)});
			style.setStyle("y", {color:hexToCss(0xFFFF00)});

			textField = new TextField();
			textField.condenseWhite = true;
			textField.selectable = false;
			textField.styleSheet = style;
			textField.htmlText = xml;
			textField.width = 130;
			textField.wordWrap = true;
			
			this.addChild(textField);

			throwButton = new DebugThrowButton();
			this.addChild(throwButton);
			throwButton.y = 45;
			throwButton.addEventListener(ButtonView.CLICK, clickDebugThrowHandler);

			this.mouseChildren = true;

			show();
		}

		private function clickDebugThrowHandler(event : Event) : void
		{
			var objectBeingDebugged : DisplayObject = this.objectBeingDebugged;
			throw new Error(objectBeingDebugged);
		}
		
		/**********      UPDATE      **********/
		public function update(view : DisplayObject) : void
		{
			objectBeingDebugged = view;

			xml.className = getQualifiedClassName(view);
			xml.x = "x: " + view.x;
			xml.y = "y: " + view.y;

			textField.htmlText = xml;
		}


		private function hexToCss( color : int ) : String
		{
			return "#" + color.toString(16);
		}



		/**********      SHOW / HIDE      **********/
		override public function hide() : Boolean
		{
			if(!super.hide())			return false;

			objectBeingDebugged = null;

			return true;
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			super.clickHandler(event);

			if(!ButtonModel.getInstance().isButtonsDisabled)		hide();
		}
	}
}