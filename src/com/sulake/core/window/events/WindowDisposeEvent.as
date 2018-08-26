
package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowDisposeEvent extends WindowEvent 
    {

        public static const WINDOW_DISPOSE_EVENT:String = "WINDOW_DISPOSE_EVENT";
        private static const POOL:Array = [];

        public function WindowDisposeEvent()
        {
            _type = WINDOW_DISPOSE_EVENT;
        }
        public static function allocate(_arg_1:IWindow):WindowDisposeEvent
        {
            var _local_2:WindowDisposeEvent = (((POOL.length)>0) ? POOL.pop() : new (WindowDisposeEvent)());
            _local_2._window = _arg_1;
            _local_2._recycled = false;
            _local_2._SafeStr_9532 = POOL;
            return (_local_2);
        }

        override public function clone():WindowEvent
        {
            return (allocate(window));
        }
        override public function toString():String
        {
            return ((((("WindowDisposeEvent { type: " + _type) + " window: ") + _window) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowDisposeEvent = "_-1nb" (String#5812, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)
// WINDOW_DISPOSE_EVENT = "_-2qj" (String#21111, DoABC#2)


