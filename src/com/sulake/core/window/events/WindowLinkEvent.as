
package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowLinkEvent extends WindowEvent 
    {

        public static const WE_LINK:String = "WE_LINK";
        private static const POOL:Array = [];

        private var _link:String;

        public function WindowLinkEvent()
        {
            _type = WE_LINK;
        }
        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow):WindowEvent
        {
            var _local_4:WindowLinkEvent = (((POOL.length)>0) ? POOL.pop() : new (WindowLinkEvent)());
            _local_4._link = _arg_1;
            _local_4._window = _arg_2;
            _local_4._related = _arg_3;
            _local_4._recycled = false;
            _local_4._SafeStr_9532 = POOL;
            return (_local_4);
        }

        public function get link():String
        {
            return (this._link);
        }
        override public function clone():WindowEvent
        {
            return (allocate(this._link, window, related));
        }
        override public function toString():String
        {
            return ((((((((("WindowLinkEvent { type: " + _type) + " link: ") + this.link) + " cancelable: ") + set) + " window: ") + _window) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowLinkEvent = "_-1tZ" (String#5912, DoABC#2)
// _link = "_-z5" (String#8863, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// _related = "_-2q8" (String#21086, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)
// WE_LINK = "_-0H5" (String#14721, DoABC#2)


