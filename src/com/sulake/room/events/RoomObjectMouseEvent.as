
package com.sulake.room.events
{
    public class RoomObjectMouseEvent extends RoomObjectEvent 
    {

        public static const ROE_MOUSE_CLICK:String = "ROE_MOUSE_CLICK";
        public static const ROE_MOUSE_ENTER:String = "ROE_MOUSE_ENTER";
        public static const ROE_MOUSE_MOVE:String = "ROE_MOUSE_MOVE";
        public static const ROE_MOUSE_LEAVE:String = "ROE_MOUSE_LEAVE";
        public static const ROE_MOUSE_DOUBLE_CLICK:String = "ROE_MOUSE_DOUBLE_CLICK";
        public static const ROE_MOUSE_DOWN:String = "ROE_MOUSE_DOWN";

        private var _eventId:String = "";
        private var _altKey:Boolean;
        private var _ctrlKey:Boolean;
        private var _shiftKey:Boolean;
        private var _buttonDown:Boolean;

        public function RoomObjectMouseEvent(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false, _arg_10:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4, _arg_9, _arg_10);
            this._eventId = _arg_2;
            this._altKey = _arg_5;
            this._ctrlKey = _arg_6;
            this._shiftKey = _arg_7;
            this._buttonDown = _arg_8;
        }
        public function get eventId():String
        {
            return (this._eventId);
        }
        public function get altKey():Boolean
        {
            return (this._altKey);
        }
        public function get ctrlKey():Boolean
        {
            return (this._ctrlKey);
        }
        public function get shiftKey():Boolean
        {
            return (this._shiftKey);
        }
        public function get buttonDown():Boolean
        {
            return (this._buttonDown);
        }

    }
}//package com.sulake.room.events

// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// ROE_MOUSE_ENTER = "_-9-" (String#22579, DoABC#2)
// ROE_MOUSE_LEAVE = "_-0o9" (String#15981, DoABC#2)
// ROE_MOUSE_MOVE = "_-f9" (String#23852, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// ROE_MOUSE_DOUBLE_CLICK = "_-K5" (String#23009, DoABC#2)
// ROE_MOUSE_DOWN = "_-va" (String#24512, DoABC#2)
// _eventId = "_-19k" (String#1626, DoABC#2)
// _altKey = "_-0ak" (String#4317, DoABC#2)
// _ctrlKey = "_-1iB" (String#5713, DoABC#2)
// _shiftKey = "_-1GO" (String#5175, DoABC#2)
// _buttonDown = "_-2-j" (String#6039, DoABC#2)


