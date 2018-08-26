
package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowMouseEvent extends WindowEvent 
    {

        public static const WINDOW_EVENT_MOUSE_CLICK:String = "WME_CLICK";
        public static const WME_DOUBLE_CLICK:String = "WME_DOUBLE_CLICK";
        public static const WME_DOWN:String = "WME_DOWN";
        public static const WME_MIDDLE_CLICK:String = "WME_MIDDLE_CLICK";
        public static const WME_MIDDLE_DOWN:String = "WME_MIDDLE_DOWN";
        public static const WME_MIDDLE_UP:String = "WME_MIDDLE_UP";
        public static const WME_MOVE:String = "WME_MOVE";
        public static const WME_OUT:String = "WME_OUT";
        public static const WINDOW_EVENT_MOUSE_OVER:String = "WME_OVER";
        public static const WME_UP:String = "WME_UP";
        public static const WME_UP_OUTSIDE:String = "WME_UP_OUTSIDE";
        public static const WME_WHEEL:String = "WME_WHEEL";
        public static const WME_RIGHT_CLICK:String = "WME_RIGHT_CLICK";
        public static const WME_RIGHT_DOWN:String = "WME_RIGHT_DOWN";
        public static const WME_RIGHT_UP:String = "WME_RIGHT_UP";
        public static const WME_ROLL_OUT:String = "WME_ROLL_OUT";
        public static const WME_ROLL_OVER:String = "WME_ROLL_OVER";
        public static const WME_HOVERING:String = "WME_HOVERING";
        private static const POOL:Array = [];

        public var delta:int;
        public var localX:Number;
        public var localY:Number;
        public var stageX:Number;
        public var stageY:Number;
        public var altKey:Boolean;
        public var ctrlKey:Boolean;
        public var shiftKey:Boolean;
        public var buttonDown:Boolean;

        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Boolean, _arg_9:Boolean, _arg_10:Boolean, _arg_11:Boolean, _arg_12:int):WindowMouseEvent
        {
            var _local_13:WindowMouseEvent = (((POOL.length)>0) ? POOL.pop() : new (WindowMouseEvent)());
            _local_13._type = _arg_1;
            _local_13._window = _arg_2;
            _local_13._related = _arg_3;
            _local_13._recycled = false;
            _local_13._SafeStr_9532 = POOL;
            _local_13.localX = _arg_4;
            _local_13.localY = _arg_5;
            _local_13.stageX = _arg_6;
            _local_13.stageY = _arg_7;
            _local_13.altKey = _arg_8;
            _local_13.ctrlKey = _arg_9;
            _local_13.shiftKey = _arg_10;
            _local_13.buttonDown = _arg_11;
            _local_13.delta = _arg_12;
            return (_local_13);
        }

        override public function clone():WindowEvent
        {
            return (allocate(_type, window, related, this.localX, this.localY, this.stageX, this.stageY, this.altKey, this.ctrlKey, this.shiftKey, this.buttonDown, this.delta));
        }
        override public function toString():String
        {
            return ((((((((((("WindowMouseEvent { type: " + _type) + " cancelable: ") + set) + " window: ") + _window) + " localX: ") + this.localX) + " localY: ") + this.localY) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// _related = "_-2q8" (String#21086, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)
// WME_MIDDLE_CLICK = "_-0iQ" (String#15769, DoABC#2)
// WME_MIDDLE_DOWN = "_-3Hl" (String#22192, DoABC#2)
// WME_MIDDLE_UP = "_-2c2" (String#20525, DoABC#2)
// WME_RIGHT_CLICK = "_-0xE" (String#16322, DoABC#2)
// WME_RIGHT_DOWN = "_-1p" (String#18501, DoABC#2)
// WME_RIGHT_UP = "_-yO" (String#24631, DoABC#2)
// WME_ROLL_OUT = "_-0ZG" (String#15413, DoABC#2)
// WME_ROLL_OVER = "_-2Fi" (String#19631, DoABC#2)
// WME_HOVERING = "_-1P3" (String#17470, DoABC#2)


