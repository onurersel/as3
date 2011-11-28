/**
 * @author Onur Ersel
 * @date 28.11.2011 / 10:50
 */
package com.onurersel.mvc.view
{
	public interface IView
	{
		function addListeners() : Boolean;
		function removeListeners() : Boolean;

		function show() : Boolean;
		function hide() : Boolean;

		function removeFromParent() : void;
		function destroy() : void;
	}
}

