
package com.sulake.core.window.utils
{
    public interface IRectLimiter 
    {

        function get minWidth():int;
        function get maxWidth():int;
        function get minHeight():int;
        function get maxHeight():int;
        function set minWidth(_arg_1:int):void;
        function set maxWidth(_arg_1:int):void;
        function set minHeight(_arg_1:int):void;
        function set maxHeight(_arg_1:int):void;
        function get isEmpty():Boolean;
        function WindowRectLimits():void;
        function limit():void;

    }
}//package com.sulake.core.window.utils

// IRectLimiter = "_-1O2" (String#5311, DoABC#2)
// isEmpty = "_-01T" (String#3592, DoABC#2)
// WindowRectLimits = "_-YG" (String#8377, DoABC#2)


