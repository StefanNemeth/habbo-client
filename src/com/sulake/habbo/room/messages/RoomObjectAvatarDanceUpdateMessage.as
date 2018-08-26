
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _danceStyle:int;

        public function RoomObjectAvatarDanceUpdateMessage(_arg_1:int=0)
        {
            this._danceStyle = _arg_1;
        }
        public function get danceStyle():int
        {
            return (this._danceStyle);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarDanceUpdateMessage = "_-MT" (String#23103, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)


