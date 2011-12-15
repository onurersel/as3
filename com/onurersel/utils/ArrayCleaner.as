/**
 * @author Onur Ersel
 * @date 15.12.2011 / 11:04
 */
package com.onurersel.utils
{
	public class ArrayCleaner
	{

		static public function cleanArray(array : Array, destroyFunctionNameForArrayItems : String = null):void
		{
			for (var i : int = 0; i < array.length; i++)
			{
				if(destroyFunctionNameForArrayItems)
				{
					var item : * = array[i];
					item["destroyFunctionNameForArrayItems"]();
					item = null;
				}
				array[i] = null;
			}
			array = null;
		}

		static public function freshenArray(array : Array, destroyFunctionNameForArrayItems : String = null):Array
		{
			if(!array)		ArrayCleaner.cleanArray(array, destroyFunctionNameForArrayItems);
			array = [];
			return array;
		}
	}
}
