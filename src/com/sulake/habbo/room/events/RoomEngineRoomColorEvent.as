
package com.sulake.habbo.room.events
{
    public class RoomEngineRoomColorEvent extends RoomEngineEvent 
    {

        public static const REE_ROOM_COLOR:String = "REE_ROOM_COLOR";

        private var _color:uint;
        private var _brightness:uint;
        private var _bgOnly:Boolean;

        public function RoomEngineRoomColorEvent(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(REE_ROOM_COLOR, _arg_1, _arg_2, _arg_6, _arg_7);
            this._color = _arg_3;
            this._brightness = _arg_4;
            this._bgOnly = _arg_5;
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get brightness():uint
        {
            return (this._brightness);
        }
        public function get bgOnly():Boolean
        {
            return (this._bgOnly);
        }

    }
}//package com.sulake.habbo.room.events

// RoomEngineRoomColorEvent = "_-2AM" (String#19420, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// _bgOnly = "_-09Q" (String#1411, DoABC#2)
// bgOnly = "_-320" (String#21580, DoABC#2)
// REE_ROOM_COLOR = "_-00T" (String#14072, DoABC#2)
// _brightness = "_-1Dp" (String#17017, DoABC#2)


