
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isSleeping:Boolean;

        public function RoomObjectAvatarSleepUpdateMessage(_arg_1:Boolean=false)
        {
            this._isSleeping = _arg_1;
        }
        public function get isSleeping():Boolean
        {
            return (this._isSleeping);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarSleepUpdateMessage = "_-0Hl" (String#14746, DoABC#2)
// _isSleeping = "_-2EU" (String#882, DoABC#2)
// isSleeping = "_-sI" (String#24373, DoABC#2)


