
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomPlanePropertyUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const RORPPUM_WALL_THICKNESS:String = "RORPPUM_WALL_THICKNESS";
        public static const RORPVUM_FLOOR_THICKNESS:String = "RORPVUM_FLOOR_THICKNESS";

        private var _type:String = "";
        private var _value:Number = 0;

        public function RoomObjectRoomPlanePropertyUpdateMessage(_arg_1:String, _arg_2:Number)
        {
            super(null, null);
            this._type = _arg_1;
            this._value = _arg_2;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get value():Number
        {
            return (this._value);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomPlanePropertyUpdateMessage = "_-14L" (String#16629, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// RORPVUM_FLOOR_THICKNESS = "_-2pM" (String#7067, DoABC#2)
// RORPPUM_WALL_THICKNESS = "_-GT" (String#8005, DoABC#2)


