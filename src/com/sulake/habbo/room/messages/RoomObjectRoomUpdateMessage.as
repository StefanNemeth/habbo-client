
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const RORUM_ROOM_WALL_UPDATE:String = "RORUM_ROOM_WALL_UPDATE";
        public static const RORUM_ROOM_FLOOR_UPDATE:String = "RORUM_ROOM_FLOOR_UPDATE";
        public static const RORUM_ROOM_LANDSCAPE_UPDATE:String = "RORUM_ROOM_LANDSCAPE_UPDATE";

        private var _type:String = "";
        private var _value:String = "";

        public function RoomObjectRoomUpdateMessage(_arg_1:String, _arg_2:String)
        {
            super(null, null);
            this._type = _arg_1;
            this._value = _arg_2;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get value():String
        {
            return (this._value);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomUpdateMessage = "_-L4" (String#23049, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// RORUM_ROOM_FLOOR_UPDATE = "_-2uz" (String#21276, DoABC#2)
// RORUM_ROOM_WALL_UPDATE = "_-0DM" (String#14584, DoABC#2)
// RORUM_ROOM_LANDSCAPE_UPDATE = "_-G8" (String#22858, DoABC#2)


