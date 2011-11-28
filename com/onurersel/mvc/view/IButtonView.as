/**
 * @author Onur Ersel
 * @date 28.11.2011 / 10:56
 */
package com.onurersel.mvc.view
{
	public interface IButtonView
	{
		function activate() : Boolean;
		function deactivate() : Boolean;
		function upAnimation() : void;
		function overAnimation() : void;
		function downAnimation() : void;
		function clickAnimation() : void;
	}
}
