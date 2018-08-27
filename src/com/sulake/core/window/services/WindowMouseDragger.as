
package com.sulake.core.window.services
{
    import flash.display.DisplayObject;

    public class WindowMouseDragger extends WindowMouseOperator implements IMouseDraggingService 
    {

        public function WindowMouseDragger(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }
        override public function operate(_arg_1:int, _arg_2:int):void
        {
            _mouse.x = _arg_1;
            _mouse.y = _arg_2;
            getMousePositionRelativeTo(_window, _mouse, _SafeStr_9646);
            _window.offset((_SafeStr_9646.x - _offset.x), (_SafeStr_9646.y - _offset.y));
        }

    }
}//package com.sulake.core.window.services

// IMouseDraggingService = "_-6c" (String#7797, DoABC#2)
// WindowMouseOperator = "_-1Tv" (String#5430, DoABC#2)
// WindowMouseDragger = "_-AB" (String#7870, DoABC#2)
// _SafeStr_9646 = "_-SB" (String#23332, DoABC#2)
// getMousePositionRelativeTo = "_-1xh" (String#18875, DoABC#2)
// operate = "_-0n2" (String#4567, DoABC#2)


