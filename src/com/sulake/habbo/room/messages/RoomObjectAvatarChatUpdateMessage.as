
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _numberOfWords:int;

        public function RoomObjectAvatarChatUpdateMessage(_arg_1:int)
        {
            this._numberOfWords = _arg_1;
        }
        public function get numberOfWords():int
        {
            return (this._numberOfWords);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarChatUpdateMessage = "_-08" (String#14365, DoABC#2)
// numberOfWords = "_-33I" (String#21633, DoABC#2)
// _numberOfWords = "_-mA" (String#24116, DoABC#2)


