
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _value:int;

        public function RoomObjectAvatarPlayerValueUpdateMessage(_arg_1:int)
        {
            this._value = _arg_1;
        }
        public function get value():int
        {
            return (this._value);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarPlayerValueUpdateMessage = "_-0X2" (String#15316, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)


