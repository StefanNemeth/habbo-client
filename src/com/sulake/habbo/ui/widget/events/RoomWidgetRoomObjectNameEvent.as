
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomObjectNameEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWONE_TYPE:String = "RWONE_TYPE";

        private var _userId:int;
        private var _category:int;
        private var _userName:String;
        private var _roomIndex:int;

        public function RoomWidgetRoomObjectNameEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            this._userId = _arg_1;
            this._category = _arg_2;
            this._userName = _arg_3;
            this._roomIndex = _arg_4;
            super(RWONE_TYPE, false, false);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetRoomObjectNameEvent = "_-0gJ" (String#15686, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// RWONE_TYPE = "_-34N" (String#21673, DoABC#2)


