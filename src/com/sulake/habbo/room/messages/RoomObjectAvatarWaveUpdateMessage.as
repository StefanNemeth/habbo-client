
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarWaveUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isWaving:Boolean = false;

        public function RoomObjectAvatarWaveUpdateMessage(_arg_1:Boolean=false)
        {
            this._isWaving = _arg_1;
        }
        public function get isWaving():Boolean
        {
            return (this._isWaving);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarWaveUpdateMessage = "_-0XU" (String#15334, DoABC#2)
// _isWaving = "_-0lR" (String#1542, DoABC#2)
// isWaving = "_-0Ph" (String#15050, DoABC#2)


