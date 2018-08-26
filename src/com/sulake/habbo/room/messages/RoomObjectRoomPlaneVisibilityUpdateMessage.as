
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomPlaneVisibilityUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const RORPVUM_WALL_VISIBILITY:String = "RORPVUM_WALL_VISIBILITY";
        public static const RORPVUM_FLOOR_VISIBILITY:String = "RORPVUM_FLOOR_VISIBILITY";

        private var _type:String = "";
        private var _visible:Boolean = false;

        public function RoomObjectRoomPlaneVisibilityUpdateMessage(_arg_1:String, _arg_2:Boolean)
        {
            super(null, null);
            this._type = _arg_1;
            this._visible = _arg_2;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomPlaneVisibilityUpdateMessage = "_-1Hj" (String#17179, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// RORPVUM_FLOOR_VISIBILITY = "_-0u0" (String#16203, DoABC#2)
// RORPVUM_WALL_VISIBILITY = "_-1sU" (String#18653, DoABC#2)


