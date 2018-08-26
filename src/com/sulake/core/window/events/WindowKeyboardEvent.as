
package com.sulake.core.window.events
{
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;

    public class WindowKeyboardEvent extends WindowEvent 
    {

        public static const WKE_KEY_UP:String = "WKE_KEY_UP";
        public static const WKE_KEY_DOWN:String = "WKE_KEY_DOWN";
        private static const POOL:Array = [];

        private var _event:KeyboardEvent;

        public static function allocate(_arg_1:String, _arg_2:Event, _arg_3:IWindow, _arg_4:IWindow, _arg_5:Boolean=false):WindowKeyboardEvent
        {
            var _local_6:WindowKeyboardEvent = (((POOL.length)>0) ? POOL.pop() : new (WindowKeyboardEvent)());
            _local_6._type = _arg_1;
            _local_6._event = (_arg_2 as KeyboardEvent);
            _local_6._window = _arg_3;
            _local_6._related = _arg_4;
            _local_6._recycled = false;
            _local_6.set = _arg_5;
            _local_6._SafeStr_9532 = POOL;
            return (_local_6);
        }

        public function get charCode():uint
        {
            return (this._event.charCode);
        }
        public function get keyCode():uint
        {
            return (this._event.keyCode);
        }
        public function get keyLocation():uint
        {
            return (this._event.keyLocation);
        }
        public function get altKey():Boolean
        {
            return (this._event.altKey);
        }
        public function get shiftKey():Boolean
        {
            return (this._event.shiftKey);
        }
        override public function clone():WindowEvent
        {
            return (allocate(_type, this._event, window, related, cancelable));
        }
        override public function toString():String
        {
            return ((((((((("WindowKeyboardEvent { type: " + _type) + " cancelable: ") + set) + " window: ") + _window) + " charCode: ") + this.charCode) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// _event = "_-3R" (String#2046, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// _related = "_-2q8" (String#21086, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)


