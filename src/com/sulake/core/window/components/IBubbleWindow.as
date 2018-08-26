
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;

    public interface IBubbleWindow extends IWindowContainer 
    {

        function get direction():String;
        function set direction(_arg_1:String):void;
        function get pointerOffset():int;
        function set pointerOffset(_arg_1:int):void;
        function get margins():IMargins;
        function get content():IWindowContainer;

    }
}//package com.sulake.core.window.components

// IMargins = "_-1mu" (String#1757, DoABC#2)
// IBubbleWindow = "_-24" (String#6122, DoABC#2)
// pointerOffset = "_-0-G" (String#3550, DoABC#2)


