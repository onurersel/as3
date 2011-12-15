/**
 * @author Onur Ersel
 * @date 15.12.2011 / 11:08
 */
package com.onurersel.debug.history
{
	import com.onurersel.utils.ArrayCleaner;

	import flash.display.DisplayObject;

	public class DebugHistory
	{
		private var historyArray		: Array;
		private var currentHistoryStep	: int;

		/**
		 * her action ı add le
		 * undo da hep bi onceki action ı ver
		 * current history, array ın son itemı diilse ve add action çağırıldıysa arrayın currentten sonrasını temizle
		 * max 20 action tut
		 */

		public function DebugHistory()
		{
			historyArray = [];
		}


		public function addAction(item : DisplayObject, x : int, y: int) : void
		{
			if(currentHistoryStep+1 != historyArray.length)
			{
				var cuttedArray : Array = historyArray.splice(currentHistoryStep, historyArray.length - currentHistoryStep);
				ArrayCleaner.cleanArray(cuttedArray);
			}

			var vo : DebugHistoryVO = new DebugHistoryVO();
			vo.item = item;
			vo.x = x;
			vo.y = y;

			if(!historyArray[currentHistoryStep]  ||  !vo.isIdenticalWidth(historyArray[currentHistoryStep]))
			{
				trace("NOT IDENTICAL");
				historyArray.push(vo);
				currentHistoryStep = historyArray.length - 1;
			}
		}


		public function undo() : void
		{
			if(currentHistoryStep == 0)				return;

			currentHistoryStep--;
			var vo : DebugHistoryVO = historyArray[currentHistoryStep];

			vo.item.x = vo.x;
			vo.item.y = vo.y;
		}


		public function redo() : void
		{
			if(currentHistoryStep + 1 >= historyArray.length)		return;
			trace(currentHistoryStep);

			currentHistoryStep++;
			var vo : DebugHistoryVO = historyArray[currentHistoryStep];

			vo.item.x = vo.x;
			vo.item.y = vo.y;
		}


		public function clearHistory() : void
		{
			historyArray = ArrayCleaner.freshenArray(historyArray);
		}
	}
}
