
package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowTouchEvent extends WindowEvent 
    {

        public static const WTE_BEGIN:String = "WTE_BEGIN";
        public static const WTE_END:String = "WTE_END";
        public static const WTE_MOVE:String = "WTE_MOVE";
        public static const WTE_OUT:String = "WTE_OUT";
        public static const WTE_OVER:String = "WTE_OVER";
        public static const WTE_ROLL_OUT:String = "WTE_ROLL_OUT";
        public static const WTE_ROLL_OVER:String = "WTE_ROLL_OVER";
        public static const WTE_TAP:String = "WTE_TAP";
        private static const POOL:Array = [];

        public var localX:Number;
        public var localY:Number;
        public var stageX:Number;
        public var stageY:Number;
        public var altKey:Boolean;
        public var ctrlKey:Boolean;
        public var shiftKey:Boolean;
        public var _SafeStr_9543:Number;
        public var sizeX:Number;
        public var sizeY:Number;

        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Boolean, _arg_12:Boolean, _arg_13:Boolean):WindowTouchEvent
        {
            var _local_14:WindowTouchEvent;
            _local_14 = (((POOL.length)>0) ? POOL.pop() : new (WindowTouchEvent)());
            _local_14._type = _arg_1;
            _local_14._window = _arg_2;
            _local_14._related = _arg_3;
            _local_14._recycled = false;
            _local_14._SafeStr_9532 = POOL;
            _local_14.sizeX = _arg_6;
            _local_14.sizeY = _arg_7;
            _local_14.localX = _arg_4;
            _local_14.localY = _arg_5;
            _local_14.stageX = _arg_8;
            _local_14.stageY = _arg_9;
            _local_14._SafeStr_9543 = _arg_10;
            _local_14.altKey = _arg_11;
            _local_14.ctrlKey = _arg_12;
            _local_14.shiftKey = _arg_13;
            return (_local_14);
        }

        override public function clone():WindowEvent
        {
            return (allocate(_type, window, related, this.localX, this.localY, this.sizeX, this.sizeY, this.stageX, this.stageY, this._SafeStr_9543, this.altKey, this.ctrlKey, this.shiftKey));
        }
        override public function toString():String
        {
            return ((((((((((("WindowTouchEvent { type: " + _type) + " cancelable: ") + set) + " window: ") + _window) + " localX: ") + this.localX) + " localY: ") + this.localY) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowTouchEvent = "_-0lW" (String#4536, DoABC#2)
// sizeX = "_-0UO" (String#15219, DoABC#2)
// sizeY = "_-wz" (String#24569, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WTE_BEGIN = "_-17q" (String#16767, DoABC#2)
// WTE_END = "_-0i9" (String#15755, DoABC#2)
// WTE_TAP = "_-2Ox" (String#19999, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// _related = "_-2q8" (String#21086, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)
// WTE_MOVE = "_-27l" (String#19321, DoABC#2)
// WTE_OUT = "_-1Nl" (String#17428, DoABC#2)
// WTE_OVER = "_-0K3" (String#14845, DoABC#2)
// WTE_ROLL_OUT = "_-0s3" (String#16125, DoABC#2)
// WTE_ROLL_OVER = "_-1Xw" (String#17812, DoABC#2)
// _SafeStr_9543 = "_-3GM" (String#22136, DoABC#2)


