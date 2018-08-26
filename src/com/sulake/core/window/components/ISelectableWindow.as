
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;

    public interface ISelectableWindow extends IWindow 
    {

        function get selector():ISelectorWindow;
        function get isSelected():Boolean;
        function set isSelected(_arg_1:Boolean):void;
        function select():Boolean;
        function ISelectableWindow():Boolean;

    }
}//package com.sulake.core.window.components

// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// ISelectableWindow = "_-2aK" (String#6764, DoABC#2)


