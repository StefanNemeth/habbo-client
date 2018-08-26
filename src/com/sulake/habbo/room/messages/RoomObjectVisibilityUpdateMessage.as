
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const ROVUM_ENABLED:String = "ROVUM_ENABLED";
        public static const ROVUM_DISABLED:String = "ROVUM_DISABLED";

        private var _type:String;

        public function RoomObjectVisibilityUpdateMessage(_arg_1:String)
        {
            super(null, null);
            this._type = _arg_1;
        }
        public function get type():String
        {
            return (this._type);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectVisibilityUpdateMessage = "_-1ye" (String#18914, DoABC#2)
// ROVUM_ENABLED = "_-0f3" (String#15631, DoABC#2)
// ROVUM_DISABLED = "_-18v" (String#16811, DoABC#2)


