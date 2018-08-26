
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _signType:int;

        public function RoomObjectAvatarSignUpdateMessage(_arg_1:int)
        {
            this._signType = _arg_1;
        }
        public function get _SafeStr_7649():int
        {
            return (this._signType);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarSignUpdateMessage = "_-V" (String#23446, DoABC#2)
// _signType = "_-5W" (String#7771, DoABC#2)
// _SafeStr_7649 = "package" (String#46219, DoABC#2)


