/**
 * @author Onur Ersel
 * @date 24.11.2011 / 17:07
 */
package com.onurersel.mvc.controller
{
	import com.onurersel.mvc.view.sprite.ButtonView;

	import flash.display.Sprite;
	import flash.events.Event;

	public class PagerController extends ViewController
	{
		static public const 		CHANGE		: String = "CHANGE";

		public var currentPage		: int;
		public var pageCount		: int;

		public var leftArrow		: ButtonView;
		public var rightArrow		: ButtonView;

		public function PagerController(view : Sprite)
		{
			super(view);
		}


		public function prepare(leftArrow : ButtonView, rightArrow : ButtonView, pageCount : int) : void
		{
			this.leftArrow = leftArrow;
			this.rightArrow = rightArrow;
			this.pageCount = pageCount;

			addView(leftArrow);
			addView(rightArrow);

			leftArrow.addEventListener(ButtonView.CLICK, leftClickHandler);
			rightArrow.addEventListener(ButtonView.CLICK, rightClickHandler);

			checkPagers();
		}


		private function leftClickHandler(event : Event) : void
		{
			previousPage();
		}

		private function rightClickHandler(event : Event) : void
		{
			nextPage();
		}


		/**********      PAGE      **********/

		public function nextPage() : void
		{
			currentPage++;
			if(currentPage >= pageCount)			currentPage = pageCount - 1;

			checkPagers();
			changePage();
		}

		public function previousPage() : void
		{
			currentPage--;
			if(currentPage < 0)						currentPage = 0;

			checkPagers();
			changePage();
		}

		public function setPage(pageNo : int) : void
		{
			if(pageNo >= 0  &&  pageNo < pageCount)			currentPage = pageNo;

			checkPagers();
			changePage();
		}




		/**********      CHANGE      **********/

		public function changePage() : void
		{
			this.dispatchEvent(new Event(CHANGE));
		}


		/**********      PAGER      **********/

		public function checkPagers() : void
		{
			if(currentPage >= pageCount - 1)			rightArrow.deactivate();
			else										rightArrow.activate();

			if(currentPage <= 0)						leftArrow.deactivate();
			else										leftArrow.activate();
		}


		override public function destroy() : void
		{
			leftArrow.removeEventListener(ButtonView.CLICK, leftClickHandler);
			rightArrow.removeEventListener(ButtonView.CLICK, rightClickHandler);

			super.destroy();
		}
	}
}
